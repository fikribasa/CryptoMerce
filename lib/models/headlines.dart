class Headlines {
  List<HeadlineItem>? data;

  Headlines({this.data});

  Headlines.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<HeadlineItem>.empty(growable: true);
      json['data'].forEach((v) {
        data!.add(new HeadlineItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HeadlineItem {
  String? newsUrl;
  String? imageUrl;
  String? title;
  String? text;
  String? sourceName;
  String? date;
  List<String>? topics;
  String? sentiment;
  String? type;

  HeadlineItem(
      {this.newsUrl,
      this.imageUrl,
      this.title,
      this.text,
      this.sourceName,
      this.date,
      this.topics,
      this.sentiment,
      this.type});

  HeadlineItem.fromJson(Map<String, dynamic> json) {
    newsUrl = json['news_url'];
    imageUrl = json['image_url'];
    title = json['title'];
    text = json['text'];
    sourceName = json['source_name'];
    date = json['date'];
    topics = json['topics'].cast<String>();
    sentiment = json['sentiment'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['news_url'] = this.newsUrl;
    data['image_url'] = this.imageUrl;
    data['title'] = this.title;
    data['text'] = this.text;
    data['source_name'] = this.sourceName;
    data['date'] = this.date;
    data['topics'] = this.topics;
    data['sentiment'] = this.sentiment;
    data['type'] = this.type;
    return data;
  }
}
