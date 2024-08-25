import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'korisnik.g.dart';

@JsonSerializable()
class Korisnik {
  int? korisnikId;
  String? ime;
  String? prezime;
  String? korisnickoIme;
  String? lozinka;
  String? spol;
  String? telefon;
  String? email;
  String? datumRodjenja;
  int? ulogaId;

  Korisnik(
      {this.korisnikId,
      this.ime,
      this.prezime,
      this.korisnickoIme,
      this.spol,
      this.telefon,
      this.email,
      this.datumRodjenja,
      this.ulogaId,
      this.lozinka});

  factory Korisnik.fromJson(Map<String, dynamic> json) =>
      _$KorisnikFromJson(json);

  Map<String, dynamic> toJson() => _$KorisnikToJson(this);
}
