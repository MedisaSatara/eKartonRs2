// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nalaz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nalaz _$NalazFromJson(Map<String, dynamic> json) => Nalaz(
      (json['nalazId'] as num?)?.toInt(),
      json['datum'] as String?,
      json['licnaAnamneza'] as String?,
      json['radnaAnamneza'] as String?,
      (json['pacijentId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NalazToJson(Nalaz instance) => <String, dynamic>{
      'nalazId': instance.nalazId,
      'datum': instance.datum,
      'licnaAnamneza': instance.licnaAnamneza,
      'radnaAnamneza': instance.radnaAnamneza,
      'pacijentId': instance.pacijentId,
    };
