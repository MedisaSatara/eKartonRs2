// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bolnica.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bolnica _$BolnicaFromJson(Map<String, dynamic> json) => Bolnica(
      bolnicaId: (json['bolnicaId'] as num?)?.toInt(),
      naziv: json['naziv'] as String?,
      adresa: json['adresa'] as String?,
      telefon: json['telefon'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$BolnicaToJson(Bolnica instance) => <String, dynamic>{
      'bolnicaId': instance.bolnicaId,
      'naziv': instance.naziv,
      'adresa': instance.adresa,
      'telefon': instance.telefon,
      'email': instance.email,
    };
