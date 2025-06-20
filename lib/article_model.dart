class Article {
  // parameter dari API yang digunakan disini
  // dimana ini merupakan struktur data untuk setiap artikel berita
  // properti dengan menggunakan tanda ( ? ) berarti opsional bisa null
  final String articleId;
  final String title;
  final String? description;
  final DateTime pubDate;
  final String? imageUrl; 

  // Constructor untuk kelas article
  Article({
    required this.articleId,
    required this.title,
    this.description,
    required this.pubDate,
    this.imageUrl,
  });

  // Factory constructor untuk membuat objek Article dari data JSON
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      articleId: json['article_id'],
      title: json['title'],
      description: json['description'],
      pubDate: DateTime.parse(json['pubDate']),
      imageUrl: json['image_url'],
    );
  }
}