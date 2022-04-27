
class Data{
  String title;
  String urlToImage;

  Data({required this.title,
      required this.urlToImage});
  factory Data.fromJson(Map <String, dynamic> json){
    return Data(
      title: json['title'] as String,
      urlToImage: json['urlToImage']as String,
    );
  }
}