import 'package:ekarton_mobile/models/doktor.dart';
import 'package:ekarton_mobile/providers/doktor_provider.dart';
import 'package:flutter/material.dart';

class RecommendedDoctorsScreen extends StatelessWidget {
  final DoktorProvider doktorProvider = DoktorProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommended Doctors'),
      ),
      body: FutureBuilder<List<Doktor>>(
        future: doktorProvider.fetchRecommendedDoctors(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No recommended doctors found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final doktor = snapshot.data![index];
                return ListTile(
                  title: Text('${doktor.ime} ${doktor.prezime}'),
                  subtitle: doktor.averageRating != null
                      ? Text(
                          'Rating: ${doktor.averageRating!.toStringAsFixed(1)}')
                      : Text('No rating available'),
                  onTap: () {
                    // Handle tap
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
