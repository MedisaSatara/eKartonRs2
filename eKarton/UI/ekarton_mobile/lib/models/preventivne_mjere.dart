import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'preventivne_mjere.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class PreventivneMjere {
  PreventivneMjere(this.preventivneMjereId, this.stanje, this.pacijentId);

  int? preventivneMjereId;
  String? stanje;
  int? pacijentId;

  factory PreventivneMjere.fromJson(Map<String, dynamic> json) =>
      _$PreventivneMjereFromJson(json);

  Map<String, dynamic> toJson() => _$PreventivneMjereToJson(this);
}
