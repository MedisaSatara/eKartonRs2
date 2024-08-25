// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pacijent_oboljenja.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PacijentOboljenja _$PacijentOboljenjaFromJson(Map<String, dynamic> json) =>
    PacijentOboljenja(
      (json['oboljenjeId'] as num?)?.toInt(),
      (json['pacijentId'] as num?)?.toInt(),
      json['nesposobanZaRad'] as String?,
      json['nesposobanZaRadOd'] as String?,
      json['nesposobanZaRadDo'] as String?,
    );

Map<String, dynamic> _$PacijentOboljenjaToJson(PacijentOboljenja instance) =>
    <String, dynamic>{
      'oboljenjeId': instance.oboljenjeId,
      'pacijentId': instance.pacijentId,
      'nesposobanZaRad': instance.nesposobanZaRad,
      'nesposobanZaRadOd': instance.nesposobanZaRadOd,
      'nesposobanZaRadDo': instance.nesposobanZaRadDo,
    };
