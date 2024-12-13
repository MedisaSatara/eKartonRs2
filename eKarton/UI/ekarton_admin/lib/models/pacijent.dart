import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'pacijent.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Pacijent {
  Pacijent(
      this.pacijentId,
      this.ime,
      this.prezime,
      this.spol,
      this.datumRodjenja,
      this.mjestoRodjenja,
      this.jmbg,
      this.telefon,
      this.prebivaliste,
      this.krvnaGrupa,
      this.rhFaktor,
      this.brojKartona,
      this.alergija,
      this.hronicneBolesti,
      this.korisnickoIme);

  int? pacijentId;
  String? ime;
  String? prezime;
  String? spol;
  DateTime? datumRodjenja;
  String? mjestoRodjenja;
  String? jmbg;
  String? telefon;
  String? prebivaliste;
  String? krvnaGrupa;
  String? rhFaktor;
  String? hronicneBolesti;
  String? brojKartona;
  String? korisnickoIme;
  String? alergija;
  bool? koagulopatija;

  factory Pacijent.fromJson(Map<String, dynamic> json) =>
      _$PacijentFromJson(json);

  Map<String, dynamic> toJson() => _$PacijentToJson(this);
}
