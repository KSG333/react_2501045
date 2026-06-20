import 'package:flutter/material.dart';
import 'package:flutter_2501045/models/performance.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: use_key_in_widget_constructors
class PerformanceScreen extends StatelessWidget {
  final List<Performance> performances = [
    Performance(
      title: "데스노트 - 대전",
      genre: "뮤지컬", // 공연, 뮤지컬 등 개요
      venue: "대전예술의전당 아트홀", // 장소
      duration: "2026.06.09 ~ 2026.06.14", // 공연 기간
      price: ("VIP석: 170,000원, R석: 140,000원, S석: 110,000원, A석: 80,000원"),
      rating: 9.9, // 평점
      imageUrl: "assets/desnote.jpg",
      bookingUrl: "https://tickets.interpark.com/goods/26005693", // 예매 링크
    ),
    Performance(
      title: "달수랑 정직이랑 바다아이",
      genre: "연극(드라마극)", // 공연, 뮤지컬 등 개요
      venue: "선돌극장", // 장소
      duration: "2026.06.04 ~ 2026.06.14", // 공연 기간
      price: ("전석: 30,000원"),
      rating: 10.0, // 평점
      imageUrl: "assets/dalsu.jpg",
      bookingUrl: "https://ticket.yes24.com/perf/58143", // 예매 링크
    ),
    Performance(
      title: "기억의 날",
      genre: "연극(드라마극)", // 공연, 뮤지컬 등 개요
      venue: "예술공간 혜화", // 장소
      duration: "2026.06.05 ~ 2026.06.14", // 공연 기간
      price: ("전석: 40,000원"),
      rating: 10.0, // 평점
      imageUrl: "assets/riuk.jpg",
      bookingUrl: "https://tickets.interpark.com/goods/26007165", // 예매 링크
    ),
    Performance(
      title: "더 트라이브",
      genre: "뮤지컬", // 공연, 뮤지컬 등 개요
      venue: "세종문화회관 M씨어터", // 장소
      duration: "2026.06.09 ~ 2026.06.27", // 공연 기간
      price: ("R석 80,000원, S석 60,000원"),
      rating: 9.0, // 평점
      imageUrl: "assets/try.jpg",
      bookingUrl: "https://ticket.yes24.com/perf/56550", // 예매 링크
    ),
    Performance(
      title: "SHELTER / 쉘터",
      genre: "뮤지컬", // 공연, 뮤지컬 등 개요
      venue: "세종문화회관 M씨어터", // 장소
      duration: "2026.06.12 ~ 2026.06.14", // 공연 기간
      price: ("전석: 35,000원"),
      rating: 0, // 평점
      imageUrl: "assets/shelter.jpg",
      bookingUrl: "https://tickets.interpark.com/goods/26007587", // 예매 링크
    ),
    Performance(
      title: "잔류시민",
      genre: "연극(드라마극)", // 공연, 뮤지컬 등 개요
      venue: "대학로극장 쿼드", // 장소
      duration: "2026.06.06 ~ 2026.06.14", // 공연 기간
      price: ("전석: 60,000원"),
      rating: 9.1, // 평점
      imageUrl: "assets/jan.jpg",
      bookingUrl: "https://tickets.interpark.com/goods/26006437", // 예매 링크
    ),
  ];

  Widget buildExhibitionCard(Performance performance) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(performance.imageUrl, height: 150, fit: BoxFit.cover),
              SizedBox(height: 8),
              Text(
                performance.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text("개요: ${performance.genre}"),
              Text("기간: ${performance.duration}"),
              Text("장소: ${performance.venue}"),
              Text(
                performance.rating == 0
                    ? "평점: 평가 준비중"
                    : "평점: ⭐ ${performance.rating}",
              ),
              Text("가격: ${performance.price}"),
              TextButton(
                onPressed: () => launchUrl(Uri.parse(performance.bookingUrl)),
                child: Text("전시 정보 바로가기"),
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
      appBar: AppBar(title: Text("이달의 공연")),
      body: MasonryGridView.count(
        crossAxisCount: 2, // 2열
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        itemCount: performances.length,
        itemBuilder: (context, index) {
          return buildExhibitionCard(performances[index]);
        },
      ),
    );
  }
}
