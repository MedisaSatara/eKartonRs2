import 'dart:ffi';
import 'package:json_annotation/json_annotation.dart';

part 'transkacijeLog25062025.g.dart';

@JsonSerializable()
class Transkacijelog25062025 {
  Transkacijelog25062025(
    this.transkacijeLogId,
    this.korisnikId,
    this.transkacijeId,
    this.stariStatus,
    this.noviStatus,
    this.vrijemePromjene,
  );

  int? transkacijeLogId;
  int? korisnikId;
  int? transkacijeId;
  String? stariStatus;
  String? noviStatus;
  DateTime? vrijemePromjene;

  factory Transkacijelog25062025.fromJson(Map<String, dynamic> json) => _$Transkacijelog25062025FromJson(json);

  Map<String, dynamic> toJson() => _$Transkacijelog25062025ToJson(this);
}
