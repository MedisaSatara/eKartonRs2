
 import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'kategorijatranskacije.g.dart';

@JsonSerializable()
class Kategorijatranskacije {
  int? kategorijaTransakcijaId;
  String? nazivKategorije;
  String? tipKategorije;

  Kategorijatranskacije({this.kategorijaTransakcijaId, this.nazivKategorije, this.tipKategorije});

  factory Kategorijatranskacije.fromJson(Map<String, dynamic> json) => _$KategorijatranskacijeFromJson(json);

  Map<String, dynamic> toJson() => _$KategorijatranskacijeToJson(this);
}
