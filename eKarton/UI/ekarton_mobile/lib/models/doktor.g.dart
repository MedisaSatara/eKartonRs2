// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doktor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doktor _$DoktorFromJson(Map<String, dynamic> json) => Doktor(
      doktorId: (json['doktorId'] as num?)?.toInt(),
      ime: json['ime'] as String?,
      prezime: json['prezime'] as String?,
      datumRodjenja: json['datumRodjenja'] as String?,
      spol: json['spol'] as String?,
      jmbg: json['jmbg'] as String?,
      email: json['email'] as String?,
      grad: json['grad'] as String?,
      telefon: json['telefon'] as String?,
      odjelId: (json['odjelId'] as num?)?.toInt(),
      averageRating: (json['averageRating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DoktorToJson(Doktor instance) => <String, dynamic>{
      'doktorId': instance.doktorId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'spol': instance.spol,
      'grad': instance.grad,
      'jmbg': instance.jmbg,
      'telefon': instance.telefon,
      'email': instance.email,
      'datumRodjenja': instance.datumRodjenja,
      'odjelId': instance.odjelId,
      'averageRating': instance.averageRating,
    };
