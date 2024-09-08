// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doktori_pregled_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoktoriPregledReport _$DoktoriPregledReportFromJson(
        Map<String, dynamic> json) =>
    DoktoriPregledReport(
      imeDoktora: json['imeDoktora'] as String?,
      specijalizacija: json['specijalizacija'] as String?,
      brojPregleda: (json['brojPregleda'] as num?)?.toInt(),
      brojPacijenata: (json['brojPacijenata'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DoktoriPregledReportToJson(
        DoktoriPregledReport instance) =>
    <String, dynamic>{
      'imeDoktora': instance.imeDoktora,
      'specijalizacija': instance.specijalizacija,
      'brojPregleda': instance.brojPregleda,
      'brojPacijenata': instance.brojPacijenata,
    };
