import 'package:flutter/material.dart';
import 'package:ekarton_mobile/models/doktor.dart';
import 'package:ekarton_mobile/providers/doktor_provider.dart';
import 'package:ekarton_mobile/models/ocjene_doktor.dart';
import 'package:ekarton_mobile/models/search_result.dart';
import 'package:ekarton_mobile/providers/ocjena_doktor_provider.dart';

class RecommendedDoctorScreen extends StatefulWidget {
  @override
  _RecommendedDoctorScreenState createState() => _RecommendedDoctorScreenState();
}

class _RecommendedDoctorScreenState extends State<RecommendedDoctorScreen> {
  final DoktorProvider doktorProvider = DoktorProvider();
  final OcjenaDoktorProvider ocjenaDoktorProvider = OcjenaDoktorProvider();
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
    return Scaffold(
      body: _doctors != null
          ? ListView.builder(
              itemCount: _doctors!.length,
              itemBuilder: (context, index) {
                final doktor = _doctors![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      title: Text('${doktor.ime} ${doktor.prezime}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Average Rating: ${doktor.averageRating?.toStringAsFixed(1) ?? "N/A"}'),
                          _buildOcjeneForDoktor(doktor.doktorId),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildOcjeneForDoktor(int? doktorId) {
    final ocjeneZaDoktora =
        result?.result.where((ocjena) => ocjena.doktorId == doktorId).toList();

    if (ocjeneZaDoktora == null || ocjeneZaDoktora.isEmpty) {
      return Text('No ratings for this doctor');
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
}
