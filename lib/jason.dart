import 'package:api/catogaries_modal.dart';

class Sam {
  String bgColor;
  String? banner;
  String icon;
  int id;
  Name name;

  Sam({
     required this.bgColor,
     this.banner,
     required this.icon,
      required this.id,
      required this.name});

  factory Sam.fromJson(Map <String, dynamic> json){
    return Sam(
      bgColor: json['bgColor'] as String,
      banner: json['banner'] as String,
      icon: json['icon'] as String,
      id: json['id'] as int,
      name: Name.fromJson(json["name"]),
    );
  }
}
class Name{
  String en;
  String hi;

  Name({
     required this.en,
    required this.hi});
  factory Name.fromJson(Map<String, dynamic>json){
    return Name(
      en: json['en'] as String,
      hi: json['hi'] as String,
    );
  }
}