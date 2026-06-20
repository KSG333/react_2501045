class Performance {
  final String title;
  final String genre; // 뮤지컬, 연극 등
  final String venue; // 공연장
  final String duration; // 공연 기간
  final String price; // 관람료
  final double rating;
  final String imageUrl;
  final String bookingUrl; // 예매 링크

  Performance({
    required this.title,
    required this.genre,
    required this.venue,
    required this.duration,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.bookingUrl,
  });
}
