import 'package:ekarton_mobile/models/doktor.dart';
import 'package:ekarton_mobile/models/pacijent.dart';
import 'package:ekarton_mobile/models/search_result.dart';
import 'package:ekarton_mobile/models/termin.dart';
import 'package:ekarton_mobile/providers/doktor_provider.dart';
import 'package:ekarton_mobile/providers/pacijent_provider.dart';
import 'package:ekarton_mobile/providers/termin_provider.dart';
import 'package:ekarton_mobile/screens/termin_details_screen.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class TerminScreen extends StatefulWidget {
  Termin? termin;
  TerminScreen({Key? key, this.termin}) : super(key: key);

  @override
  State<TerminScreen> createState() => _TerminScreen();
}

class _TerminScreen extends State<TerminScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late PacijentProvider _pacijentProvider;
  late TerminProvider _terminProvider;
  late DoktorProvider _doktorProvider; // Dodajte provajder za doktore
  SearchResult<Termin>? terminResult;
  SearchResult<Pacijent>? pacijentResult;
  SearchResult<Doktor>? doktorResult; // Dodajte rezultat za doktore
  TextEditingController _brojKartonaController = TextEditingController();
  bool searchExecuted = false; // Flag for search execution

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pacijentProvider = context.read<PacijentProvider>();
    _terminProvider = context.read<TerminProvider>();
    _doktorProvider =
        context.read<DoktorProvider>(); // Inicijalizujte provajder
    _fetchTermini();
  }

  Future<void> _fetchTermini() async {
    var terminData = await _terminProvider.get();
    var pacijentData = await _pacijentProvider.get();
    var doktorData = await _doktorProvider.get(); // Dohvati doktore

    setState(() {
      terminResult = terminData;
      pacijentResult = pacijentData;
      doktorResult = doktorData; // Setuj rezultate doktora
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text("Pogledaj listu zakazanih termina"),
      child: Container(
        child: Column(children: [
          _buildDataListView(),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TerminDetailsScreen(),
                ),
              );
            },
            child: Text("Dodaj novi termin!"),
          ),
        ]),
      ),
    );
  }

  Expanded _buildDataListView() {
    return Expanded(
      child: SingleChildScrollView(
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Expanded(
                child: Text(
                  'Datum',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Vrijeme',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Razlog',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Pacijent',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Doktor',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: terminResult?.result.map((Termin e) {
                // Find the Pacijent and Doktor based on IDs
                var pacijentName = pacijentResult?.result
                    .firstWhere((p) => p.pacijentId == e.pacijentId);

                var doktorName = doktorResult?.result
                    .firstWhere((d) => d.doktorId == e.doktorId);

                return DataRow(
                  cells: [
                    DataCell(Text(e.datum ?? "")),
                    DataCell(Text(e.vrijeme ?? "")),
                    DataCell(Text(e.razlog ?? "")),
                    DataCell(Text(pacijentName?.ime ?? "")),
                    DataCell(Text(doktorName?.ime ?? "")),
                  ],
                );
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
