import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../config/home_config.dart';
import 'home/home_tab.dart';
import 'study/study_screen.dart';
import 'practice/practice_screen.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;
  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomeTab(),
    const StudyScreen(),
    const PracticeScreen(),
    const Center(child: Text("Tiến độ")),
    const Center(child: Text("Cá nhân")),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void switchTab(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: IndexedStack(index: _currentIndex, children: _pages),

      // SỬ DỤNG BOTTOM NAVIGATION BAR THUẦN TÚY ĐỂ GIỐNG ẢNH NHẤT
      // NavigationBar của Material 3 đôi khi mặc định quá to, dùng cái cũ dễ chỉnh hơn
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))
          ],
        ),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: switchTab,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.headerBlue,
            unselectedItemColor: Colors.grey.shade400,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            elevation: 0,
            items: HomeConfig.bottomNavItems.asMap().entries.map((entry) {
              int idx = entry.key;
              Map item = entry.value;
              bool isSelected = _currentIndex == idx;

              return BottomNavigationBarItem(
                // LOGIC VIÊN THUỐC BAO QUANH ICON
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.navSelectedBg : Colors.transparent, // Nền xanh nhạt khi chọn
                    borderRadius: BorderRadius.circular(16), // Bo tròn viên thuốc
                  ),
                  child: Icon(item['icon'], size: 24),
                ),
                label: item['label'],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}