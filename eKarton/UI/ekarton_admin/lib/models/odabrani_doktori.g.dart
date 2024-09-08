// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'odabrani_doktori.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OdabraniDoktori _$OdabraniDoktoriFromJson(Map<String, dynamic> json) =>
    OdabraniDoktori(
      imeDoktora: json['imeDoktora'] as String?,
      specijalizacija: json['specijalizacija'] as String?,
      brojZakazanihTermina: (json['brojZakazanihTermina'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OdabraniDoktoriToJson(OdabraniDoktori instance) =>
    <String, dynamic>{
      'imeDoktora': instance.imeDoktora,
      'specijalizacija': instance.specijalizacija,
      'brojZakazanihTermina': instance.brojZakazanihTermina,
    };
