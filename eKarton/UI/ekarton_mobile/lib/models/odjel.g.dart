// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'odjel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Odjel _$OdjelFromJson(Map<String, dynamic> json) => Odjel(
      odjelId: (json['odjelId'] as num?)?.toInt(),
      naziv: json['naziv'] as String?,
      telefon: json['telefon'] as String?,
    );

Map<String, dynamic> _$OdjelToJson(Odjel instance) => <String, dynamic>{
      'odjelId': instance.odjelId,
      'naziv': instance.naziv,
      'telefon': instance.telefon,
    };
