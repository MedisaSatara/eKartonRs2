// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tehnicka_podrska.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TehnickaPodrska _$TehnickaPodrskaFromJson(Map<String, dynamic> json) =>
    TehnickaPodrska(
      tehnickaPodrskaId: (json['tehnickaPodrskaId'] as num?)?.toInt(),
      brojPozivaDoSada: (json['brojPozivaDoSada'] as num?)?.toInt(),
      najcesciProblemi: json['najcesciProblemi'] as String?,
    );

Map<String, dynamic> _$TehnickaPodrskaToJson(TehnickaPodrska instance) =>
    <String, dynamic>{
      'tehnickaPodrskaId': instance.tehnickaPodrskaId,
      'brojPozivaDoSada': instance.brojPozivaDoSada,
      'najcesciProblemi': instance.najcesciProblemi,
    };
