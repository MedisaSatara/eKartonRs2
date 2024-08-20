import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'administrator.g.dart';

@JsonSerializable()
class Administrator {
  int? administratorId;
  String? ime;
  String? prezime;
  String? datumRodjenja;
  String? prebivaliste;
  String? telefon;
  String? email;

  Administrator(
      {this.administratorId,
      this.ime,
      this.prezime,
      this.datumRodjenja,
      this.prebivaliste,
      this.telefon,
      this.email});

  factory Administrator.fromJson(Map<String, dynamic> json) =>
      _$AdministratorFromJson(json);

  Map<String, dynamic> toJson() => _$AdministratorToJson(this);
}
