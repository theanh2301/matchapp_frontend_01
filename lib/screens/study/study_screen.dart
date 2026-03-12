import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class StudyScreen extends StatelessWidget {
  const StudyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Học bài mới"), backgroundColor: AppColors.cardGreen, foregroundColor: Colors.white),
      body: const Center(child: Text("Nội dung bài học")),
    );
  }
}