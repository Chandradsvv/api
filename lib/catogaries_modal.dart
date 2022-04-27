class Name {
  String en;
  String hi;

  Name({required this.en, required this.hi});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      en: json['EN'] as String,
      hi: json['HI'] as String,
    );
  }
}
class Data {
  String icon;
  String? banner;
  String bgcolor;
  int id;
  Name name;

  Data({required this.icon,
    this.banner,
    required this.bgcolor,
    required this.id,
    required this.name});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      icon: json['icon'] as String,
      banner: json['banner'] as String?,
      bgcolor: json['bgcolor'] as String,
      id: json['id'] as int,
      name: Name.fromJson(json["name"]),
    );
  }
}