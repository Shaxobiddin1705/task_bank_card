import 'dart:convert';

import 'package:flutter/material.dart';

SqlCardModel sqlCardModelFromJson(String str) => SqlCardModel.fromJson(json.decode(str));
String sqlCardModelToJson(SqlCardModel data) => json.encode(data.toJson());
class SqlCardModel {
  SqlCardModel({
    this.id,
    required this.number,
    required this.expiration,
    this.image, this.fileImage,
    required this.type,
    this.color, this.yValue, this.xValue
    });

  factory SqlCardModel.fromJson(Map<String, dynamic> json) => SqlCardModel(
    id : json['id'] ?? 0,
    number : json['card_number'],
    expiration : json['card_expiration'],
    image : json['card_image'],
    type : json['card_type'],
    fileImage : json['card_file_image'],
    color: json['color'] != null ? json['color'] as Color : null,
    xValue: json['card_blur_x'],
    yValue: json['card_blur_y'],
  );

  int? id;
  String number;
  String expiration;
  String? image;
  String? fileImage;
  Color? color;
  double? xValue;
  double? yValue;
  String type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['card_number'] = number;
    map['card_expiration'] = expiration;
    map['card_image'] = image;
    map['card_type'] = type;
    map['card_file_image'] = fileImage;
    map['card_blur_x'] = xValue;
    map['card_blur_y'] = yValue;
    map['card_color'] = color;
    return map;
  }

  @override
  String toString() => 'id: $id, number: $number, expiration: $expiration, type: $type, xValue: $xValue, yValue: $yValue, color: $color';

}