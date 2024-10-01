import 'dart:ffi';

import 'package:ekarton_mobile/models/korisnik_uloga.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'ocjene_doktor.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class OcjeneDoktor {
  OcjeneDoktor(
      {this.ocjenaId,
      this.ocjena,
      this.razlog,
      this.anonimno,
      required this.doktorId,
      this.korisnikId});

  int? ocjenaId;
  int? ocjena;
  String? razlog;
  bool? anonimno;
  int doktorId;
  int? korisnikId;

  factory OcjeneDoktor.fromJson(Map<String, dynamic> json) =>
      _$OcjeneDoktorFromJson(json);

  Map<String, dynamic> toJson() => _$OcjeneDoktorToJson(this);
}
