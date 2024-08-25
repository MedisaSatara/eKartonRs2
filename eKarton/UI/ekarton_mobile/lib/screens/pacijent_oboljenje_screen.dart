import 'package:ekarton_mobile/models/pacijent.dart';
import 'package:ekarton_mobile/models/pacijent_oboljenja.dart';
import 'package:ekarton_mobile/models/search_result.dart';
import 'package:ekarton_mobile/providers/pacijent_oboljenja_provider.dart';
import 'package:ekarton_mobile/providers/pacijent_provider.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PacijentOboljenjeScreen extends StatefulWidget {
  PacijentOboljenja? pacijentOboljenja;
  PacijentOboljenjeScreen({Key? key, this.pacijentOboljenja}) : super(key: key);

  @override
  State<PacijentOboljenjeScreen> createState() => _PacijentOboljenjeScreen();
}

class _PacijentOboljenjeScreen extends State<PacijentOboljenjeScreen> {
  late PacijentOboljenjaProvider _pacijentOboljenjaProvider;
  late PacijentProvider _pacijentProvider;
  SearchResult<PacijentOboljenja>? result;
  SearchResult<Pacijent>? pacijentResult;

  TextEditingController _imeController = TextEditingController();
  TextEditingController _prezimeController = TextEditingController();
  TextEditingController _brojkartonaController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pacijentOboljenjaProvider = context.read<PacijentOboljenjaProvider>();
    _pacijentProvider = context.read<PacijentProvider>();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    var data = await _pacijentOboljenjaProvider.get();
    var pacijentData = await _pacijentProvider.get();

    setState(() {
      result = data;
      pacijentResult = pacijentData;
    });
    print(
        "Pacijent: ${pacijentResult?.result.map((p) => p.pacijentId).toList()}");
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Container(
        child: Column(
          children: [
            _buildDataListView(),
            SizedBox(
              height: 8.0,
            ),
          ],
        ),
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
                  'PacijentI',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'OsiguranjeId',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Datum osiguranja',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Vazece',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: result?.result.map((PacijentOboljenja e) {
                // Find the patient by pacijentId
                var pacijent = pacijentResult?.result.firstWhere(
                  (p) => p.pacijentId == e.pacijentId,
                  // Provide a fallback
                );

                return DataRow(
                  cells: [
                    DataCell(Text(e.pacijentId.toString() ?? "N/A")),
                    DataCell(Text(e.oboljenjeId.toString() ?? "N/A")),
                    DataCell(Text(e.nesposobanZaRad ?? "")),
                    DataCell(Text(e.nesposobanZaRadOd ?? "")),
                  ],
                );
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
