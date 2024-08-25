// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Termin _$TerminFromJson(Map<String, dynamic> json) => Termin(
      (json['terminId'] as num?)?.toInt(),
      json['datum'] as String?,
      json['vrijeme'] as String?,
      json['razlog'] as String?,
      (json['pacijentId'] as num?)?.toInt(),
      (json['doktorId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TerminToJson(Termin instance) => <String, dynamic>{
      'terminId': instance.terminId,
      'datum': instance.datum,
      'vrijeme': instance.vrijeme,
      'razlog': instance.razlog,
      'pacijentId': instance.pacijentId,
      'doktorId': instance.doktorId,
    };
