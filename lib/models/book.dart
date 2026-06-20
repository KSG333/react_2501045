class Book {
  final String title;
  final String author; // 저자
  final double rating; // 평점
  final String coverUrl;
  final String releaseDate; // 출판일
  final String buyUrl;
  final String publishedDate; // 출판사

  Book({
    required this.title,
    required this.author,
    required this.rating,
    required this.coverUrl,
    required this.releaseDate,
    required this.buyUrl,
    required this.publishedDate,
  });
}
