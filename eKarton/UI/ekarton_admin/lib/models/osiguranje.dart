import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'osiguranje.g.dart';

@JsonSerializable()
class Osiguranje {
  int? osiguranjeId;
  String? osiguranik;

  Osiguranje({this.osiguranjeId, this.osiguranik});

  factory Osiguranje.fromJson(Map<String, dynamic> json) =>
      _$OsiguranjeFromJson(json);

  Map<String, dynamic> toJson() => _$OsiguranjeToJson(this);
}
