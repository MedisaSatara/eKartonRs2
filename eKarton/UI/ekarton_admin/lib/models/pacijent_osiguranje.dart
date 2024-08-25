import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'pacijent_osiguranje.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class PacijentOsiguranje {
  PacijentOsiguranje(this.pacijentOsiguranjeId, this.pacijentId,
      this.osiguranjeId, this.datumOsiguranja, this.vazece);

  int? pacijentOsiguranjeId;
  int? pacijentId;
  int? osiguranjeId;
  String? datumOsiguranja;
  bool? vazece;

  factory PacijentOsiguranje.fromJson(Map<String, dynamic> json) =>
      _$PacijentOsiguranjeFromJson(json);

  Map<String, dynamic> toJson() => _$PacijentOsiguranjeToJson(this);
}
