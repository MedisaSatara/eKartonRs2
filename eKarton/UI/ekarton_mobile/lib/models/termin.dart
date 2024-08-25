import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'termin.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Termin {
  Termin(this.terminId, this.datum, this.vrijeme, this.razlog, this.pacijentId,
      this.doktorId);

  int? terminId;
  String? datum;
  String? vrijeme;
  String? razlog;
  int? pacijentId;
  int? doktorId;

  factory Termin.fromJson(Map<String, dynamic> json) => _$TerminFromJson(json);

  Map<String, dynamic> toJson() => _$TerminToJson(this);
}
