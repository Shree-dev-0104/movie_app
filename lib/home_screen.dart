import 'package:flutter/material.dart';
import 'package:sum_app/movie_api_service.dart';
import 'package:sum_app/movie_card.dart';
import 'package:sum_app/movie_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'MovieFlix',
          style: TextStyle(
            color: Colors.red[600],
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Add search functionality
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MovieList()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              // Add profile functionality
            },
          ),
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.red.shade900.withOpacity(0.5),
                Colors.black,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: FutureBuilder(
              future: fetchMovies(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      if (index != 7) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MovieCard(
                            showData: snapshot.data![index],
                            imageUrl: snapshot.data![index]["show"]["image"]
                                ["original"],
                            title: snapshot.data![index]["show"]["name"],
                            summary: snapshot.data![index]["show"]["summary"]
                                .toString()
                                .replaceAll("<p>", ""),
                          ),
                        );
                      }
                      else {
                        return Container();
                      }
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )),
    );
  }
}
