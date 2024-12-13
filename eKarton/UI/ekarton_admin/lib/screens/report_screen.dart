import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:ekarton_admin/widget/master_screen.dart';
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

  Future<void> _generatePdf(String reportName, List<dynamic> data) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(reportName, style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              ...data.map((item) {
                if (item is OdabraniDoktori) {
                  return pw.Text(
                      'Ime: ${item.imeDoktora}, Specijalizacija: ${item.specijalizacija}');
                } else if (item is DoktoriPregledReport) {
                  return pw.Text(
                      'Pregled kod: ${item.imeDoktora}, Broj pregleda: ${item.brojPregleda}');
                } else if (item is BolestiPoGodistuReport) {
                  return pw.Text('Godina: ${item.decade}');
                }
                return pw.Text(item.toString());
              }).toList(),
            ],
          );
        },
      ),
    );

    try {
      final outputDir = await getApplicationDocumentsDirectory();
      final filePath = '${outputDir.path}/$reportName.pdf';
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      print('PDF spremljen na $filePath');

      _showReportDownloadedDialog(filePath);
    } catch (e) {
      print('Greška: $e');
    }
  }

  void _showReportDownloadedDialog(String filePath) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Report Preuzet'),
          content: Text('Report je preuzet i sačuvan na:\n$filePath'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _updateReports() {
    setState(() {
      futureDoktorReports = Top3Doktora().fetchTop3Doktora();
      futurePreglediReports = DoktoriPregled().fetchPreglediPoDoktoru();
      futureBolestiReports = BolestiPoGodistu().fetchBolestiPoGodistuReport();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Reports',
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
                child: const Text('Top 3 Doctors'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentReport = 'pregledi';
                  });
                },
                child: const Text('Doctor\'s Checkups'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentReport = 'bolesti';
                  });
                },
                child: const Text('Diseases by Age'),
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
                        trailing: Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.download),
                              onPressed: () async {
                                await _generatePdf('Top 3 Doktora', [doktor]);
                              },
                            ),
                          ],
                        ),
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
                        trailing: Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.download),
                              onPressed: () async {
                                await _generatePdf(
                                    'Pregledi Po Doktoru', [pregled]);
                              },
                            ),
                          ],
                        ),
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
                          children: bolest.najcesceBolesti.map((detail) {
                            return Text(
                                '${detail.dijagnoza}: ${detail.brojPacijenata}');
                          }).toList(),
                        ),
                        trailing: Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.download),
                              onPressed: () async {
                                await _generatePdf(
                                    'Bolesti Po Godištu', [bolest]);
                              },
                            ),
                          ],
                        ),
                      ),
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
