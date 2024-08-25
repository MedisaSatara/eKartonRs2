import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'bolnica.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Bolnica {
  Bolnica({this.bolnicaId, this.naziv, this.adresa, this.telefon, this.email});

  int? bolnicaId;
  String? naziv;
  String? adresa;
  String? telefon;
  String? email;

  factory Bolnica.fromJson(Map<String, dynamic> json) =>
      _$BolnicaFromJson(json);

  Map<String, dynamic> toJson() => _$BolnicaToJson(this);
}
