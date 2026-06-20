class Exhibition {
  final String title;
  final String location; // 장소
  final String duration; // 전시 기간
  final String imageUrl;
  final String reservationUrl; // 전시 정보
  final String price; // 관람료
  final String artist; // 작가(예술가)
  final String host; // 주최/후원

  Exhibition({
    required this.title,
    required this.location,
    required this.duration,
    required this.imageUrl,
    required this.reservationUrl,
    required this.price,
    required this.artist,
    required this.host,
  });
}
