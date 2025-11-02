// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transkacijeLog25062025.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transkacijelog25062025 _$Transkacijelog25062025FromJson(
        Map<String, dynamic> json) =>
    Transkacijelog25062025(
      (json['transkacijeLogId'] as num?)?.toInt(),
      (json['korisnikId'] as num?)?.toInt(),
      (json['transkacijeId'] as num?)?.toInt(),
      json['stariStatus'] as String?,
      json['noviStatus'] as String?,
      json['vrijemePromjene'] == null
          ? null
          : DateTime.parse(json['vrijemePromjene'] as String),
    );

Map<String, dynamic> _$Transkacijelog25062025ToJson(
        Transkacijelog25062025 instance) =>
    <String, dynamic>{
      'transkacijeLogId': instance.transkacijeLogId,
      'korisnikId': instance.korisnikId,
      'transkacijeId': instance.transkacijeId,
      'stariStatus': instance.stariStatus,
      'noviStatus': instance.noviStatus,
      'vrijemePromjene': instance.vrijemePromjene?.toIso8601String(),
    };
