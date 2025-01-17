import 'package:ekarton_mobile/models/doktor.dart';
import 'package:ekarton_mobile/models/odjel.dart';
import 'package:ekarton_mobile/models/search_result.dart';
import 'package:ekarton_mobile/providers/doktor_provider.dart';
import 'package:ekarton_mobile/providers/odjel_provider.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OdjelScreen extends StatefulWidget {
  const OdjelScreen({Key? key}) : super(key: key);

  @override
  State<OdjelScreen> createState() => _OdjelScreen();
}

class _OdjelScreen extends State<OdjelScreen> {
  late OdjelProvider _odjelProvider;
  late DoktorProvider _doktorProvider;
  SearchResult<Odjel>? odjelResult;
  List<Doktor>? doktorResult;
  Map<int, List<Doktor>> doktorMap = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _odjelProvider = context.read<OdjelProvider>();
    _doktorProvider = context.read<DoktorProvider>();

    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    var data = await _odjelProvider.get();
    var doktorData = await _doktorProvider.get();

    setState(() {
      odjelResult = data;
      doktorResult = doktorData.result;
    });

    for (var doktor in doktorResult!) {
      if (doktor.odjelId != null) {
        doktorMap.putIfAbsent(doktor.odjelId!, () => []).add(doktor);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text("Departments"),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/welcomepage.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildCardListView(),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildCardListView() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: odjelResult?.result.map((Odjel odjel) {
                var doktori = doktorMap[odjel.odjelId] ?? [];
                return Opacity(
                  opacity: 0.9,
                  child: Card(
                    margin: EdgeInsets.all(8.0),
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.business,
                                    size: 24,
                                    color:
                                        const Color.fromARGB(255, 34, 78, 57),
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    '${odjel.naziv?.toUpperCase() ?? "Unknown"}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'Phone: ${odjel.telefon ?? "N/A"}',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                'Doctors:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8.0),
                              doktori.isNotEmpty
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: doktori.map((doktor) {
                                        return Text(
                                          '${doktor.ime} ${doktor.prezime}',
                                          style: TextStyle(fontSize: 14),
                                        );
                                      }).toList(),
                                    )
                                  : Text("No doctors available"),
                            ],
                          ),
                          Positioned(
                            right: 0,
                            bottom: -30,
                            child: Image.asset(
                              'assets/images/logo.jpg',
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
