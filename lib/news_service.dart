import 'package:http/http.dart' as http;
import 'article_model.dart';
import 'dart:convert';

// Class NewService dimana bertanggung jawab untuk mengambil data dari API
class NewsService {
    // variabel final untuk menyimpan URL berita
    // untuk API Key disini menyatu dengan API News API
    final String _apiUrl = "https://newsdata.io/api/1/latest?apikey=pub_0a00279b2d3448bd837e90f85d338314&country=id&language=id&category=crime,politics,world,top,education&timezone=Asia/Jakarta";

    // metode asinkron untuk mengambil data dari API
    Future<List<Article>> fetchNews() async {
        try {
            // melakukan http get ke URL API
            final response = await http.get(Uri.parse(_apiUrl));

            // pengecekan kondisi if
            if (response.statusCode == 200) {
                final Map<String, dynamic> jsonResponse = json.decode(response.body);
                final List<dynamic> results = jsonResponse['results'];
                
                return results.map((json) => Article.fromJson(json)).toList();
            } else {
                throw Exception('Failed to load news. Status code: ${response.statusCode}');
            }
        } catch (e) {
            throw Exception('Failed to fetch data: $e');
        }
    }
}