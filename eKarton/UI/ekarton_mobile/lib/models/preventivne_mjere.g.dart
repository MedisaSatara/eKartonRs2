// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preventivne_mjere.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreventivneMjere _$PreventivneMjereFromJson(Map<String, dynamic> json) =>
    PreventivneMjere(
      (json['preventivneMjereId'] as num?)?.toInt(),
      json['stanje'] as String?,
      (json['pacijentId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PreventivneMjereToJson(PreventivneMjere instance) =>
    <String, dynamic>{
      'preventivneMjereId': instance.preventivneMjereId,
      'stanje': instance.stanje,
      'pacijentId': instance.pacijentId,
    };
