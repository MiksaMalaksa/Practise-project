import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final Color color;

  const AddButton({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}