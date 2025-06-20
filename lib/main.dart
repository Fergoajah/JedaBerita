import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'article_model.dart';
import 'news_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null); // format tanggal lokal indonesia
  runApp(const MyApp());
}

// root widget aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JedaBerita',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: TextTheme(
          titleMedium: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            height: 1.4,
          ),
          bodySmall: TextStyle(color: Colors.grey[700], fontSize: 12),
          bodyMedium: TextStyle(
            color: Colors.grey[850],
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ),
      locale: const Locale('id', 'ID'),
      home: const HomePage(),
    );
  }
}

// widget halaman Utama atau homepage
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // variabel untuk menyimpan data berita
  late Future<List<Article>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = NewsService().fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'JedaBerita',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        elevation: 0.5,
        surfaceTintColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Article>>(
        future: _newsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // jika data belum di load tampulkan loading 
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // tampilkan error jika terjadi
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // menampilkan pesan jika tidak ada berita
            final articles = snapshot.data!;
            if (articles.isEmpty) {
              return const Center(
                child: Text('Tidak ada berita yang ditemukan.'),
              );
            }

            // tampilkan daftar berita dalam bentur listview
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              itemCount: articles.length,
              separatorBuilder:
                  (context, index) => Divider(
                    height: 1,
                    color: Colors.grey[200],
                    indent: 16,
                    endIndent: 16,
                  ),
              itemBuilder: (context, index) {
                final article = articles[index];
                final formattedDate = DateFormat(
                  'EEEE, dd MMM yyyy',
                  'id_ID',
                ).format(article.pubDate);

                return InkWell(
                  onTap: () {
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // judul berita
                              Text(
                                article.title,
                                style: Theme.of(context).textTheme.titleMedium,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),

                              // deskripsi berita jika ada
                              if (article.description != null &&
                                  article.description!.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8.0,
                                  ), 
                                  child: Text(
                                    article.description!,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    maxLines:
                                        2, 
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                              // Tanggal berita[]
                              Text(
                                formattedDate,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Menampilkan gambar jika ada
                        if (article.imageUrl != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              article.imageUrl!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              // menampilkan placeholder jika gambar gagal di load
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey[200],
                                  child: Icon(
                                    Icons.broken_image,
                                    color: Colors.grey[400],
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('Silakan coba lagi nanti.'));
        },
      ),
    );
  }
}
