import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'odjel.g.dart';

@JsonSerializable()
class Odjel {
  int? odjelId;
  String? naziv;
  String? telefon;

  Odjel({this.odjelId, this.naziv, this.telefon});

  factory Odjel.fromJson(Map<String, dynamic> json) => _$OdjelFromJson(json);

  Map<String, dynamic> toJson() => _$OdjelToJson(this);
}
