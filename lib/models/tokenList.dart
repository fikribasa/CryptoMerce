import 'package:intl/intl.dart';
import 'package:wartec_app/utils/numberFormatter.dart';

class TokenList {
  List<TokenItem>? item;

  TokenList({this.item});

  TokenList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      item = new List<TokenItem>.empty(growable: true);
      json['data'].forEach((v) {
        item!.add(new TokenItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> item = new Map<String, dynamic>();
    if (this.item != null) {
      item['data'] = this.item!.map((v) => v.toJson()).toList();
    }
    return item;
  }
}

class TokenItem {
  String? id;
  String? code;
  String? name;
  String? image;
  double? price;
  double? change;

  TokenItem(
      {this.id, this.code, this.name, this.image, this.price, this.change});

  TokenItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    image = json['image'];
    price = double.parse(json['price']);
    change = double.parse(json['change']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['change'] = this.change;
    return data;
  }

  get tokenPriceIDR => this.price!.toCurrencyFormat();
}
