// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terapija.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Terapija _$TerapijaFromJson(Map<String, dynamic> json) => Terapija(
      (json['terapijaId'] as num?)?.toInt(),
      json['nazivLijeka'] as String?,
      json['uputa'] as String?,
      json['od'] as String?,
      json['doKada'] as String?,
      json['podsjetnik'] as String?,
    );

Map<String, dynamic> _$TerapijaToJson(Terapija instance) => <String, dynamic>{
      'terapijaId': instance.terapijaId,
      'nazivLijeka': instance.nazivLijeka,
      'uputa': instance.uputa,
      'od': instance.od,
      'doKada': instance.doKada,
      'podsjetnik': instance.podsjetnik,
    };
