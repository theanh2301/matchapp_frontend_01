import 'dart:convert';
import 'dart:io'; // Import thư viện này để bắt lỗi SocketException (mất mạng)
import 'package:http/http.dart' as http;

class AuthService {
  // Lưu ý: Nếu chạy máy thật, hãy đổi 10.0.2.2 thành IP máy tính (ví dụ 192.168.1.x)
  static const String baseUrl = "http://10.0.2.2:8080/api/user";

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      ).timeout(const Duration(seconds: 10)); // Thêm timeout 10 giây

      print("LOGIN STATUS: ${response.statusCode}");
      return {
        "status": response.statusCode,
        "data": jsonDecode(response.body),
      };
    } on SocketException {
      // Lỗi này xảy ra khi không tìm thấy server hoặc mất mạng
      return {"status": 500, "message": "Không thể kết nối đến Server. Vui lòng kiểm tra Internet!"};
    } catch (e) {
      return {"status": 500, "message": "Lỗi hệ thống: $e"};
    }
  }

  Future<Map<String, dynamic>> register(String fullName, String email, String password, String confirmPassword) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "fullName": fullName,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
        }),
      ).timeout(const Duration(seconds: 10));

      print("REGISTER STATUS: ${response.statusCode}");
      print("REGISTER BODY: '${response.body}'"); // In ra để kiểm tra xem có rỗng thật không

      dynamic responseData;
      if (response.body.isEmpty) {
        responseData = {"message": "Đăng ký thành công"}; // Tự tạo message để App không bị null
      } else {
        // Nếu có body thì mới decode
        try {
          responseData = jsonDecode(response.body);
        } catch (e) {
          // Trường hợp server trả về text thường (không phải JSON)
          responseData = {"message": response.body};
        }
      }

      return {
        "status": response.statusCode,
        "data": responseData,
      };
      // -----------------------

    } on SocketException {
      return {"status": 500, "message": "Không thể kết nối đến Server. Vui lòng kiểm tra Internet!"};
    } catch (e) {
      return {"status": 500, "message": "Lỗi hệ thống: $e"};
    }
    }
  }