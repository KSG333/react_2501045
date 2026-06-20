import 'package:flutter/material.dart';
import 'package:flutter_2501045/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  // 1. 함수를 정수로 받도록 수정
  final Function(int) onMenuSelected;

  const CustomDrawer({super.key, required this.onMenuSelected});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String _userEmail = "로딩 중...";
  String _userNickname = "사용자 닉네임";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('user_email') ?? "로그인이 필요합니다";
    String nickname = prefs.getString('user_nickname') ?? "사용자 닉네임";

    if (mounted) {
      setState(() {
        _userEmail = email;
        _userNickname = nickname;
      });
    }
  }

  Future<void> _updateNickname(String newNickname) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_nickname', newNickname);
    if (mounted) {
      setState(() {
        _userNickname = newNickname;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 0, 173, 207),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.blueGrey),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => _showEditNicknameDialog(context),
                  child: Row(
                    children: [
                      Text(
                        _userNickname,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(Icons.edit, color: Colors.white70, size: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(_userEmail, style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),

          // 제미나이: 각 메뉴 호출부 (인덱스 번호는 HomePage의 pages 리스트와 일치해야 함)
          _buildMenuItem(Icons.home, '홈', 0),
          _buildMenuItem(Icons.book, '이달의 도서', 1),
          _buildMenuItem(Icons.movie, '이달의 영화', 2),
          _buildMenuItem(Icons.museum, '이달의 전시회', 3),
          _buildMenuItem(Icons.music_note, '이달의 공연', 4),
          _buildMenuItem(Icons.card_giftcard, '혜택 및 이벤트', 5),
          _buildMenuItem(Icons.star, '회원혜택', 6),
          _buildMenuItem(Icons.headset_mic, '고객센터', 7),
          _buildMenuItem(Icons.settings, '설정', 8),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('로그아웃', style: TextStyle(color: Colors.red)),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('user_email');
              await prefs.remove('user_nickname');
              if (context.mounted) {
                // 로그인 화면으로 이동
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        widget.onMenuSelected(index); // 상위 페이지로 선택된 번호 전달
        Navigator.pop(context); // Drawer 닫기
      },
    );
  }

  void _showEditNicknameDialog(BuildContext context) {
    TextEditingController controller = TextEditingController(
      text: _userNickname,
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("닉네임 수정"),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: "새 닉네임을 입력하세요"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("취소"),
          ),
          TextButton(
            onPressed: () {
              _updateNickname(controller.text);
              Navigator.pop(context);
            },
            child: const Text("저장"),
          ),
        ],
      ),
    );
  }
}
