import 'package:ekarton_mobile/models/pacijent.dart';
import 'package:ekarton_mobile/models/pacijent_oboljenja.dart';
import 'package:ekarton_mobile/models/search_result.dart';
import 'package:ekarton_mobile/providers/pacijent_oboljenja_provider.dart';
import 'package:ekarton_mobile/providers/pacijent_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OboljenjaScreen extends StatefulWidget {
  final Pacijent? pacijent;

  OboljenjaScreen({Key? key, this.pacijent}) : super(key: key);

  @override
  State<OboljenjaScreen> createState() => _OboljenjaScreen();
}

class _OboljenjaScreen extends State<OboljenjaScreen> {
  late PacijentOboljenjaProvider _pacijentOboljenjaProvider;
  late PacijentProvider _pacijentProvider;
  SearchResult<PacijentOboljenja>? result;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pacijentOboljenjaProvider = context.read<PacijentOboljenjaProvider>();
    _pacijentProvider = context.read<PacijentProvider>();

    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    var data = await _pacijentOboljenjaProvider.get();

    setState(() {
      result = data;
    });

    print("Pacijent: ${widget.pacijent?.ime} ${widget.pacijent?.prezime}");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text('OboljenjeId',
                style: TextStyle(fontStyle: FontStyle.italic)),
          ),
          DataColumn(
            label: Text('Nesposoban za rad',
                style: TextStyle(fontStyle: FontStyle.italic)),
          ),
          DataColumn(
            label: Text('Nesposoban za rad od:',
                style: TextStyle(fontStyle: FontStyle.italic)),
          ),
          DataColumn(
            label: Text('Nesposoban za rad do:',
                style: TextStyle(fontStyle: FontStyle.italic)),
          ),
        ],
        rows: result?.result.map((PacijentOboljenja e) {
              return DataRow(
                cells: [
                  DataCell(Text(e.oboljenjeId.toString())),
                  DataCell(Text(e.nesposobanZaRad ?? "")),
                  DataCell(Text(e.nesposobanZaRadOd ?? "")),
                  DataCell(Text(e.nesposobanZaRadDo ?? "")),
                ],
              );
            }).toList() ??
            [],
      ),
    );
  }
}
