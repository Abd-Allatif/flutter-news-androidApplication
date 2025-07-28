//getting and setting all the vairable from the api

class NewsModel {
  String? status;
  int? totalresults;
  List<Articles> articles = [];

  NewsModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    totalresults = json["totalResults"];
    json["articles"].forEach((elements) {
      articles.add(Articles.fromJson(elements));
    });
  }
}

class Articles {
  String? title;
  String? url;
  String? urltoimage;
  //named constructor to add all the values to the vars
  Articles.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    url = json["url"];
    urltoimage = json["urlToImage"];
  }
}
