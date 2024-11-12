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
      title_widget: Text("Odjeli"),
      child: Container(
        child: Column(
          children: [
            _buildDataListView(),
          ],
        ),
      ),
    );
  }

  Expanded _buildDataListView() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columnSpacing: 20,
          dataRowMinHeight: 150.0,
          dataRowMaxHeight: 150.0,
          columns: const <DataColumn>[
            DataColumn(
              label: Expanded(
                child: Text(
                  'Naziv',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Telefon',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Doktori',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: odjelResult?.result.map((Odjel odjel) {
                var doktori = doktorMap[odjel.odjelId] ?? [];

                return DataRow(
                  cells: [
                    DataCell(
                      Container(
                        child: Text(odjel.naziv ?? ""),
                        height: 400,
                      ),
                    ),
                    DataCell(
                      Container(
                        child: Text(odjel.telefon ?? ""),
                        height: 400,
                      ),
                    ),
                    DataCell(
                      Container(
                        height: 400.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: doktori.isNotEmpty
                              ? doktori.map((doktor) {
                                  return Text('${doktor.ime} ${doktor.prezime}',
                                      style: TextStyle(fontSize: 14));
                                }).toList()
                              : [Text("Nema doktora")],
                        ),
                      ),
                    ),
                  ],
                );
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
