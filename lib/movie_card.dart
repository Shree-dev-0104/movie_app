import 'package:flutter/material.dart';
import 'package:sum_app/details_screen_page.dart';

class MovieCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String summary;
  final Map<String, dynamic> showData;

  const MovieCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.summary,
    required this.showData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowDetailPage(
              id: showData["show"]["id"].toString(),
              name: showData["show"]["name"],
              type: showData["show"]["type"],
              language: showData["show"]["language"],
              genres:
                  List<String>.from(showData["show"]["genres"]),
              status: showData["show"]["status"],
              premiered: showData["show"]["premiered"],
              runtime: showData["show"]["runtime"],
              scheduleTime: showData["show"]["schedule"]["time"],
              scheduleDays: List<String>.from(
                  showData["show"]["schedule"]["days"]),
              averageRating: showData["show"]["rating"]["average"]
                  ?.toDouble(),
              network: showData["show"]["network"]["name"],
              country: showData["show"]["network"]["country"]
                  ["name"],
              image: showData["show"]["image"]["original"],
              summary: showData["show"]["summary"]
                  .toString()
                  .replaceAll("<p>", "")
                  .replaceAll("</p>", ""),
              imdb: showData["show"]["externals"]["imdb"],
              officialSite: showData["show"]["officialSite"] ?? '',
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.black54,
          boxShadow: [
            BoxShadow(
              color: Colors.red.shade900.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Poster
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 60,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.8),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Movie Info
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    summary,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
