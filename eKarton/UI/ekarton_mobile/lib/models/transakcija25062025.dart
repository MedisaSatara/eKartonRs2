import 'package:json_annotation/json_annotation.dart';

part 'transakcija25062025.g.dart';

@JsonSerializable()
class Transakcija25062025 {
  Transakcija25062025(
    this.transkacijeId,
    this.korisnikId,
    this.kategorijaTransakcijaId,
    this.iznos,
    this.datumTransakcije,
    this.opis,
    this.status,
  );

  int? transkacijeId;
  int? korisnikId;
  int? kategorijaTransakcijaId;
  int? iznos;
  DateTime? datumTransakcije;
  String? opis;
  String? status;

  factory Transakcija25062025.fromJson(Map<String, dynamic> json) => _$Transakcija25062025FromJson(json);

  Map<String, dynamic> toJson() => _$Transakcija25062025ToJson(this);
}
