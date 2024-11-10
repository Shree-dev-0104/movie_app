import 'package:flutter/material.dart';

class ShowDetailPage extends StatelessWidget {
  final String id;
  final String name;
  final String type;
  final String language;
  final List<String> genres;
  final String status;
  final String premiered;
  final int runtime;
  final String scheduleTime;
  final List<String> scheduleDays;
  final double? averageRating;
  final String network;
  final String country;
  final String image;
  final String summary;
  final String imdb;
  final String officialSite;

  // Constructor with required fields
  const ShowDetailPage({
    super.key,
    required this.id,
    required this.name,
    required this.type,
    required this.language,
    required this.genres,
    required this.status,
    required this.premiered,
    required this.runtime,
    required this.scheduleTime,
    required this.scheduleDays,
    required this.averageRating,
    required this.network,
    required this.country,
    required this.image,
    required this.summary,
    required this.imdb,
    required this.officialSite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show Image
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Show Title and Details
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$type • $language • ${genres.join(", ")}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        averageRating != null ? averageRating.toString() : 'N/A',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Show Schedule
                  Text(
                    'Schedule: ${scheduleDays.join(", ")} at $scheduleTime',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Runtime: $runtime minutes',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Premiered: $premiered',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 16),

                  // Summary
                  const Text(
                    'Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    summary.replaceAll(RegExp(r'<[^>]*>'), ''),
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 16),

                  // Network Info
                  Text(
                    'Network: $network, $country',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 8),

                  // External Links
                  Row(
                    children: [
                      const Icon(Icons.link, color: Colors.blue),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {}, //launch
                        child: const Text(
                          'Official Site',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.movie, color: Colors.blue),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          'IMDb',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
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
