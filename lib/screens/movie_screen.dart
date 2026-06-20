import 'package:flutter/material.dart';
import 'package:flutter_2501045/models/movie.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: use_key_in_widget_constructors
class MovieListScreen extends StatelessWidget {
  final List<Movie> movies = [
    Movie(
      title: "싱 스트리트",
      genre: "드라마, 로맨스",
      rating: 9.0,
      posterUrl: "assets/sing.jpg",
      releaseDate: "2026.06.10",
      ageRating: "15세 이상 관람가",
      country: "국가: 아일랜드, 미국, 영국",
      runtime: "105분",
      trailerUrl: "https://tv.naver.com/v/99588534",
    ),
    Movie(
      title: "순례자들은 왜 돌아오지 않는가",
      genre: "애니메이션, 로맨스",
      rating: 8.74,
      posterUrl: "assets/soon.jpg",
      releaseDate: "2026.06.03",
      ageRating: "전체 관람가",
      country: "국가: 대한민국",
      runtime: "60분",
      trailerUrl: "https://tv.naver.com/v/99722584",
    ),
    Movie(
      title: "와일드 씽",
      genre: "코미디",
      rating: 8.55,
      posterUrl: "assets/while.jpg",
      releaseDate: "2026.06.03",
      ageRating: "12세 이상 관람가",
      country: "국가: 대한민국",
      runtime: "107분",
      trailerUrl: "https://tv.naver.com/v/99278996",
    ),
    Movie(
      title: "노트북",
      genre: "멜로/로맨스",
      rating: 9.32,
      posterUrl: "assets/notbook.jpg",
      releaseDate: "2026.06.04",
      ageRating: "15세 이상 관람가",
      country: "미국",
      runtime: "124분",
      trailerUrl: "https://tv.naver.com/v/100286175",
    ),
    Movie(
      title: "디스클로저 데이",
      genre: "SF, 미스터리",
      rating: 5.27,
      posterUrl: "assets/dis.jpg",
      releaseDate: "2026.06.10",
      ageRating: "12세 이상 관람가",
      country: "미국",
      runtime: "145분",
      trailerUrl: "https://tv.naver.com/v/100614077",
    ),
    Movie(
      title: "현상수배",
      genre: "코미디, 액션",
      rating: 6.0,
      posterUrl: "assets/hyeonsang.jpg",
      releaseDate: "2026.06.10",
      ageRating: "15세 이상 관람가",
      country: "대한민국, 대만",
      runtime: "79분",
      trailerUrl: "https://tv.naver.com/v/98065774",
    ),
  ];

  Widget buildMovieCard(Movie movie) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            // Row에서 Column으로 변경하여 이미지를 위에 배치하거나, 내용을 세로로 길게 배치
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    movie.posterUrl,
                    width: 70,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "평점: ⭐ ${movie.rating}",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // 나머지 정보들을 세로로 배치
              Text("장르: ${movie.genre}", style: TextStyle(fontSize: 12)),
              Text("개봉: ${movie.releaseDate}", style: TextStyle(fontSize: 12)),
              Text("등급: ${movie.ageRating}", style: TextStyle(fontSize: 12)),
              Text(
                "국가: ${movie.country}",
                style: TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
              Text("러닝타임: ${movie.runtime}", style: TextStyle(fontSize: 12)),
              Center(
                child: TextButton(
                  onPressed: () async {
                    final Uri url = Uri.parse(movie.trailerUrl);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  },
                  child: Text("예고편 바로가기", style: TextStyle(fontSize: 12)),
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
      appBar: AppBar(title: Text("이달의 영화")),
      body: MasonryGridView.count(
        crossAxisCount: 2, // 2열
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          // 이제 함수가 같은 클래스 안에 있으므로 호출 가능합니다!
          return buildMovieCard(movies[index]);
        },
      ),
    );
  }
}
