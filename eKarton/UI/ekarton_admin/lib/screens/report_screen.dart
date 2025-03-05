import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final fontData = await rootBundle.load('assets/fonts/ttf/DejaVuSans.ttf');
    final ttf = pw.Font.ttf(fontData);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text(
              reportName,
              style: pw.TextStyle(
                  fontSize: 24, fontWeight: pw.FontWeight.bold, font: ttf),
            ),
          ),
          pw.Paragraph(
            text: "Izvještaj generisan: ${DateTime.now().toString()}",
            style: pw.TextStyle(
                fontSize: 12, fontStyle: pw.FontStyle.italic, font: ttf),
          ),
          pw.SizedBox(height: 20),
          ..._buildReportContent(data, ttf),
        ],
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

  List<pw.Widget> _buildReportContent(List<dynamic> data, pw.Font ttf) {
    List<pw.Widget> content = [];

    if (data.isNotEmpty) {
      if (data.first is OdabraniDoktori) {
        for (var doktor in data) {
          final doc = doktor as OdabraniDoktori;
          content.add(pw.Text(
              'Ovdje su prikazani podaci o najposjećenijem doktoru. Rangirali smo ih u top 3 najposjećenija doktora.',
              style: pw.TextStyle(
                font: ttf,
              )));
          content.add(pw.Text(
              'Jedan od njih je i doktor ${doc.imeDoktora ?? ''} ${doc.prezimeDoktora ?? ''}',
              style: pw.TextStyle(
                font: ttf,
              )));
          content.add(pw.Text(
              'Doktor radi specijalizaciju na odjelu ${doc.specijalizacija ?? ''}',
              style: pw.TextStyle(
                font: ttf,
              )));
          content.add(pw.Text(
              'Do sada je imao  ${doc.brojZakazanihTermina ?? ''} zakazanih termina kod pacijenata.',
              style: pw.TextStyle(
                font: ttf,
              )));

          content.add(pw.Text('Slijedi prikaz dodatnih informacija doktora:'));
          content.add(pw.Text('Datum rodjenja: ${doc.datumRodjenja ?? ''}',
              style: pw.TextStyle(
                font: ttf,
              )));
          content.add(pw.Text('Email: ${doc.email ?? ''}'));
          content.add(pw.Text('Telefon: ${doc.telefon ?? ''}'));
          content.add(pw.SizedBox(height: 10));
        }
      } else if (data.first is DoktoriPregledReport) {
        for (var pregled in data) {
          final preg = pregled as DoktoriPregledReport;
          content.add(pw.Text('Ime doktora: ${preg.imeDoktora ?? ''}',
              style: pw.TextStyle(
                font: ttf,
              )));
          content.add(pw.Text('Broj pregleda: ${preg.brojPregleda ?? 0}'));
          content.add(pw.SizedBox(height: 10));
        }
      } else if (data.first is BolestiPoGodistuReport) {
        for (var bolest in data) {
          final bol = bolest as BolestiPoGodistuReport;
          content.add(pw.Text('Godina: ${bol.decade ?? ''}'));
          for (var bolestDetalj in bol.najcesceBolesti) {
            content.add(pw.Text('Dijagnoza: ${bolestDetalj.dijagnoza ?? ''}',
                style: pw.TextStyle(
                  font: ttf,
                )));
            content.add(pw.Text(
                'Broj pacijenata: ${bolestDetalj.brojPacijenata ?? 0}'));
          }
          content.add(pw.SizedBox(height: 10));
        }
      }
    }

    return content;
  }

  List<String> _getHeaders(List<dynamic> data) {
    if (data.isNotEmpty) {
      if (data.first is OdabraniDoktori) {
        return [
          'Ime doktora',
          'Prezime doktora',
          'Datum rodjenja',
          'Email',
          'Telefon',
          'Specijalizacija'
        ];
      } else if (data.first is DoktoriPregledReport) {
        return ['Ime doktora', 'Broj pregleda'];
      } else if (data.first is BolestiPoGodistuReport) {
        return ['Godina', 'Bolesti'];
      }
    }
    return [];
  }

  List<List<String>> _getTableData(List<dynamic> data) {
    if (data.isNotEmpty) {
      if (data.first is OdabraniDoktori) {
        return data.map((e) {
          final doktor = e as OdabraniDoktori;
          return [
            doktor.imeDoktora ?? '',
            doktor.specijalizacija ?? '',
            doktor.prezimeDoktora ?? '',
            doktor.email ?? '',
            doktor.datumRodjenja ?? '',
            doktor.telefon ?? '',
          ];
        }).toList();
      } else if (data.first is DoktoriPregledReport) {
        return data.map((e) {
          final pregled = e as DoktoriPregledReport;
          return [pregled.imeDoktora ?? '', pregled.brojPregleda.toString()];
        }).toList();
      } else if (data.first is BolestiPoGodistuReport) {
        return data.map((e) {
          final bolest = e as BolestiPoGodistuReport;
          final bolestiDetalji = bolest.najcesceBolesti.map((d) {
            return '${d.dijagnoza}: ${d.brojPacijenata}';
          }).join(', ');
          return [bolest.decade.toString(), bolestiDetalji];
        }).toList();
      }
    }
    return [];
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
          Card(
            margin: const EdgeInsets.all(16.0),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Welcome to the report generation section!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Here you can view and download reports related to doctors, exams, and diseases.'
                    ' Click on one of the provided buttons to see the available data and generate a PDF report.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
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
                              icon: const Icon(Icons.download),
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
                              icon: const Icon(Icons.download),
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
                                'Dijagnoza: ${detail.dijagnoza} | Broj pacijenata sa dijagnozom: ${detail.brojPacijenata}');
                          }).toList(),
                        ),
                        trailing: Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.download),
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
