import 'package:ekarton_mobile/models/ocjene_doktor.dart';
import 'package:ekarton_mobile/models/search_result.dart';
import 'package:flutter/material.dart';
import 'package:ekarton_mobile/models/doktor.dart';
import 'package:ekarton_mobile/providers/doktor_provider.dart';
import 'package:ekarton_mobile/providers/ocjena_doktor_provider.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';

class RecommendedDoctorsScreen extends StatefulWidget {
  @override
  _RecommendedDoctorsScreenState createState() =>
      _RecommendedDoctorsScreenState();
}

class _RecommendedDoctorsScreenState extends State<RecommendedDoctorsScreen> {
  final DoktorProvider doktorProvider = DoktorProvider();
  final OcjenaDoktorProvider ocjenaDoktorProvider = OcjenaDoktorProvider();
  double? _selectedRating;
  List<Doktor>? _doctors;
  SearchResult<OcjeneDoktor>? result;

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
  }

  Future<void> _fetchDoctors() async {
    try {
      _doctors = await doktorProvider.fetchRecommendedDoctors();
      result = await ocjenaDoktorProvider.get();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text('Recommended doctors'),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: DropdownButton<double>(
                hint: Text('Choose a rating'),
                value: _selectedRating,
                items: _doctors != null
                    ? groupDoctorsByRating(_doctors!).map((group) {
                        return DropdownMenuItem<double>(
                          value: group.rating,
                          child: Text(
                              'Rating: ${group.rating.toStringAsFixed(1)}'),
                        );
                      }).toList()
                    : [],
                onChanged: (value) {
                  setState(() {
                    _selectedRating = value;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: _selectedRating != null && _doctors != null
                ? ListView.builder(
                    itemCount: groupDoctorsByRating(_doctors!).length,
                    itemBuilder: (context, index) {
                      final ratingGroup =
                          groupDoctorsByRating(_doctors!)[index];

                      if (ratingGroup.rating != _selectedRating) {
                        return SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Average doctor rating: ${ratingGroup.rating.toStringAsFixed(1)}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            ...ratingGroup.doctors.map((doktor) => ListTile(
                                  title:
                                      Text('${doktor.ime} ${doktor.prezime}'),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Doctor: ${doktor.doktorId}'),
                                      _buildOcjeneForDoktor(doktor.doktorId),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      );
                    },
                  )
                : Center(child: Text('Select a rating to display the doctor')),
          ),
          if (_selectedRating != null &&
              _doctors != null &&
              !groupDoctorsByRating(_doctors!)
                  .any((group) => group.rating == _selectedRating))
            Center(child: Text('Nema doktora s odabranom ocjenom')),
        ],
      ),
    );
  }

  Widget _buildOcjeneForDoktor(int? doktorId) {
    final ocjeneZaDoktora =
        result?.result.where((ocjena) => ocjena.doktorId == doktorId).toList();

    if (ocjeneZaDoktora == null || ocjeneZaDoktora.isEmpty) {
      return Text('Nema ocjena za ovog doktora');
    }
    final brojOcjena = ocjeneZaDoktora.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Number of ratings: $brojOcjena'),
        ...ocjeneZaDoktora.map((ocjena) {
          return Text('Rating: ${ocjena.ocjena}, Reason: ${ocjena.razlog}');
        }).toList(),
      ],
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
