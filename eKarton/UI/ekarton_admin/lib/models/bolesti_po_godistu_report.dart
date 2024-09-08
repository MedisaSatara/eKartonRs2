import 'package:ekarton_admin/models/bolesti_statistika.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'bolesti_po_godistu_report.g.dart';

@JsonSerializable()
class BolestiPoGodistuReport {
  String? decade;
  List<BolestiStatistika> najcesceBolesti;

  BolestiPoGodistuReport({this.decade, required this.najcesceBolesti});

  factory BolestiPoGodistuReport.fromJson(Map<String, dynamic> json) {
    return BolestiPoGodistuReport(
      decade: json['decade'] as String?,
      najcesceBolesti: (json['najcesceBolesti'] as List<dynamic>)
          .map((e) => BolestiStatistika.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'decade': decade,
        'najcesceBolesti': najcesceBolesti,
      };
}
