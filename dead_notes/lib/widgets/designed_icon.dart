import 'package:flutter/material.dart';

class DesignedIcon extends StatelessWidget {
  final String assetPath;
  final Color color;
  final double? size;

  const DesignedIcon({
    Key? key,
    required this.assetPath,
    this.color = const Color.fromARGB(255, 101, 168, 201),
    this.size = 35.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      AssetImage(assetPath),
      color: color,
      size: size,
    );
  }
}