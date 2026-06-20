import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'company_info_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userEmail = "로딩 중...";
  String _userNickname = "사용자 닉네임";

  // 제미나이: initState()를 통해 로컬 저장소에서 사용자 이메일과 닉네임 정보를 비동기로 불러와 초기 상태를 설정
  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  // 이메일과 닉네임 모두 로드
  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userEmail = prefs.getString('user_email') ?? "이메일 정보 없음";
      _userNickname = prefs.getString('user_nickname') ?? "사용자 닉네임";
    });
  }

  // 닉네임 수정 함수
  Future<void> _updateNickname(String newNickname) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_nickname', newNickname);
    setState(() {
      _userNickname = newNickname;
    });
  }

  // 제미나이: AlertDialog와 TextEditingController를 사용하여 닉네임 수정 기능을 구현하고, 수정 즉시 SharedPreferences에 반영하여 사용자 데이터를 동기화
  void _showEditNicknameDialog() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "프로필",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 173, 207),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          // 1. 프로필 상단 영역
          Container(
            padding: const EdgeInsets.all(20),
            color: const Color.fromARGB(255, 0, 173, 207),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Colors.blueGrey),
                ),
                const SizedBox(height: 15),
                Text(
                  _userNickname,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _userEmail,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          // 2. 메뉴 리스트 (빠졌던 메뉴들 모두 포함)
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("회원 정보 수정"),
            onTap: () => _showEditNicknameDialog(),
          ),
          ListTile(
            leading: const Icon(Icons.rate_review),
            title: const Text("내 리뷰 관리"),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("설정"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text("고객센터"),
            onTap: () {
              // 회사 소개 및 고객센터 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CompanyInfoPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("로그아웃", style: TextStyle(color: Colors.red)),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('user_email');
              await prefs.remove('user_nickname'); // 닉네임도 같이 삭제

              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  // 제미나이: 로그아웃 버튼 클릭 시 로컬 저장소의 사용자 정보를 삭제하고, Navigator.pushNamedAndRemoveUntil을 통해 로그인 화면으로 초기화 및 이동
                  context,
                  '/',
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
