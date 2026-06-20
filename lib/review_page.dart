import 'package:flutter/material.dart';
import 'package:flutter_2501045/custom_app_bar.dart';

class ReviewPage extends StatefulWidget {
  final Map<String, dynamic> bookData;
  final bool isFavorite;
  final Function(Map<String, dynamic>) onAddFavorite;

  const ReviewPage({
    super.key,
    required this.bookData,
    required this.isFavorite,
    required this.onAddFavorite,
  });

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late List<Map<String, String>> _reviews;
  final TextEditingController _commentController = TextEditingController();
  double _rating = 0.0;
  late bool isFavorite;

  // 모든 리뷰 데이터
  final Map<String, List<Map<String, String>>> _categoryReviews = {
    "도서": [
      {
        "site": "교보문고",
        "rating": "4.8",
        "comment": "문장이 너무 아름다워서 밑줄을 몇 번이나 그었네요.",
      },
      {
        "site": "예스24",
        "rating": "4.5",
        "comment": "끝까지 몰입해서 읽게 되는 마법 같은 책입니다.",
      },
      {"site": "알라딘", "rating": "4.5", "comment": "처음 도전해보는 장르인데 생각보다 괜찮네요."},
      {
        "site": "알라딘",
        "rating": "5.0",
        "comment": "책 표지가 예뻐서 읽기 시작했는데 내용도 정말 예쁘네요~",
      },
      {"site": "예스24", "rating": "3.5", "comment": "책 내용이 어려워서 이해하기 힘들었어요."},
      {"site": "예스24", "rating": "4.2", "comment": "읽는 내내 힐링되는 기분이었습니다."},
      {"site": "교보문고", "rating": "4.9", "comment": "지인들에게 강력 추천하고 싶은 책이에요."},
    ],
    "영화": [
      {"site": "CGV", "rating": "5.0", "comment": "영상미가 압도적입니다. 극장에서 보길 잘했어요!"},
      {"site": "메가박스", "rating": "4.2", "comment": "스토리 전개가 빨라서 지루할 틈이 없네요."},
      {"site": "CGV", "rating": "4.7", "comment": "인기 많은 이유가 있었네요."},
      {"site": "롯데시네마", "rating": "3.1", "comment": "생각보다 지루해서 실망했습니다."},
      {"site": "메가박스", "rating": "4.7", "comment": "시원시원하고 좋았어요."},
      {"site": "롯데시네마", "rating": "4.5", "comment": "사운드 효과가 훌륭해서 몰입감이 최고입니다."},
      {"site": "메가박스", "rating": "4.0", "comment": "재관람 의사 200%입니다."},
    ],
    "전시회": [
      {
        "site": "네이버",
        "rating": "4.7",
        "comment": "공간 구성이 훌륭하고 사진 찍기 정말 좋았습니다.",
      },
      {
        "site": "예스24 티켓",
        "rating": "4.0",
        "comment": "작품들이 주는 메시지가 깊어서 여운이 남아요.",
      },
      {"site": "멜론티켓", "rating": "5.0", "comment": "조명이랑 작품 배치가 예술이네요."},
      {"site": "멜론티켓", "rating": "4.5", "comment": "해설 가이드 들으면서 보니까 이해가 잘 돼요."},
      {"site": "네이버", "rating": "3.5", "comment": "사람이 좀 많았지만 작품 자체는 만족스럽습니다."},
      {"site": "네이버", "rating": "4.8", "comment": "전시된 작품들이 하나하나 다 감각적이에요."},
    ],
    "공연": [
      {
        "site": "예스24 티켓",
        "rating": "5.0",
        "comment": "배우들의 연기력과 무대 장악력이 최고였어요!",
      },
      {"site": "네이버", "rating": "4.9", "comment": "박수가 멈추지 않는 감동적인 시간이었습니다."},
      {"site": "예스24 티켓", "rating": "4.4", "comment": "마음의 울림이 있는 시간이었습니다."},
      {"site": "네이버", "rating": "3.5", "comment": "공연장이 좁아서 집중이 좀 어려웠네요 ㅠㅠ"},
      {"site": "멜론티켓", "rating": "4.1", "comment": "다른 배우들한테도 입덕하고 갑니다 ㅎㅎ"},
      {
        "site": "예스24 티켓",
        "rating": "5.0",
        "comment": "사랑해요 언니 ㅠㅠ 너무 예쁘세요 정말..",
      },
    ],
  };

