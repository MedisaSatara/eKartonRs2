// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kategorijatranskacije.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kategorijatranskacije _$KategorijatranskacijeFromJson(
        Map<String, dynamic> json) =>
    Kategorijatranskacije(
      kategorijaTransakcijaId:
          (json['kategorijaTransakcijaId'] as num?)?.toInt(),
      nazivKategorije: json['nazivKategorije'] as String?,
      tipKategorije: json['tipKategorije'] as String?,
    );

Map<String, dynamic> _$KategorijatranskacijeToJson(
        Kategorijatranskacije instance) =>
    <String, dynamic>{
      'kategorijaTransakcijaId': instance.kategorijaTransakcijaId,
      'nazivKategorije': instance.nazivKategorije,
      'tipKategorije': instance.tipKategorije,
    };
