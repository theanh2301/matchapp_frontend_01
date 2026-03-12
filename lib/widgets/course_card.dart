import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class CourseCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const CourseCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: data['cardBgColor'], // Lấy màu nền xanh nhạt/lá nhạt từ config
        borderRadius: BorderRadius.circular(24),
        // Bỏ viền border để giống ảnh hơn, chỉ giữ màu nền
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // TAG NỀN TRẮNG
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6), // Trắng mờ nhẹ
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                    data['tag'],
                    style: TextStyle(
                        color: data['tagTextColor'],
                        fontWeight: FontWeight.w800,
                        fontSize: 11
                    )
                ),
              ),
              Text(
                  "${(data['progress'] * 100).toInt()}%",
                  style: TextStyle(
                    // Màu phần trăm trùng với màu chữ của tag cho đồng bộ
                      color: data['tagTextColor'],
                      fontWeight: FontWeight.bold, fontSize: 13
                  )
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(data['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: AppColors.textDark)),
          const SizedBox(height: 6),
          Text(data['lesson'], style: const TextStyle(color: AppColors.textGrey, fontSize: 14)),
        ],
      ),
    );
  }
}