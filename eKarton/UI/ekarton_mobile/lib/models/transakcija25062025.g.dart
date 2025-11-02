// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transakcija25062025.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transakcija25062025 _$Transakcija25062025FromJson(Map<String, dynamic> json) =>
    Transakcija25062025(
      (json['transkacijeId'] as num?)?.toInt(),
      (json['korisnikId'] as num?)?.toInt(),
      (json['kategorijaTransakcijaId'] as num?)?.toInt(),
      (json['iznos'] as num?)?.toInt(),
      json['datumTransakcije'] == null
          ? null
          : DateTime.parse(json['datumTransakcije'] as String),
      json['opis'] as String?,
      json['status'] as String?,
    );

Map<String, dynamic> _$Transakcija25062025ToJson(
        Transakcija25062025 instance) =>
    <String, dynamic>{
      'transkacijeId': instance.transkacijeId,
      'korisnikId': instance.korisnikId,
      'kategorijaTransakcijaId': instance.kategorijaTransakcijaId,
      'iznos': instance.iznos,
      'datumTransakcije': instance.datumTransakcije?.toIso8601String(),
      'opis': instance.opis,
      'status': instance.status,
    };
