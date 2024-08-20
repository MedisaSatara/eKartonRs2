import 'package:ekarton_admin/main.dart';
import 'package:ekarton_admin/models/bolnica.dart';
import 'package:ekarton_admin/models/odjel.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/bolnica_provider.dart';
import 'package:ekarton_admin/providers/odjel_provider.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OdjelScreen extends StatefulWidget {
  const OdjelScreen({Key? key}) : super(key: key);

  @override
  State<OdjelScreen> createState() => _OdjelScreen();
}

class _OdjelScreen extends State<OdjelScreen> {
  late OdjelProvider _odjelProvider;
  SearchResult<Odjel>? odjelResult;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _odjelProvider = context.read<OdjelProvider>();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    var data = await _odjelProvider.get();
    setState(() {
      odjelResult = data;
    });
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
        child: DataTable(
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
          ],
          rows: odjelResult?.result
                  .map((Odjel e) => DataRow(
                        cells: [
                          DataCell(Text(e.naziv ?? "")),
                          DataCell(Text(e.telefon ?? "")),
                        ],
                      ))
                  .toList() ??
              [],
        ),
      ),
    );
  }
}
