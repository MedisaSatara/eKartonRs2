import 'package:ekarton_mobile/main.dart';
import 'package:ekarton_mobile/models/search_result.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';
import 'package:ekarton_mobile/models/pacijent_oboljenja.dart';
import 'package:ekarton_mobile/models/search_result.dart';
import 'package:ekarton_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class PregledScreen extends StatefulWidget {
  @override
  State<PregledScreen> createState() => _PregledScreen();
}

class _PregledScreen extends State<PregledScreen> {
  @override
  Widget build(BuildContext context) {
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
                  'Razlog posjete',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Dijagnoza',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Terapija',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: [], // Populate with data as needed
        ),
      ),
    );
  }
}
