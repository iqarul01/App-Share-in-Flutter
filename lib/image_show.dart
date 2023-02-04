// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'dart:io';

class ImageShowcase extends StatelessWidget {
  final List<String> imagePaths;
  final Function(int) onDelete;
  const ImageShowcase({
    Key? key,
    required this.imagePaths,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageWidget = <Widget>[];
    for (var i = 0; i < imagePaths.length; i++) {
      imageWidget.add(SingleImage(
        imagePath: imagePaths[i],
        onDelete: onDelete != null ? () => onDelete(i) : null,
      ));
    }
    if (imagePaths.isEmpty) {
      return Container();
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: imageWidget,
      ),
    );
  }
}

class SingleImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onDelete;
  const SingleImage(
      {super.key, required this.imagePath, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: FloatingActionButton(
                  onPressed: onDelete,
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.delete),
                ),
              ))
        ],
      ),
    );
  }
}
