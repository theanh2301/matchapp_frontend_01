import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class HomeConfig {
  // Dữ liệu Header
  static const String userName = "Minh";
  static const String userLevel = "Lớp 10 • Sẵn sàng học chưa?";
  static const String streakDays = "7 ngày";
  static const String currentXP = "450 XP";

  // Dữ liệu Mục tiêu
  static const double goalProgress = 0.6; // 60%
  static const String goalText = "3/5 bài";
  static const String goalSubText = "Còn 2 bài nữa để hoàn thành mục tiêu!";

  // Dữ liệu Danh sách bài học (Dễ dàng thêm/bớt bài học tại đây)
  static final List<Map<String, dynamic>> continuingCourses = [
    {
      "tag": "ĐẠI SỐ",
      "tagColor": AppColors.white,           // Tag nền trắng
      "tagTextColor": AppColors.headerBlue,  // Chữ xanh
      "cardBgColor": AppColors.mathCardBg,
      "title": "Phương trình bậc 2",
      "lesson": "Bài 3: Công thức nghiệm",
      "progress": 0.7,
    },
    {
      "tag": "HÌNH HỌC",
      "tagColor": AppColors.white,           // Tag nền trắng
      "tagTextColor": Color(0xFF2E7D32),     // Chữ xanh lá
      "cardBgColor": AppColors.geomCardBg,
      "title": "Đường tròn",
      "lesson": "Bài 2: Tiếp tuyến",
      "progress": 0.45,
    },
  ];

  // Menu Bottom Bar
  static const List<Map<String, dynamic>> bottomNavItems = [
    {"icon": Icons.home_rounded, "label": "Trang chủ"}, // Icon nhà tròn
    {"icon": Icons.menu_book_rounded, "label": "Học"},  // Icon sách mở
    {"icon": Icons.bolt_rounded, "label": "Luyện tập"}, // Icon tia sét
    {"icon": Icons.show_chart_rounded, "label": "Tiến độ"}, // Icon biểu đồ
    {"icon": Icons.person_outline_rounded, "label": "Cá nhân"}, // Icon người
  ];
}