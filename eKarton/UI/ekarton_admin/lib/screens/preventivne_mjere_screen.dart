import 'package:ekarton_admin/main.dart';
import 'package:ekarton_admin/models/bolnica.dart';
import 'package:ekarton_admin/models/odjel.dart';
import 'package:ekarton_admin/models/preventivne_mjere.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/bolnica_provider.dart';
import 'package:ekarton_admin/providers/odjel_provider.dart';
import 'package:ekarton_admin/providers/preventivne_mjere_provider.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreventivneMjereScreen extends StatefulWidget {
  const PreventivneMjereScreen({Key? key}) : super(key: key);

  @override
  State<PreventivneMjereScreen> createState() => _PreventivneMjereScreen();
}

class _PreventivneMjereScreen extends State<PreventivneMjereScreen> {
  late PreventivneMjereProvider _preventivneMjereProvider;
  SearchResult<PreventivneMjere>? preventivneMjereResult;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _preventivneMjereProvider = context.read<PreventivneMjereProvider>();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    var data = await _preventivneMjereProvider.get();
    setState(() {
      preventivneMjereResult = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text("Preventivne mjere pacijenata"),
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
                  'Stanje',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'PacijentId',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: preventivneMjereResult?.result
                  .map((PreventivneMjere e) => DataRow(
                        cells: [
                          DataCell(Text(e.stanje ?? "")),
                          DataCell(Text(e.preventivneMjereId.toString() ?? "")),
                        ],
                      ))
                  .toList() ??
              [],
        ),
      ),
    );
  }
}
