// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pacijent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pacijent _$PacijentFromJson(Map<String, dynamic> json) => Pacijent(
      (json['pacijentId'] as num?)?.toInt(),
      json['ime'] as String?,
      json['prezime'] as String?,
      json['spol'] as String?,
      json['datumRodjenja'] == null
          ? null
          : DateTime.parse(json['datumRodjenja'] as String),
      json['mjestoRodjenja'] as String?,
      json['jmbg'] as String?,
      json['telefon'] as String?,
      json['prebivaliste'] as String?,
      json['krvnaGrupa'] as String?,
      json['rhFaktor'] as String?,
      json['brojKartona'] as String?,
      json['alergija'] as String?,
      json['hronicneBolesti'] as String?,
      json['korisnickoIme'] as String?,
    )..koagulopatija = json['koagulopatija'] as bool?;

Map<String, dynamic> _$PacijentToJson(Pacijent instance) => <String, dynamic>{
      'pacijentId': instance.pacijentId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'spol': instance.spol,
      'datumRodjenja': instance.datumRodjenja?.toIso8601String(),
      'mjestoRodjenja': instance.mjestoRodjenja,
      'jmbg': instance.jmbg,
      'telefon': instance.telefon,
      'prebivaliste': instance.prebivaliste,
      'krvnaGrupa': instance.krvnaGrupa,
      'rhFaktor': instance.rhFaktor,
      'hronicneBolesti': instance.hronicneBolesti,
      'brojKartona': instance.brojKartona,
      'korisnickoIme': instance.korisnickoIme,
      'alergija': instance.alergija,
      'koagulopatija': instance.koagulopatija,
    };
