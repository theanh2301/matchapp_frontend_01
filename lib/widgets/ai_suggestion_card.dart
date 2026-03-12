import 'package:flutter/material.dart';

class AiSuggestionCard extends StatelessWidget {
  const AiSuggestionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24), // Padding lớn
      decoration: BoxDecoration(
        // Gradient chuẩn từ ảnh: Hồng (#FF4081) -> Tím (#AA00FF)
        gradient: const LinearGradient(
          colors: [Color(0xFFFF4081), Color(0xFFA855F7)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(28), // Bo góc rất tròn
        boxShadow: [
          BoxShadow(color: const Color(0xFFFF4081).withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 8)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon não bộ
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.psychology, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.lightbulb, color: Colors.yellowAccent, size: 20),
                    SizedBox(width: 8),
                    Text("AI gợi ý cho bạn", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "Bạn nên ôn lại Hệ phương trình vì độ chính xác giảm 15% so với tuần trước.",
                  style: TextStyle(color: Colors.white.withOpacity(0.95), fontSize: 13, height: 1.4),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}