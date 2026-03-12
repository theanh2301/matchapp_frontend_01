import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../../config/home_config.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 80), // Bottom padding lớn để chừa chỗ cho card đè lên
      decoration: const BoxDecoration(
        color: AppColors.headerBlue,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Xin chào, ${HomeConfig.userName}! 👋",
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text(HomeConfig.userLevel,
                      style: TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
              CircleAvatar(
                backgroundColor: Colors.white24,
                child: IconButton(icon: const Icon(Icons.notifications_none, color: Colors.white), onPressed: () {}),
              )
            ],
          ),
          const SizedBox(height: 20),
          // Stats Row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15), // Mờ hơn chút để giống ảnh
              borderRadius: BorderRadius.circular(16),
            ),
            child: IntrinsicHeight( // Giúp đường kẻ dọc có chiều cao bằng cha
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Căn đều
                children: [
                  _buildStatItem(Icons.local_fire_department_rounded, AppColors.orangeFire, HomeConfig.streakDays, "Chuỗi liên tiếp"),

                  // ĐƯỜNG KẺ DỌC MỜ
                  VerticalDivider(color: Colors.white.withOpacity(0.3), thickness: 1, width: 30),

                  _buildStatItem(Icons.star_rounded, AppColors.goldXP, HomeConfig.currentXP, "Điểm hôm nay"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, Color iconColor, String title, String sub) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
            Text(sub, style: const TextStyle(color: Colors.white70, fontSize: 11)),
          ],
        )
      ],
    );
  }
}