import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'terapija.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Terapija {
  Terapija(this.terapijaId, this.nazivLijeka, this.uputa, this.od, this.doKada,
      this.podsjetnik);

  int? terapijaId;
  String? nazivLijeka;
  String? uputa;
  String? od;
  String? doKada;
  String? podsjetnik;

  factory Terapija.fromJson(Map<String, dynamic> json) =>
      _$TerapijaFromJson(json);

  Map<String, dynamic> toJson() => _$TerapijaToJson(this);
}
