import 'package:flutter/material.dart';
import 'package:learn_math_app_01/screens/main_screen.dart';
import '../../service/auth_service.dart';
import '../../widgets/robot_mascot.dart';
import '../../theme/app_colors.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  bool _obscureText = true;
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  // Khởi tạo Service
  final AuthService _authService = AuthService();

  // --- LOGIC XỬ LÝ CHÍNH ---
  void _handleAuth() async {
    FocusScope.of(context).unfocus(); // Ẩn bàn phím

    // 1. Validate dữ liệu
    if (_emailController.text.isEmpty || _passController.text.isEmpty) {
      _showSnackBar("Vui lòng nhập đầy đủ thông tin", Colors.red);
      return;
    }

    if (!isLogin) {
      if (_nameController.text.isEmpty) {
        _showSnackBar("Vui lòng nhập họ tên", Colors.red);
        return;
      }
      if (_passController.text != _confirmPassController.text) {
        _showErrorDialog("Mật khẩu xác nhận không khớp!");
        return;
      }
    }

    setState(() => _isLoading = true);

    Map<String, dynamic> result;

    // 2. Gọi API
    if (isLogin) {
      result = await _authService.login(
          _emailController.text,
          _passController.text
      );
    } else {
      result = await _authService.register(
          _nameController.text,
          _emailController.text,
          _passController.text,
          _confirmPassController.text
      );
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }

    // 3. Xử lý kết quả (PHẦN QUAN TRỌNG ĐÃ SỬA)
    if (result['status'] == 200 || result['status'] == 201) {

      if (isLogin) {
        _showSnackBar("Đăng nhập thành công!", Colors.green);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainScreen()));
      } else {
        _showSnackBar("Đăng ký thành công! Vui lòng đăng nhập.", Colors.green);

        setState(() {
          isLogin = true;
          _passController.clear();
          _confirmPassController.clear();
        });
      }

    } else {
      // Xử lý lỗi
      String errorMsg = result['message'] ?? "Có lỗi xảy ra";
      if (result['data'] != null && result['data']['message'] != null) {
        errorMsg = result['data']['message'];
      }
      _showErrorDialog(errorMsg);
    }
  }

  // Hàm hiển thị thông báo nhỏ (SnackBar)
  void _showSnackBar(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: color),
    );
  }

  // Hàm hiển thị thông báo lỗi lớn (Dialog)
  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red),
            SizedBox(width: 10),
            Text("Thông báo", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(msg, style: const TextStyle(fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Đóng", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.bgLight, AppColors.robotMouthBgLight, AppColors.white],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
            child: Column(
              children: [
                // LOGO ROBOT
                const SizedBox(
                  height: 120,
                  child: RobotMascot(size: 90, isWhiteStyle: false),
                ),

                const SizedBox(height: 40),

                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildToggleSwitch(),
                      const SizedBox(height: 30),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: Column(
                          children: [
                            if (!isLogin) ...[
                              _buildTextField(
                                  controller: _nameController,
                                  icon: Icons.person_outline,
                                  hint: "Họ và tên"
                              ),
                              const SizedBox(height: 16),
                            ],

                            _buildTextField(
                                controller: _emailController,
                                icon: Icons.email_outlined,
                                hint: "Email"
                            ),
                            const SizedBox(height: 16),

                            _buildTextField(
                                controller: _passController,
                                icon: Icons.lock_outline,
                                hint: "Mật khẩu",
                                isPassword: true
                            ),

                            if (!isLogin) ...[
                              const SizedBox(height: 16),
                              _buildTextField(
                                  controller: _confirmPassController,
                                  icon: Icons.lock_outline,
                                  hint: "Nhập lại mật khẩu",
                                  isPassword: true
                              ),
                            ],
                          ],
                        ),
                      ),

                      if (isLogin) ...[
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text("Quên mật khẩu?", style: TextStyle(color: AppColors.secondary)),
                          ),
                        ),
                      ] else
                        const SizedBox(height: 24),

                      _buildGradientButton(isLogin ? "Đăng nhập" : "Đăng ký"),

                      const SizedBox(height: 30),

                      _buildDivider(),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(child: _buildSocialButton("Google", Colors.red)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildSocialButton("Facebook", Colors.blue)),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(color: Colors.grey, fontSize: 13, height: 1.5),
                      children: [
                        TextSpan(text: "Bằng cách ${isLogin ? 'đăng nhập' : 'đăng ký'}, bạn đồng ý với "),
                        const TextSpan(
                          text: "Điều khoản",
                          style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: " và "),
                        const TextSpan(
                          text: "Chính sách",
                          style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- CÁC WIDGET CON ---

  // 1. Widget Ô nhập liệu
  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    bool isPassword = false
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? _obscureText : false,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey.shade400),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey),
          onPressed: () => setState(() => _obscureText = !_obscureText),
        )
            : null,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }

  // 2. Widget Nút bấm Gradient
  Widget _buildGradientButton(String text) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [AppColors.gradientStart, AppColors.gradientEnd],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.gradientStart.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          // Nếu đang loading thì disable nút
          onTap: _isLoading ? null : _handleAuth,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: _isLoading
                ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 3. Widget Thanh chuyển đổi (Toggle Switch)
  Widget _buildToggleSwitch() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.bgLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _buildToggleBtn("Đăng nhập", true),
          _buildToggleBtn("Đăng ký", false),
        ],
      ),
    );
  }

  // 4. Widget Nút con trong Toggle
  Widget _buildToggleBtn(String text, bool value) {
    final isActive = isLogin == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isLogin = value;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? AppColors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isActive
                ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))]
                : [],
            gradient: isActive
                ? const LinearGradient(colors: [AppColors.gradientEnd, AppColors.gradientStart])
                : null,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive ? AppColors.white : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }

  // 5. Widget Đường kẻ ngang
  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade200)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text("Hoặc tiếp tục với", style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
        ),
        Expanded(child: Divider(color: Colors.grey.shade200)),
      ],
    );
  }

  // 6. Widget Nút mạng xã hội
  Widget _buildSocialButton(String text, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            text == "Google" ? Icons.g_mobiledata : Icons.facebook,
            color: iconColor,
            size: 28,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}