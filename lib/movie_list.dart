import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sum_app/details_screen_page.dart';
import 'package:sum_app/movie_api_service.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final TextEditingController _searchMovieController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movies',
          style: TextStyle(color: Colors.red[700], fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.red],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: _searchMovieController,
                  decoration: InputDecoration(
                    hintText: 'Search Movie',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white12,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: fetchMovies(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show shimmer effect while loading
                      return ListView.builder(
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: ListTile(
                              title: Container(height: 10, width: 80, color: Colors.white),
                              subtitle: Container(height: 10, width: 80, color: Colors.white),
                              leading: Container(height: 50, width: 50, color: Colors.white),
                            ),
                          );
                        },
                      );
                    }

                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var show = snapshot.data![index]['show'];
                          String title = show['name']?.toString() ?? 'No title available';
                          String imageUrl = show['image']?['medium'] ?? '';
                          double rating = show['rating']?['average']?.toDouble() ?? 0.0;
                          String summary = show['summary']?.toString().replaceAll("<p>", "").replaceAll("</p>", "") ?? 'No summary available';

                          // Filter by search query
                          if (_searchMovieController.text.isEmpty ||
                              title.toLowerCase().contains(_searchMovieController.text.toLowerCase())) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ShowDetailPage(
                                          id: show['id']?.toString() ?? '',
                                          name: title,
                                          type: show['type'] ?? 'N/A',
                                          language: show['language'] ?? 'N/A',
                                          genres: List<String>.from(show['genres'] ?? []),
                                          status: show['status'] ?? 'N/A',
                                          premiered: show['premiered'] ?? 'N/A',
                                          runtime: show['runtime'] ?? 'N/A',
                                          scheduleTime: show['schedule']?['time'] ?? 'N/A',
                                          scheduleDays: List<String>.from(show['schedule']?['days'] ?? []),
                                          averageRating: rating,
                                          network: show['network']?['name'] ?? 'N/A',
                                          country: show['network']?['country']?['name'] ?? 'N/A',
                                          image: show['image']?['original'] ?? '',
                                          summary: summary,
                                          imdb: show['externals']?['imdb'] ?? 'N/A',
                                          officialSite: show['officialSite'] ?? 'N/A',
                                        ),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    title: Text(
                                      title,
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      'Rating: ${rating > 0 ? rating.toString() : 'N/A'}',
                                      style: TextStyle(color: Colors.red[700]),
                                    ),
                                    leading: Hero(
                                      tag: title,
                                      child: imageUrl.isNotEmpty
                                          ? Image.network(imageUrl, width: 50, height: 50, errorBuilder: (context, error, stackTrace) {
                                              return const Icon(Icons.error, color: Colors.white);
                                          })
                                          : const Icon(Icons.image_not_supported, color: Colors.white, size: 50),
                                    ),
                                  ),
                                ),
                                const Divider(color: Colors.white24),
                              ],
                            );
                          } else {
                            return Container(); // Empty container for non-matching search
                          }
                        },
                      );
                    } else {
                      // If snapshot has no data or there's an error
                      return const Center(child: Text('No data available', style: TextStyle(color: Colors.white)));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
