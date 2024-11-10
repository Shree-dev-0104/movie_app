import 'dart:convert';
import 'package:http/http.dart' as http;



  // Function to fetch movies
  Future<List<dynamic>> fetchMovies() async {
    try {
      final response = await http.get(
        Uri.parse("https://api.tvmaze.com/search/shows?q=all"),
      );
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Decode the JSON response
        return data;

      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching movies: $e');
    }
  }


