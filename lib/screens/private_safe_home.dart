import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PrivateSafeHomeScreen extends StatefulWidget {
  const PrivateSafeHomeScreen({super.key});

  @override
  State<PrivateSafeHomeScreen> createState() =>
      _PrivateSafeHomeScreenState();
}

class _PrivateSafeHomeScreenState
    extends State<PrivateSafeHomeScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<File> _files = [];
  final Set<int> _selected = {};
  bool _selectionMode = false;

  Future<void> _addMedia() async {
    final files = await _picker.pickMultipleMedia();
    if (files.isEmpty) return;

    setState(() {
      _files.addAll(files.map((e) => File(e.path)));
    });
  }

  void _toggleSelect(int index) {
    setState(() {
      if (_selected.contains(index)) {
        _selected.remove(index);
      } else {
        _selected.add(index);
      }
      if (_selected.isEmpty) _selectionMode = false;
    });
  }

  void _deleteSelected() {
    setState(() {
      final sorted = _selected.toList()..sort((a, b) => b - a);
      for (final i in sorted) {
        _files.removeAt(i);
      }
      _selected.clear();
      _selectionMode = false;
    });
  }

  void _openViewer(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _FullScreenViewer(
          files: _files,
          startIndex: index,
          onDelete: (i) {
            setState(() {
              _files.removeAt(i);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text("Private Safe 🔒"),
        actions: [
          if (_selectionMode)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _deleteSelected,
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        onPressed: _addMedia,
        child: const Icon(Icons.add),
      ),
      body: _files.isEmpty
          ? const Center(
              child: Text(
                "No private memories yet 💕\nTap + to add",
                textAlign: TextAlign.center,
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _files.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (_, i) {
                final selected = _selected.contains(i);
                return GestureDetector(
                  onLongPress: () {
                    setState(() {
                      _selectionMode = true;
                      _selected.add(i);
                    });
                  },
                  onTap: () {
                    if (_selectionMode) {
                      _toggleSelect(i);
                    } else {
                      _openViewer(i);
                    }
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(
                          _files[i],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      if (selected)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.pink.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

/// FULL SCREEN VIEWER
class _FullScreenViewer extends StatefulWidget {
  final List<File> files;
  final int startIndex;
  final Function(int) onDelete;

  const _FullScreenViewer({
    required this.files,
    required this.startIndex,
    required this.onDelete,
  });

  @override
  State<_FullScreenViewer> createState() => _FullScreenViewerState();
}

class _FullScreenViewerState extends State<_FullScreenViewer> {
  late PageController _controller;
  late int _current;

  @override
  void initState() {
    super.initState();
    _current = widget.startIndex;
    _controller = PageController(initialPage: _current);
  }

  void _deleteCurrent() {
    if (widget.files.isEmpty) return;

    final deletedIndex = _current;

    // delete from parent list
    widget.onDelete(deletedIndex);

    if (widget.files.isEmpty) {
      // no media left → exit viewer
      Navigator.pop(context);
      return;
    }

    setState(() {
      // adjust index safely
      if (_current >= widget.files.length) {
        _current = widget.files.length - 1;
      }

      _controller.jumpToPage(_current);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteCurrent,
          ),
        ],
      ),
      body: PageView.builder(
        controller: _controller,
        itemCount: widget.files.length,
        onPageChanged: (i) => _current = i,
        itemBuilder: (_, i) {
          return Center(
            child: Image.file(
              widget.files[i],
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }
}
