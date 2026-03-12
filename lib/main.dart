import 'package:flutter/material.dart';
// Import đường dẫn chính xác tới file splash_screen của bạn
import 'screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Tắt banner debug "slow mode" ở góc phải
      debugShowCheckedModeBanner: false,

      title: 'MathJoy',

      // Cấu hình Theme chung cho toàn app
      theme: ThemeData(
        // Dùng màu tím làm màu chủ đạo (khớp với thiết kế)
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7C3AED)),
        useMaterial3: true,
        fontFamily: 'Roboto', // Hoặc font bạn thích

        // Làm đẹp input field mặc định (tuỳ chọn)
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF7C3AED), width: 2),
          ),
        ),
      ),

      // Màn hình đầu tiên chạy lên là Splash
      home: const SplashScreen(),
    );
  }
}
