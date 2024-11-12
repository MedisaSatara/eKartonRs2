import 'package:ekarton_admin/main.dart';
import 'package:ekarton_admin/models/bolnica.dart';
import 'package:ekarton_admin/models/search_result.dart';
import 'package:ekarton_admin/providers/bolnica_provider.dart';
import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BolnicaScreen extends StatefulWidget {
  const BolnicaScreen({Key? key}) : super(key: key);

  @override
  State<BolnicaScreen> createState() => _BolnicaScreenState();
}

class _BolnicaScreenState extends State<BolnicaScreen> {
  late BolnicaProvider _bolnicaProvider;
  SearchResult<Bolnica>? result;

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text("Informacije o bolnici"),
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
                  'Adresa',
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
                  'Email',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: result?.result
                  .map((Bolnica e) => DataRow(
                        cells: [
                          DataCell(Text(e.naziv ?? "")),
                          DataCell(Text(e.telefon ?? "")),
                          DataCell(Text(e.adresa ?? "")),
                          DataCell(Text(e.email ?? "")),
                        ],
                      ))
                  .toList() ??
              [],
        ),
      ),
    );
  }
}
