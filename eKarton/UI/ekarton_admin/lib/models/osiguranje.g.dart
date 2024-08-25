// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'osiguranje.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Osiguranje _$OsiguranjeFromJson(Map<String, dynamic> json) => Osiguranje(
      osiguranjeId: (json['osiguranjeId'] as num?)?.toInt(),
      osiguranik: json['osiguranik'] as String?,
    );

Map<String, dynamic> _$OsiguranjeToJson(Osiguranje instance) =>
    <String, dynamic>{
      'osiguranjeId': instance.osiguranjeId,
      'osiguranik': instance.osiguranik,
    };
