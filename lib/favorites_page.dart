import 'package:flutter/material.dart';
import 'review_page.dart';
import 'custom_app_bar.dart';

class FavoriteScreen extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteList;
  final Function(Map<String, dynamic>) onRemoveFavorite;
  final VoidCallback onBackToHome; // 제미나이: 홈으로 돌아가는 함수 추가

  const FavoriteScreen({
    super.key,
    required this.favoriteList,
    required this.onRemoveFavorite,
    required this.onBackToHome,
  });

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "즐겨찾기",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 173, 207),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: widget.onBackToHome, // 버튼 클릭 시 홈으로 이동
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white), // 흰색 아이콘
              onPressed: () {
                Scaffold.of(context).openEndDrawer(); // EndDrawer 열기
              },
            ),
          ),
        ],
      ),
      endDrawer: CustomDrawer(onMenuSelected: (int p1) {}),
      body: widget.favoriteList.isEmpty
          ? const Center(child: Text("즐겨찾기한 항목이 없습니다."))
          : ListView.builder(
              itemCount: widget.favoriteList.length,
              itemBuilder: (context, index) {
                final item = widget.favoriteList[index];
                // 제미나이: 2. 이미지 경로 강제 보정 (assets/ 가 중복되지 않게 처리)
                String imgPath = item['img'] ?? '';
                if (imgPath.startsWith('assets/assets/')) {
                  imgPath = imgPath.replaceFirst('assets/', '');
                } else if (!imgPath.startsWith('assets/')) {
                  imgPath = 'assets/$imgPath';
                }
                return ListTile(
                  leading: Image.asset(
                    imgPath, // 보정된 경로 사용
                    width: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image),
                  ),
                  title: Text(item['title'] ?? '제목 없음'),
                  subtitle: Text(item['category'] ?? '카테고리 없음'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewPage(
                          bookData: item,
                          isFavorite: true,
                          onAddFavorite: (favItem) {
                            widget.onRemoveFavorite(favItem);
                            if (mounted) setState(() {});
                          },
                        ),
                      ),
                    ).then((_) {
                      // 제미나이: 상세 페이지에서 돌아왔을 때 리스트 갱신
                      if (mounted) setState(() {});
                    });
                  },
                );
              },
            ),
    );
  }
}
