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
      telefon: json['telefon'] as String?,
      datumRodjenja: json['datumRodjenja'] as String?,
      email: json['email'] as String?,
      spol: json['spol'] as String?,
      ulogaId: (json['ulogaId'] as num?)?.toInt(),
      lozinka: json['lozinka'] as String?,
    );

Map<String, dynamic> _$KorisnikToJson(Korisnik instance) => <String, dynamic>{
      'korisnikId': instance.korisnikId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'korisnickoIme': instance.korisnickoIme,
      'datumRodjenja': instance.datumRodjenja,
      'telefon': instance.telefon,
      'email': instance.email,
      'lozinka': instance.lozinka,
      'spol': instance.spol,
      'ulogaId': instance.ulogaId,
    };
