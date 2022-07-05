class PhotosModel {
  String? url;
  String? photographer;
  String? photographerUrl;
  int? photographerId;
  SrcModel? src;

  PhotosModel({
    this.url, this.photographer, this.photographerUrl, this.photographerId, this.src
  });

  factory PhotosModel.fromMap(Map<String, dynamic> parsedJson){
    return PhotosModel(
      url: parsedJson["url"],
      photographer: parsedJson["photographer"],
      photographerUrl: parsedJson["photographer_url"],
      photographerId: parsedJson["photographer_id"],
      src: SrcModel.fromMap(parsedJson["src"]),


    );
  }
}

class SrcModel {
  String portrait;
  String? large;
  String? landscape;
  String? medium;

  SrcModel({
    required this.portrait, this.large, this.landscape, this.medium
  });

  factory SrcModel.fromMap(Map<String, dynamic> srcJson){
    return SrcModel(
      portrait: srcJson["potrait"],
      large: srcJson["large"],
      landscape: srcJson["landscape"],
      medium: srcJson["medium"],
    );

  }


}