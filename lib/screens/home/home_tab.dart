import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../config/home_config.dart';
import '../../widgets/daily_goal_card.dart';
import '../../widgets/home_header.dart';
import '../../widgets/action_button_card.dart';
import '../../widgets/course_card.dart';
import '../../widgets/ai_suggestion_card.dart';

import '../main_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  // Hàm xử lý chuyển Tab
  void _jumpToTab(int index) {
    // Tìm MainScreenState ở phía trên cây Widget
    final mainScreenState = context.findAncestorStateOfType<MainScreenState>();
    if (mainScreenState != null) {
      mainScreenState.switchTab(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const HomeHeader(),
          Transform.translate(
            offset: const Offset(0, -50),
            child: Column(
              children: [
                const DailyGoalCard(),
                const SizedBox(height: 24),

                // --- PHẦN QUAN TRỌNG: CÁC NÚT BẤM ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: ActionButtonCard(
                          title: "Học bài mới",
                          subtitle: "12 bài đang chờ",
                          color: AppColors.cardGreen,
                          icon: Icons.psychology,
                          onTap: () {
                            // Chuyển sang Tab 1 (Học)
                            _jumpToTab(1);
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ActionButtonCard(
                          title: "Luyện tập",
                          subtitle: "8 bài tập mới",
                          color: AppColors.cardPurple,
                          icon: Icons.bolt,
                          onTap: () {
                            // Chuyển sang Tab 2 (Luyện tập)
                            _jumpToTab(2);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // --------------------------------------

                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tiếp tục học", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textDark)),
                          Icon(Icons.trending_up, color: AppColors.headerBlue),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ...HomeConfig.continuingCourses.map((course) => CourseCard(data: course)),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: AiSuggestionCard(),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}