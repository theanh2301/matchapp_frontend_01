import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Luyện tập"), backgroundColor: AppColors.cardPurple, foregroundColor: Colors.white),
      body: const Center(child: Text("Nội dung luyện tập")),
    );
  }
}