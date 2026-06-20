import 'package:flutter/material.dart';
import 'package:flutter_2501045/models/book.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: use_key_in_widget_constructors
class BookScreen extends StatelessWidget {
  final List<Book> books = [
    Book(
      title: "나의 첫 번째 부동산 교과서",
      author: "송희구",
      rating: 5,
      coverUrl: "assets/na.jpg",
      releaseDate: "2026.06.23",
      buyUrl:
          "https://search.shopping.naver.com/book/catalog/60262572668?cat_id=50005836&frm=PBOKHIT&query=%EC%9D%B4%EB%8B%AC%EC%9D%98+%EB%8F%84%EC%84%9C&NaPm=ct%3Dmqcylkb4%7Cci%3D114416e912b68a5fba396b65a1bc4f30a690fb1b%7Ctr%3Dboknx%7Csn%3D95694%7Chk%3D7b278870259e02b9fa0e9bf43f17a32d6a6dae89",
      publishedDate: "서삼독",
    ),
    Book(
      title: "부의 갈림길",
      author: "오건영",
      rating: 4.5,
      coverUrl: "assets/boo.jpg",
      releaseDate: "2026.06.10",
      buyUrl:
          "https://search.shopping.naver.com/book/catalog/60262572617?query=%EC%9D%B4%EB%8B%AC%EC%9D%98%20%EB%8F%84%EC%84%9C&NaPm=ct%3Dmqcywysw%7Cci%3Db168fc579adc78067bfed79c0c45bef271c7d20d%7Ctr%3Dboksl%7Csn%3D95694%7Chk%3D332c94fa9eb5245abd6a4f5339f243d2b9870008",
      publishedDate: "포레스트북스",
    ),
    Book(
      title: "다시 만난 세계",
      author: "김희교",
      rating: 4.5,
      coverUrl: "assets/dasi.jpg",
      releaseDate: "2026.06.01",
      buyUrl:
          "https://search.shopping.naver.com/book/catalog/60219525336?query=%EC%9D%B4%EB%8B%AC%EC%9D%98%20%EB%8F%84%EC%84%9C&NaPm=ct%3Dmqcyyxsg%7Cci%3Df17b150c9694322b3067b0d94bcdbb711f60beef%7Ctr%3Dboksl%7Csn%3D95694%7Chk%3Dd29175d240c3a294ecc1b371d2e02d384472fc0d",
      publishedDate: "푸른숲",
    ),
    Book(
      title: "리치먼드힐의 이층 버스",
      author: "이경진",
      rating: 4.86,
      coverUrl: "assets/rech.jpg",
      releaseDate: "2026.06.10",
      buyUrl:
          "https://search.shopping.naver.com/book/catalog/60219525336?query=%EC%9D%B4%EB%8B%AC%EC%9D%98%20%EB%8F%84%EC%84%9C&NaPm=ct%3Dmqcyyxsg%7Cci%3Df17b150c9694322b3067b0d94bcdbb711f60beef%7Ctr%3Dboksl%7Csn%3D95694%7Chk%3Dd29175d240c3a294ecc1b371d2e02d384472fc0d",
      publishedDate: "북플레저",
    ),
    Book(
      title: "하마터면 나로 살지 못할 뻔했다",
      author: "황양밍,장린린 / 번역: 권소현",
      rating: 5.0,
      coverUrl: "assets/hama.jpg",
      releaseDate: "2026.06.20",
      buyUrl:
          "https://search.shopping.naver.com/book/catalog/60130728076?query=%EC%9D%B4%EB%8B%AC%EC%9D%98%20%EB%8F%84%EC%84%9C&NaPm=ct%3Dmqcz3byw%7Cci%3Deaf1907bc04d9fdfd581855c9005fe9be79a9de1%7Ctr%3Dboksl%7Csn%3D95694%7Chk%3D60b9b7decc1a5a6cee5f62092e38142a0eff4caa",
      publishedDate: "미디어숲",
    ),
    Book(
      title: "품격 있는 대화를 위한 지식 브리핑",
      author: "김진",
      rating: 4.84,
      coverUrl: "assets/poom.jpg",
      releaseDate: "2026.05.06",
      buyUrl:
          "https://search.shopping.naver.com/book/catalog/59942739362?cat_id=50005775&frm=PBOKHIT&query=%EC%9D%B4%EB%8B%AC%EC%9D%98+%EB%8F%84%EC%84%9C&NaPm=ct%3Dmqcyntbs%7Cci%3Dd9ea5a18bbd8a88ed095f4297339941d6096ca54%7Ctr%3Dboknx%7Csn%3D95694%7Chk%3De66676bfed25347de08269988166b4ef22774a0f",
      publishedDate: "북플레저",
    ),
  ];

  Widget buildBookCard(Book book) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. 사진 영역
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  book.coverUrl,
                  width: 70,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15), // 가로 간격 추가
              // 2. 글씨 영역
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text("저자: ${book.author}"),
                    Text("평점: ⭐ ${book.rating}"),
                    Text("출판사: ${book.publishedDate}"),

                    const SizedBox(height: 10),
                    // 제미나이: 버튼의 크기를 줄이기 위해 내부 패딩 제거
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 20),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () async {
                        final Uri url = Uri.parse(book.buyUrl);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      },
                      child: const Text("구매하기"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("이달의 도서")),
      body: MasonryGridView.count(
        crossAxisCount: 2, // 2열
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        itemCount: books.length,
        itemBuilder: (context, index) {
          return buildBookCard(books[index]);
        },
      ),
    );
  }
}
