// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'administrator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Administrator _$AdministratorFromJson(Map<String, dynamic> json) =>
    Administrator(
      administratorId: (json['administratorId'] as num?)?.toInt(),
      ime: json['ime'] as String?,
      prezime: json['prezime'] as String?,
      datumRodjenja: json['datumRodjenja'] as String?,
      prebivaliste: json['prebivaliste'] as String?,
      telefon: json['telefon'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$AdministratorToJson(Administrator instance) =>
    <String, dynamic>{
      'administratorId': instance.administratorId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'datumRodjenja': instance.datumRodjenja,
      'prebivaliste': instance.prebivaliste,
      'telefon': instance.telefon,
      'email': instance.email,
    };
