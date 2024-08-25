import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'pacijent_oboljenja.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class PacijentOboljenja {
  PacijentOboljenja(this.oboljenjeId, this.pacijentId, this.nesposobanZaRad,
      this.nesposobanZaRadOd, this.nesposobanZaRadDo);

  int? oboljenjeId;
  int? pacijentId;
  String? nesposobanZaRad;
  String? nesposobanZaRadOd;
  String? nesposobanZaRadDo;

  factory PacijentOboljenja.fromJson(Map<String, dynamic> json) =>
      _$PacijentOboljenjaFromJson(json);

  Map<String, dynamic> toJson() => _$PacijentOboljenjaToJson(this);
}
