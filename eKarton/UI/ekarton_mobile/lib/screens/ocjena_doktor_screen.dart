import 'package:ekarton_mobile/screens/ocjena_doktor_details_screen.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:ekarton_mobile/models/ocjene_doktor.dart';
import 'package:ekarton_mobile/models/doktor.dart';
import 'package:ekarton_mobile/providers/ocjena_doktor_provider.dart';
import 'package:ekarton_mobile/providers/doktor_provider.dart';

class OcjenaDoktorScreen extends StatefulWidget {
  @override
  _OcjenaDoktorScreenState createState() => _OcjenaDoktorScreenState();
}

class _OcjenaDoktorScreenState extends State<OcjenaDoktorScreen> {
  final OcjenaDoktorProvider ocjenaDoktorProvider = OcjenaDoktorProvider();
  final DoktorProvider doktorProvider = DoktorProvider();
  List<OcjeneDoktor>? ocjene;
  List<Doktor>? doktori;

  @override
  void initState() {
    super.initState();
    _fetchOcjene();
  }

  Future<void> _fetchOcjene() async {
    final result = await ocjenaDoktorProvider.get();
    final doktorResult = await doktorProvider.get();

    setState(() {
      ocjene = result.result;
      doktori = doktorResult.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text('Doctors ratings'),
      child: ocjene == null || doktori == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: ocjene!.length,
                    itemBuilder: (context, index) {
                      int doktorId = ocjene![index].doktorId!;
                      List<OcjeneDoktor> ocjeneDoktora = ocjene!
                          .where((ocjena) => ocjena.doktorId == doktorId)
                          .toList();

                      final doktor = doktori!.firstWhere(
                        (doc) => doc.doktorId == doktorId,
                        orElse: () => Doktor(ime: 'Nepoznat', prezime: ''),
                      );

                      return ExpansionTile(
                        title: Text(
                          'Doctor: ${doktor.ime} ${doktor.prezime}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        children: ocjeneDoktora.map((ocjena) {
                          return ListTile(
                            title: Text('Rating: ${ocjena.ocjena}'),
                            subtitle: Text('Reason: ${ocjena.razlog}'),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => OcjenaDoktorDetailsScreen(),
                        ),
                      );
                      _fetchOcjene();
                    },
                    child: Text("Add rating!"),
                  ),
                ),
              ],
            ),
    );
  }
}
