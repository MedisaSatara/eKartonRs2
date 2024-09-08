// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bolesti_statistika.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BolestiStatistika _$BolestiStatistikaFromJson(Map<String, dynamic> json) =>
    BolestiStatistika(
      dijagnoza: json['dijagnoza'] as String?,
      brojPacijenata: (json['brojPacijenata'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BolestiStatistikaToJson(BolestiStatistika instance) =>
    <String, dynamic>{
      'dijagnoza': instance.dijagnoza,
      'brojPacijenata': instance.brojPacijenata,
    };
