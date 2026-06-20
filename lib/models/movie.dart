class Movie {
  final String title;
  final String genre; // 장르
  final double rating; // 평점
  final String posterUrl;
  final String releaseDate; // 상영일
  final String ageRating; // 등급
  final String country;
  final String runtime; // 상영 시간
  final String trailerUrl;

  Movie({
    required this.title,
    required this.genre,
    required this.rating,
    required this.posterUrl,
    required this.releaseDate,
    required this.ageRating,
    required this.country,
    required this.runtime,
    required this.trailerUrl,
  });
}
