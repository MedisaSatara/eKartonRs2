// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocjene_doktor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OcjeneDoktor _$OcjeneDoktorFromJson(Map<String, dynamic> json) => OcjeneDoktor(
      ocjenaId: (json['ocjenaId'] as num?)?.toInt(),
      ocjena: (json['ocjena'] as num?)?.toInt(),
      razlog: json['razlog'] as String?,
      anonimno: json['anonimno'] as bool?,
      doktorId: (json['doktorId'] as num).toInt(),
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OcjeneDoktorToJson(OcjeneDoktor instance) =>
    <String, dynamic>{
      'ocjenaId': instance.ocjenaId,
      'ocjena': instance.ocjena,
      'razlog': instance.razlog,
      'anonimno': instance.anonimno,
      'doktorId': instance.doktorId,
      'korisnikId': instance.korisnikId,
    };
