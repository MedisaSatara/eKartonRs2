import 'dart:ffi';
import 'package:json_annotation/json_annotation.dart';

part 'termin.g.dart';

@JsonSerializable()
class Termin {
  Termin(
    this.terminId,
    this.datum,
    this.vrijeme,
    this.razlog,
    this.pacijentId,
    this.doktorId,
    this.stateMachine,
    this.brojTransakcije,
    this.cijenaPregleda,
  );

  int? terminId;
  String? datum;
  String? vrijeme;
  String? razlog;
  int? pacijentId;
  int? doktorId;
  String? stateMachine;
  String? brojTransakcije;
  double? cijenaPregleda;

  factory Termin.fromJson(Map<String, dynamic> json) => _$TerminFromJson(json);

  Map<String, dynamic> toJson() => _$TerminToJson(this);

  Termin copyWith({
    int? terminId,
    String? datum,
    String? vrijeme,
    String? razlog,
    int? pacijentId,
    int? doktorId,
    String? stateMachine,
    String? brojTransakcije,
    double? cijenaPregleda,
  }) {
    return Termin(
      terminId ?? this.terminId,
      datum ?? this.datum,
      vrijeme ?? this.vrijeme,
      razlog ?? this.razlog,
      pacijentId ?? this.pacijentId,
      doktorId ?? this.doktorId,
      stateMachine ?? this.stateMachine,
      brojTransakcije ?? this.brojTransakcije,
      cijenaPregleda ?? this.cijenaPregleda,
    );
  }
}
