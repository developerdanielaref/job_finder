import 'package:flutter/material.dart';
import 'job_finder_screen.dart';

void main() {
  runApp(JobFinderApp());
}

class JobFinderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JobFinderScreen(),
    );
  }
}