  // 제미나이: 위젯 생성 시 전달받은 bookData를 통해 카테고리별 리뷰 데이터를 동적으로 불러오고, shuffle()과 take()를 사용하여 매번 새로운 리뷰가 보여지도록 구성
  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
    String category = widget.bookData['category'] ?? '도서';
    List<Map<String, String>> categoryList = List<Map<String, String>>.from(
      _categoryReviews[category] ?? _categoryReviews['도서']!,
    );
    categoryList.shuffle();
    _reviews = categoryList.take(4).toList();
  }

  Color _getSiteColor(String site) {
    switch (site) {
      case '교보문고':
        return const Color(0xFF00673D);
      case '예스24':
        return const Color.fromARGB(255, 12, 145, 198);
      case '예스24 티켓':
        return const Color.fromARGB(255, 36, 35, 35);
      case '알라딘':
        return const Color.fromARGB(255, 209, 199, 16);
      case 'CGV':
        return const Color(0xFFC70039);
      case '메가박스':
        return const Color.fromARGB(255, 65, 12, 151);
      case '롯데시네마':
        return const Color.fromARGB(255, 192, 15, 15);
      case '네이버':
        return const Color.fromARGB(255, 35, 216, 11);
      case '멜론티켓':
        return const Color.fromARGB(255, 42, 182, 23);
      case '리모(REMO)':
        return const Color(0xFF00ADCF);
      default:
        return Colors.grey;
    }
  }

  double _calculateAverageRating() {
    if (_reviews.isEmpty) return 0.0;
    double total = 0.0;
    for (var review in _reviews) {
      total += double.tryParse(review['rating'] ?? '0.0') ?? 0.0;
    }
    return total / _reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('상세 리뷰'),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 19,
        ),
        backgroundColor: const Color(0xFF00ADCF),
      ),
      endDrawer: CustomDrawer(
        onMenuSelected: (int index) {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBookHeader(),
                const SizedBox(height: 30),
                const Text(
                  "📝 나도 리뷰 작성하기",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                _buildReviewInput(),
                const SizedBox(height: 35),
                const Text(
                  "🎯 플랫폼별 리뷰 모아보기",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Divider(height: 30),
                ..._reviews.map((review) => _buildReviewCard(review)),
                const SizedBox(height: 80),
              ],
            ),
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
                widget.onAddFavorite(widget.bookData);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isFavorite ? "즐겨찾기에 추가되었습니다!" : "즐겨찾기에서 제거되었습니다!",
                    ),
                  ),
                );
              },
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            widget.bookData['img']?.toString() ?? '',
            width: 100,
            height: 140,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => Container(
              width: 100,
              height: 140,
              color: Colors.grey[200],
              child: const Icon(Icons.broken_image),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.bookData['title'] ?? '제목 없음',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                // 제미나이: 플랫폼별로 등록된 리뷰의 평점 데이터를 합산하여 전체 평점을 계산함.double.tryParse를 활용해 데이터 형변환 에러를 방지하고, 데이터가 없을 경우 기본값 0.0을 반환
                "통합 평점: ⭐ ${_calculateAverageRating().toStringAsFixed(1)} / 5.0",
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 제미나이: GestureDetector와 onTapDown을 활용하여 별점의 위치에 따라 0.5점 단위로 평점을 매길 수 있게 만든 로직은 고난도의 구현, 사용자에게 세밀한 입력 경험을 제공
  Widget _buildStarRating() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTapDown: (d) => setState(
            () => _rating = index + (d.localPosition.dx < 15 ? 0.5 : 1.0),
          ),
          child: Icon(
            _rating >= index + 1
                ? Icons.star
                : (_rating >= index + 0.5
                      ? Icons.star_half
                      : Icons.star_border),
            color: Colors.amber,
            size: 34,
          ),
        );
      }),
    );
  }

  Widget _buildReviewInput() {
    return Column(
      children: [
        _buildStarRating(),
        const SizedBox(height: 25),
        TextField(
          controller: _commentController,
          decoration: InputDecoration(
            hintText: "리모(REMO)에 소중한 리뷰를 남겨주세요!",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            suffixIcon: IconButton(
              icon: const Icon(Icons.send, color: Color(0xFF00ADCF)),
              onPressed: () {
                // 제미나이: 리뷰 내용 입력 여부와 별점 선택 여부를 검증하여, 빈 리뷰나 평점 0점인 리뷰가 등록되는 것을 방지
                if (_commentController.text.isNotEmpty && _rating > 0) {
                  setState(() {
                    _reviews.add({
                      "site": "리모(REMO)",
                      "rating": _rating.toString(),
                      "comment": _commentController.text,
                    });
                    _commentController.clear();
                    _rating = 0.0;
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewCard(Map<String, String> review) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getSiteColor(review['site']!),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            review['site']!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          "⭐ ${review['rating']}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(review['comment']!),
      ),
    );
  }
}
