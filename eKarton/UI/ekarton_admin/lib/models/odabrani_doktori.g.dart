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
      prezimeDoktora: json['prezimeDoktora'] as String?,
      datumRodjenja: json['datumRodjenja'] as String?,
      email: json['email'] as String?,
      telefon: json['telefon'] as String?,
    );

Map<String, dynamic> _$OdabraniDoktoriToJson(OdabraniDoktori instance) =>
    <String, dynamic>{
      'imeDoktora': instance.imeDoktora,
      'prezimeDoktora': instance.prezimeDoktora,
      'datumRodjenja': instance.datumRodjenja,
      'email': instance.email,
      'telefon': instance.telefon,
      'specijalizacija': instance.specijalizacija,
      'brojZakazanihTermina': instance.brojZakazanihTermina,
    };
