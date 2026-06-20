import 'package:flutter/material.dart';

class CompanyInfoPage extends StatelessWidget {
  const CompanyInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "고객센터 및 회사 소개",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 173, 207),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "회사 소개",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const Text(
              "리모(REMO)는 '리뷰 모아'의 줄임말로, "
              "도서, 영화, 전시회, 공연 등 방대하게 흩어진 문화 콘텐츠의 리뷰를 한곳에 모아 사용자에게 최상의 편리함을 제공하는 서비스입니다.\n\n"
              "다양한 플랫폼을 일일이 방문해야 하는 번거로움을 해결하고, 사용자가 더욱 쉽고 명확하게 콘텐츠를 선택할 수 있도록 돕습니다. "
              "리모는 여러분의 선택의 폭을 넓히고, 문화 생활을 통해 일상을 더욱 풍요롭게 만들기 위해 끊임없이 노력하겠습니다.",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const Divider(height: 60), // 선 추가
            const Text(
              "고객 지원",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const ListTile(
              leading: Icon(Icons.email),
              title: Text("문의 이메일"),
              subtitle: Text("support@company.com"),
            ),
            const SizedBox(height: 10),
            const ListTile(
              leading: Icon(Icons.phone),
              title: Text("고객센터 전화번호"),
              subtitle: Text("02-1234-5678"),
            ),
            const SizedBox(height: 10),
            const ListTile(
              leading: Icon(Icons.access_time),
              title: Text("운영 시간"),
              subtitle: Text("평일 09:00 ~ 18:00 (주말/공휴일 휴무)"),
            ),
          ],
        ),
      ),
    );
  }
}
