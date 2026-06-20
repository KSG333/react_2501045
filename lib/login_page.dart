import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// MainNavigation이 정의된 파일을 import 하세요 (파일 위치에 맞춰 수정)
import 'main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 간편 로그인 버튼 생성 위젯
  Widget _buildSnsButton(String imgUrl, Color bgColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        width: 50,
        height: 50,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          border: bgColor == Colors.white
              ? Border.all(color: Colors.grey.shade300)
              : null,
        ),
        child: Image.asset(imgUrl, fit: BoxFit.cover),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
          child: Column(
            children: [
              const SizedBox(height: 70),
              // 로고
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    "https://cdn-icons-png.flaticon.com/512/10990/10990804.png",
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    "REMO",
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 0, 173, 207),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Image.network(
                    "https://cdn-icons-png.flaticon.com/512/4221/4221419.png",
                    width: 50,
                    height: 50,
                  ),
                ],
              ),
              const SizedBox(height: 70),
              // 입력창들
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: "이메일을 입력하세요",
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  hintText: "비밀번호를 입력하세요",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure
                          ? Icons.visibility_off
                          : Icons
                                .visibility, // 제미나이: 아이콘 클릭 시 비밀번호 글자 유무 확인(visibility)
                    ),
                    onPressed: () => setState(() => _isObscure = !_isObscure),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              // 로그인 버튼
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 173, 207),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {
                    // 제미나이: 1. 데이터 저장(SharedPreferences)
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('user_email', _emailController.text);
                    debugPrint("저장된 이메일: ${_emailController.text}");

                    // 2. MainNavigation으로 이동
                    if (context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainNavigation(),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "로그인",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              // 구분선
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    const Expanded(
                      child: Divider(color: Colors.grey, thickness: 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "간편 로그인",
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ),
                    const Expanded(
                      child: Divider(color: Colors.grey, thickness: 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // SNS 로고들
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSnsButton(
                    "assets/카카오톡_로고.png",
                    const Color(0xFFFFE812),
                  ),
                  _buildSnsButton("assets/네이버_로고.png", const Color(0xFF03C75A)),
                  _buildSnsButton("assets/구글_로고.png", Colors.white),
                  _buildSnsButton("assets/애플_로고.png", Colors.black),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
