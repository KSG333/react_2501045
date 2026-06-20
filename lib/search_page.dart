import 'package:flutter/material.dart';
import 'review_page.dart';
import 'custom_app_bar.dart';

class SearchPage extends StatefulWidget {
  final VoidCallback onBackToHome;
  // 제미나이: 메뉴 선택 시 인덱스를 상위 페이지로 전달하는 콜백
  final Function(int) onMenuSelectedFromSearch;
  final List<Map<String, dynamic>> allData;
  final List<Map<String, dynamic>> favoriteList;
  final Function(Map<String, dynamic>) onToggleFavorite;
  final String userEmail;

  const SearchPage({
    super.key,
    required this.onBackToHome,
    required this.onMenuSelectedFromSearch,
    required this.allData,
    required this.favoriteList,
    required this.onToggleFavorite,
    required this.userEmail,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    // 제미나이: 사용자의 검색어(_searchQuery) 입력을 감지하고, allData를 실시간으로 필터링하여 제목(title) 또는 카테고리(category)에 일치하는 결과만 렌더링하는 검색 로직 구현
    final filteredData = widget.allData.where((item) {
      final title = item['title'].toString().toLowerCase();
      final category = item['category'].toString().toLowerCase();
      final search = _searchQuery.toLowerCase();
      return title.contains(search) || category.contains(search);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 173, 207),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => widget.onBackToHome(),
        ),
        title: const Text(
          "통합 검색",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: CustomDrawer(
        onMenuSelected: (int index) {
          // 제미나이: 상위(MainNavigation 또는 HomePage)에서 전달받은 콜백을 실행하여 데이터 일관성 유지
          widget.onMenuSelectedFromSearch(index);
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 13),
            child: TextField(
              decoration: const InputDecoration(
                labelText: "작품명이나 카테고리를 검색하세요",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                final item = filteredData[index];
                // 제미나이: isFav 변수 사용하여 사용자가 즐겨찾기를 누르고 돌아왔을 때, 상태가 즉시 반영되도록 보장
                final bool isFav = widget.favoriteList.any(
                  (fav) => fav['title'] == item['title'],
                );

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 5,
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 50,
                      height: 100,
                      child: Image.asset(item['img']!, fit: BoxFit.cover),
                    ),
                  ),
                  title: Text(
                    item['title'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item['category'] ?? ''),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReviewPage(
                          bookData: item,
                          isFavorite: isFav,
                          onAddFavorite: (updatedItem) =>
                              widget.onToggleFavorite(updatedItem),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
