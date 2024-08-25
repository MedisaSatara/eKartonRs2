import 'package:json_annotation/json_annotation.dart';

part 'nalaz.g.dart';

@JsonSerializable()
class Nalaz {
  Nalaz(this.nalazId, this.datum, this.licnaAnamneza, this.radnaAnamneza,
      this.pacijentId);

  int? nalazId;
  String? datum;
  String? licnaAnamneza;
  String? radnaAnamneza;
  int? pacijentId;

  factory Nalaz.fromJson(Map<String, dynamic> json) => _$NalazFromJson(json);

  Map<String, dynamic> toJson() => _$NalazToJson(this);
}
