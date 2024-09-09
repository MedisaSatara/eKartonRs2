import 'package:ekarton_admin/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:ekarton_admin/models/bolesti_po_godistu_report.dart';
import 'package:ekarton_admin/models/doktori_pregled_report.dart';
import 'package:ekarton_admin/models/odabrani_doktori.dart';
import 'package:ekarton_admin/providers/doktori_pregled.dart';
import 'package:ekarton_admin/providers/top3_doktora.dart';
import 'package:ekarton_admin/providers/bolesti_po_godistu.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreen();
}

class _ReportScreen extends State<ReportScreen> {
  late Future<List<OdabraniDoktori>> futureDoktorReports;
  late Future<List<DoktoriPregledReport>> futurePreglediReports;
  late Future<List<BolestiPoGodistuReport>> futureBolestiReports;

  String currentReport = '';

  @override
  void initState() {
    super.initState();
    futureDoktorReports = Top3Doktora().fetchTop3Doktora();
    futurePreglediReports = DoktoriPregled().fetchPreglediPoDoktoru();
    futureBolestiReports = BolestiPoGodistu().fetchBolestiPoGodistuReport();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Izvještaji',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentReport = 'doktor';
                  });
                },
                child: const Text('Top 3 Doktora'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentReport = 'pregledi';
                  });
                },
                child: const Text('Pregledi Po Doktoru'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentReport = 'bolesti';
                  });
                },
                child: const Text('Bolesti Po Godištu'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (currentReport == 'doktor')
                    _buildReportSection(
                      title: 'Top 3 Najposećenija Doktora',
                      future: futureDoktorReports,
                      itemBuilder: (context, doktor) => ListTile(
                        title: Text(doktor.imeDoktora ?? ""),
                        subtitle:
                            Text('Specijalizacija: ${doktor.specijalizacija}'),
                        trailing: Text(
                            'Zakazani termini: ${doktor.brojZakazanihTermina}'),
                      ),
                    ),
                  if (currentReport == 'pregledi')
                    _buildReportSection(
                      title: 'Pregledi Po Doktoru',
                      future: futurePreglediReports,
                      itemBuilder: (context, pregled) => ListTile(
                        title: Text(pregled.imeDoktora ?? ""),
                        subtitle:
                            Text('Broj pregleda: ${pregled.brojPregleda}'),
                        trailing: Text('Pacijenata: ${pregled.brojPacijenata}'),
                      ),
                    ),
                  if (currentReport == 'bolesti')
                    _buildReportSection(
                      title: 'Bolesti Po Godištu',
                      future: futureBolestiReports,
                      itemBuilder: (context, bolest) => ListTile(
                        title: Text('Godina: ${bolest.decade}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var bolestDetail in bolest.najcesceBolesti)
                              Text(
                                  '${bolestDetail.dijagnoza}: ${bolestDetail.brojPacijenata} pacijenata'),
                          ],
                        ),
                      ),
                    ),
                  if (currentReport.isEmpty)
                    const Center(
                      child: Text('Odaberite izvještaj za prikaz.'),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportSection<T>({
    required String title,
    required Future<List<T>> future,
    required Widget Function(BuildContext, T) itemBuilder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        FutureBuilder<List<T>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Greška pri učitavanju podataka'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Nema podataka za prikaz'));
            } else {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  T report = snapshot.data![index];
                  return itemBuilder(context, report);
                },
              );
            }
          },
        ),
      ],
    );
  }
}
