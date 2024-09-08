import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'odabrani_doktori.g.dart';

@JsonSerializable()
class OdabraniDoktori {
  String? imeDoktora;
  String? specijalizacija;
  int? brojZakazanihTermina;

  OdabraniDoktori(
      {this.imeDoktora, this.specijalizacija, this.brojZakazanihTermina});

  factory OdabraniDoktori.fromJson(Map<String, dynamic> json) {
    return OdabraniDoktori(
      imeDoktora: json['imeDoktora'] as String?,
      specijalizacija: json['specijalizacija'] as String?,
      brojZakazanihTermina: json['brojZakazanihTermina'] != null
          ? int.tryParse(json['brojZakazanihTermina'].toString()) ?? 0
          : 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'imeDoktora': imeDoktora,
        'specijalizacija': specijalizacija,
        'brojZakazanihTermina': brojZakazanihTermina,
      };
}
