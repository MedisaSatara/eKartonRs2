// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pregled.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pregled _$PregledFromJson(Map<String, dynamic> json) => Pregled(
      pregledId: (json['pregledId'] as num?)?.toInt(),
      datum: json['datum'] == null
          ? null
          : DateTime.parse(json['datum'] as String),
      razlogPosjete: json['razlogPosjete'] as String?,
      dijagnoza: json['dijagnoza'] as String?,
      terapijaId: (json['terapijaId'] as num?)?.toInt(),
      uputnicaId: (json['uputnicaId'] as num?)?.toInt(),
      doktorId: (json['doktorId'] as num?)?.toInt(),
      pacijentId: (json['pacijentId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PregledToJson(Pregled instance) => <String, dynamic>{
      'pregledId': instance.pregledId,
      'datum': instance.datum?.toIso8601String(),
      'razlogPosjete': instance.razlogPosjete,
      'dijagnoza': instance.dijagnoza,
      'terapijaId': instance.terapijaId,
      'uputnicaId': instance.uputnicaId,
      'doktorId': instance.doktorId,
      'pacijentId': instance.pacijentId,
    };
