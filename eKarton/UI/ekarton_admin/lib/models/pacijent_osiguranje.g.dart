// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pacijent_osiguranje.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PacijentOsiguranje _$PacijentOsiguranjeFromJson(Map<String, dynamic> json) =>
    PacijentOsiguranje(
      (json['pacijentOsiguranjeId'] as num?)?.toInt(),
      (json['pacijentId'] as num?)?.toInt(),
      (json['osiguranjeId'] as num?)?.toInt(),
      json['datumOsiguranja'] as String?,
      json['vazece'] as bool?,
    );

Map<String, dynamic> _$PacijentOsiguranjeToJson(PacijentOsiguranje instance) =>
    <String, dynamic>{
      'pacijentOsiguranjeId': instance.pacijentOsiguranjeId,
      'pacijentId': instance.pacijentId,
      'osiguranjeId': instance.osiguranjeId,
      'datumOsiguranja': instance.datumOsiguranja,
      'vazece': instance.vazece,
    };
