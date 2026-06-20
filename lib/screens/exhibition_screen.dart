import 'package:flutter/material.dart';
import 'package:flutter_2501045/models/exhibition.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: use_key_in_widget_constructors
class ExhibitionScreen extends StatelessWidget {
  final List<Exhibition> exhibitions = [
    Exhibition(
      title: "캐시 메모리: MMCA 뉴미디어 컬렉션 다시 읽기",
      location: "서울 지하1층, MMCA영상관",
      duration: "2026-06-16 ~ 2026-07-17",
      imageUrl: "assets/cash.jpg",
      reservationUrl:
          "https://www.mmca.go.kr/exhibitions/exhibitionsDetail.do?exhFlag=2&exhId=202606100002078",
      price: "무료",
      artist: "곽덕준 등 30명",
      host: "국립현대미술관",
    ),
    Exhibition(
      title: "이것은 개념미술이 (아니)다",
      location: "서울 지하1층, 6, 7전시실, 지하1층, 전시마당",
      duration: "2026-06-19 ~ 2026-10-11",
      imageUrl: "assets/egut.jpg",
      reservationUrl:
          "https://www.mmca.go.kr/exhibitions/exhibitionsDetail.do?exhFlag=2&exhId=202601060002027",
      price: "2,000원",
      artist: "하룬 파로키 등 19명",
      host: "국립현대미술관",
    ),
    Exhibition(
      title: "《권병준: 내 마음속에 너는》",
      location: "서울시립 북서울미술관 B1 전시실 5,6 (월요일 휴관)",
      duration: "2026-06-11 ~ 2027-05-16",
      imageUrl: "assets/kwon.jpg",
      reservationUrl:
          "https://sema.seoul.go.kr/kr/whatson/exhibition/detail?exNo=1538201",
      price: "무료",
      artist: "권병준",
      host: "서울시립미술관/삼화페인트공업(주)",
    ),
    Exhibition(
      title: "유휴공간 전시 《보편타당한 당신 - 심이다은》",
      location: "서울시립 북서울미술관 2층 유휴공간 (월요일 휴관)",
      duration: "2026.06.25 ~ 2027.04.11",
      imageUrl: "assets/yoohu.jpg",
      reservationUrl:
          "https://sema.seoul.go.kr/kr/whatson/exhibition/detail?exNo=1549929",
      price: "무료",
      artist: "심이다은",
      host: "서울시립미술관",
    ),
    Exhibition(
      title: "[2026 신진미술인 지원 프로그램] 신재은 개인전 《GAIA-피식의 서》",
      location: "Hall 1 (서울시 영등포구 양평로22마길 8)",
      duration: "2026.06.15 ~ 2026.06.28",
      imageUrl: "assets/sinjin.jpg",
      reservationUrl:
          "https://sema.seoul.go.kr/kr/whatson/exhibition/detail?exNo=1546824",
      price: "무료",
      artist: "신재은",
      host: "서울시립미술관",
    ),
    Exhibition(
      title: "2026 투어링 케이-아츠 《아마도, 모두 우리》",
      location: "주워싱턴한국문화원 전시실",
      duration: "2026.06.17 ~ 2026.08.11",
      imageUrl: "assets/tour.jpg",
      reservationUrl:
          "https://sema.seoul.go.kr/kr/whatson/exhibition/detail?exNo=1548449",
      price: "무료",
      artist: "갈라포라스-김 등 13명",
      host: "서울시립미술관, 주워싱턴한국문화원/문화체육관광위원회, KOFICE",
    ),
  ];

  Widget buildExhibitionCard(Exhibition exhibition) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(exhibition.imageUrl, height: 150, fit: BoxFit.cover),
              SizedBox(height: 8),
              Text(
                exhibition.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text("작가: ${exhibition.artist}"),
              Text("기간: ${exhibition.duration}"),
              Text("장소: ${exhibition.location}"),
              Text("가격: ${exhibition.price}"),
              Text("주최/후원: ${exhibition.host}"),
              TextButton(
                onPressed: () =>
                    launchUrl(Uri.parse(exhibition.reservationUrl)),
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
      appBar: AppBar(title: Text("이달의 전시회")),
      body: MasonryGridView.count(
        crossAxisCount: 2, // 2열
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        itemCount: exhibitions.length,
        itemBuilder: (context, index) {
          return buildExhibitionCard(exhibitions[index]);
        },
      ),
    );
  }
}
