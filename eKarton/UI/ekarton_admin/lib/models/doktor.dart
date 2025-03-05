import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'doktor.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Doktor {
  Doktor(
      {this.doktorId,
      this.ime,
      this.prezime,
      this.datumRodjenja,
      this.spol,
      this.jmbg,
      this.email,
      this.grad,
      this.telefon,
      this.stateMachine,
      this.odjelId});

  int? doktorId;
  String? ime;
  String? prezime;
  String? spol;
  String? grad;
  String? jmbg;
  String? telefon;
  String? email;
  String? datumRodjenja;
  int? odjelId;
  String? stateMachine;

  factory Doktor.fromJson(Map<String, dynamic> json) => _$DoktorFromJson(json);

  Map<String, dynamic> toJson() => _$DoktorToJson(this);
}
