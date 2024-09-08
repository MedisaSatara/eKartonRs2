// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bolesti_po_godistu_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BolestiPoGodistuReport _$BolestiPoGodistuReportFromJson(
        Map<String, dynamic> json) =>
    BolestiPoGodistuReport(
      decade: json['decade'] as String?,
      najcesceBolesti: (json['najcesceBolesti'] as List<dynamic>)
          .map((e) => BolestiStatistika.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BolestiPoGodistuReportToJson(
        BolestiPoGodistuReport instance) =>
    <String, dynamic>{
      'decade': instance.decade,
      'najcesceBolesti': instance.najcesceBolesti,
    };
