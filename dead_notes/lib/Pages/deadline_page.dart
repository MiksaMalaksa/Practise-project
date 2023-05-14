import 'package:flutter/material.dart';

class DeadlinePage extends StatefulWidget {
  const DeadlinePage({super.key});

  @override
  State<DeadlinePage> createState() => _DeadlinePageState();
}

class _DeadlinePageState extends State<DeadlinePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Deadline"),
    );
  }
}
