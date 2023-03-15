import 'dart:convert';

SqlCardModel sqlCardModelFromJson(String str) => SqlCardModel.fromJson(json.decode(str));
String sqlCardModelToJson(SqlCardModel data) => json.encode(data.toJson());
class SqlCardModel {
  SqlCardModel({
    this.id,
    required this.name,
    required this.number,
    required this.balance,
    required this.expiration,
    this.image, this.fileImage,
    required this.type,
    });

  factory SqlCardModel.fromJson(Map<String, dynamic> json) => SqlCardModel(
    id : json['id'] ?? 0,
    name : json['card_name'],
    number : json['card_number'],
    expiration : json['card_expiration'],
    balance : json['card_balance'],
    image : json['card_image'],
    type : json['card_type'],
    fileImage : json['file_image'],
  );

  int? id;
  String name;
  String number;
  String balance;
  String expiration;
  String? image;
  String? fileImage;
  String type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['card_name'] = name;
    map['card_number'] = number;
    map['card_expiration'] = expiration;
    map['card_balance'] = balance;
    map['card_image'] = image;
    map['card_type'] = type;
    map['file_image'] = fileImage;
    return map;
  }

  @override
  String toString() => "id: $id, cardName: $name, cardNumber: $number, cardBalance: $balance, cardExpiration: $expiration, cardImage: $image, CardType: $type";

}