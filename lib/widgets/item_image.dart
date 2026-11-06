import 'package:flutter/material.dart';

class ItemImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;

  const ItemImage({
    super.key,
    required this.path,
    this.width,
    this.height,
  });

  bool get _isNetwork => path.startsWith('http');

  @override
  Widget build(BuildContext context) {
    final fallback = Container(
      width: width,
      height: height,
      color: Colors.grey.shade300,
      child: const Icon(Icons.image_not_supported, color: Colors.grey),
    );

    if (_isNetwork) {
      return Image.network(
        path,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => fallback,
      );
    }
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => fallback,
    );
  }
}