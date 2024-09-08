import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'bolesti_statistika.g.dart';

@JsonSerializable()
class BolestiStatistika {
  String? dijagnoza;
  int? brojPacijenata;

  BolestiStatistika({this.dijagnoza, this.brojPacijenata});

  factory BolestiStatistika.fromJson(Map<String, dynamic> json) {
    return BolestiStatistika(
      dijagnoza: json['dijagnoza'] as String?,
      brojPacijenata: json['brojPacijenata'] != null
          ? int.tryParse(json['brojPacijenata'].toString()) ?? 0
          : 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'dijagnoza': dijagnoza,
        'brojPacijenata': brojPacijenata,
      };
}
