// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnik.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Korisnik _$KorisnikFromJson(Map<String, dynamic> json) => Korisnik(
      korisnikId: (json['korisnikId'] as num?)?.toInt(),
      ime: json['ime'] as String?,
      prezime: json['prezime'] as String?,
      korisnickoIme: json['korisnickoIme'] as String?,
      spol: json['spol'] as String?,
      telefon: json['telefon'] as String?,
      email: json['email'] as String?,
      datumRodjenja: json['datumRodjenja'] as String?,
      ulogaId: (json['ulogaId'] as num?)?.toInt(),
      lozinka: json['lozinka'] as String?,
    );

Map<String, dynamic> _$KorisnikToJson(Korisnik instance) => <String, dynamic>{
      'korisnikId': instance.korisnikId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'korisnickoIme': instance.korisnickoIme,
      'lozinka': instance.lozinka,
      'spol': instance.spol,
      'telefon': instance.telefon,
      'email': instance.email,
      'datumRodjenja': instance.datumRodjenja,
      'ulogaId': instance.ulogaId,
    };
