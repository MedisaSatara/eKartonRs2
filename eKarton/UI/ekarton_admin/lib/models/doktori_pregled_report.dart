import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'doktori_pregled_report.g.dart';

@JsonSerializable()
class DoktoriPregledReport {
  String? imeDoktora;
  String? specijalizacija;
  int? brojPregleda;
  int? brojPacijenata;

  DoktoriPregledReport(
      {this.imeDoktora,
      this.specijalizacija,
      this.brojPregleda,
      this.brojPacijenata});

  factory DoktoriPregledReport.fromJson(Map<String, dynamic> json) {
    return DoktoriPregledReport(
      imeDoktora: json['imeDoktora'] as String?,
      specijalizacija: json['specijalizacija'] as String?,
      brojPregleda: json['brojPregleda'] != null
          ? int.tryParse(json['brojPregleda'].toString()) ?? 0
          : 0,
      brojPacijenata: json['brojPacijenata'] != null
          ? int.tryParse(json['brojPacijenata'].toString()) ?? 0
          : 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'imeDoktora': imeDoktora,
        'specijalizacija': specijalizacija,
        'brojPregleda': brojPregleda,
        'brojPacijenata': brojPacijenata,
      };
}
