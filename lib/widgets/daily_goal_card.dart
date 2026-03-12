import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../config/home_config.dart';

class DailyGoalCard extends StatelessWidget {
  const DailyGoalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Mục tiêu hôm nay", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(HomeConfig.goalText, style: TextStyle(color: AppColors.headerBlue, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: HomeConfig.goalProgress,
              backgroundColor: AppColors.bgLight,
              color: AppColors.headerBlue,
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          const Text(HomeConfig.goalSubText, style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
        ],
      ),
    );
  }
}