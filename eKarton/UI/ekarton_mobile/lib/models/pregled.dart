import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'pregled.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Pregled {
  Pregled(
      {this.pregledId,
      this.datum,
      this.razlogPosjete,
      this.dijagnoza,
      this.terapijaId,
      this.uputnicaId,
      this.doktorId,
      this.pacijentId});

  int? pregledId;
  String? datum;
  String? razlogPosjete;
  String? dijagnoza;
  int? terapijaId;
  int? uputnicaId;
  int? doktorId;
  int? pacijentId;

  factory Pregled.fromJson(Map<String, dynamic> json) =>
      _$PregledFromJson(json);

  Map<String, dynamic> toJson() => _$PregledToJson(this);
}
