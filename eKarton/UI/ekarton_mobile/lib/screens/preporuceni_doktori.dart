import 'package:flutter/material.dart';
import 'package:ekarton_mobile/models/doktor.dart';
import 'package:ekarton_mobile/providers/doktor_provider.dart';

class RecommendedDoctorsScreen extends StatelessWidget {
  final DoktorProvider doktorProvider = DoktorProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preporuceni doktori'),
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
            final doctorsByRating = groupDoctorsByRating(snapshot.data!);
            return ListView.builder(
              itemCount: doctorsByRating.length,
              itemBuilder: (context, index) {
                final ratingGroup = doctorsByRating[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Prosjecna ocjena doktora: ${ratingGroup.rating.toStringAsFixed(1)}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ...ratingGroup.doctors.map((doktor) => ListTile(
                            title: Text('${doktor.ime} ${doktor.prezime}'),
                            subtitle: Text('Doktor ID: ${doktor.doktorId}'),
                          )),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  List<RatingGroup> groupDoctorsByRating(List<Doktor> doctors) {
    Map<double, List<Doktor>> grouped = {};
    for (var doktor in doctors) {
      final rating = doktor.averageRating ?? 0;
      if (!grouped.containsKey(rating)) {
        grouped[rating] = [];
      }
      grouped[rating]!.add(doktor);
    }

    return grouped.entries
        .map((entry) => RatingGroup(rating: entry.key, doctors: entry.value))
        .toList()
      ..sort((a, b) => b.rating.compareTo(a.rating));
  }
}

class RatingGroup {
  final double rating;
  final List<Doktor> doctors;

  RatingGroup({required this.rating, required this.doctors});
}
