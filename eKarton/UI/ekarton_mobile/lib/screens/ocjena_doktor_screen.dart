import 'package:ekarton_mobile/screens/ocjena_doktor_details_screen.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:ekarton_mobile/models/ocjene_doktor.dart';
import 'package:ekarton_mobile/models/doktor.dart';
import 'package:ekarton_mobile/models/odjel.dart';
import 'package:ekarton_mobile/providers/ocjena_doktor_provider.dart';
import 'package:ekarton_mobile/providers/doktor_provider.dart';
import 'package:ekarton_mobile/providers/odjel_provider.dart';

class OcjenaDoktorScreen extends StatefulWidget {
  @override
  _OcjenaDoktorScreenState createState() => _OcjenaDoktorScreenState();
}

class _OcjenaDoktorScreenState extends State<OcjenaDoktorScreen> {
  final OcjenaDoktorProvider ocjenaDoktorProvider = OcjenaDoktorProvider();
  final DoktorProvider doktorProvider = DoktorProvider();
  final OdjelProvider odjelProvider = OdjelProvider();

  List<OcjeneDoktor>? ocjene;
  List<Doktor>? doktori;
  List<Odjel>? odjeli;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final ocjeneResult = await ocjenaDoktorProvider.get();
    final doktoriResult = await doktorProvider.get();
    final odjeliResult = await odjelProvider.get();

    setState(() {
      ocjene = ocjeneResult.result;
      doktori = doktoriResult.result;
      odjeli = odjeliResult.result;
    });
  }

  String _getNazivOdjela(int odjelId) {
    final odjel = odjeli?.firstWhere((odjel) => odjel.odjelId == odjelId);
    return odjel?.naziv ?? 'Unknown Department';
  }

 @override
Widget build(BuildContext context) {
  return MasterScreenWidget(
    title_widget: Text('Doctor Ratings'),
    child: ocjene == null || doktori == null || odjeli == null
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: doktori!
                      .map((doktor) => doktor.odjelId)
                      .toSet()
                      .length, 
                  itemBuilder: (context, index) {
                    final odjeliIds = doktori!
                        .map((doktor) => doktor.odjelId)
                        .toSet()
                        .toList();

                    final odjelId = odjeliIds[index];
                    final doktoriOdjela = doktori!
                        .where((doktor) => doktor.odjelId == odjelId)
                        .toList();

                    final ocjeneOdjela = ocjene!.where((ocjena) {
                      return doktoriOdjela.any(
                          (doktor) => doktor.doktorId == ocjena.doktorId);
                    }).toList();

                    final nazivOdjela = _getNazivOdjela(odjelId!);

                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nazivOdjela,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: const Color.fromARGB(255, 34, 78, 57),
                              ),
                            ),
                            Divider(),
                            Expanded(
                              child: ListView.builder(
                                itemCount: doktoriOdjela.length,
                                itemBuilder: (context, doktorIndex) {
                                  final doktor = doktoriOdjela[doktorIndex];
                                  final ocjeneDoktora = ocjeneOdjela
                                      .where((ocjena) =>
                                          ocjena.doktorId == doktor.doktorId)
                                      .toList();

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${doktor.ime} ${doktor.prezime}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: const Color.fromARGB(255, 34, 78, 57)
                                        ),
                                      ),
                                      ...ocjeneDoktora.map((ocjena) {
                                        return Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: ocjena.ocjena! >= 4
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'Rating: ${ocjena.ocjena}',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                      SizedBox(height: 8),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
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
                        builder: (context) =>
                            OcjenaDoktorDetailsScreen(), 
                      ),
                    );
                    _fetchData(); 
                  },
                  child: Text("Add Your Rating For Doctor!", style: TextStyle(color:const Color.fromARGB(255, 34, 78, 57)),),
                ),
              ),
            ],
          ),
  );
}
}
