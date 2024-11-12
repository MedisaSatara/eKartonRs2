import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'tehnicka_podrska.g.dart';

@JsonSerializable()
class TehnickaPodrska {
  int? tehnickaPodrskaId;
  int? brojPozivaDoSada;
  String? najcesciProblemi;

  TehnickaPodrska(
      {this.tehnickaPodrskaId, this.brojPozivaDoSada, this.najcesciProblemi});

  factory TehnickaPodrska.fromJson(Map<String, dynamic> json) =>
      _$TehnickaPodrskaFromJson(json);

  Map<String, dynamic> toJson() => _$TehnickaPodrskaToJson(this);
}
