import 'dart:convert';
import 'dart:io';
import 'dart:ui';

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
    this.color, this.yValue, this.xValue, this.file
    });

  factory SqlCardModel.fromJson(Map<String, dynamic> json) => SqlCardModel(
    id : json['id'] ?? 0,
    number : json['card_number'],
    expiration : json['card_expiration'],
    image : json['card_image'],
    type : json['card_type'],
    fileImage : json['card_file_image'],
    color: json['card_color'] != null ? ColorClass.stringToColor(json['card_color']) as Color : null,
    xValue: json['card_blur_x'],
    yValue: json['card_blur_y'],
    file: json['file'],
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
  File? file;

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
    // map['card_color'] = color.toString().substring(color.toString().indexOf('(')+1, color.toString().length-1);
    map['card_color'] = ColorClass.colorToString(color);
    map['file'] = file;
    return map;
  }

  @override
  String toString() => 'id: $id, number: $number, expiration: $expiration, type: $type, xValue: $xValue, yValue: $yValue, color: $color';

}

class ColorClass {
  static String? colorToString(Color? color) {
    if(color == null) return null;
    String colorString = color.toString(); // Color(0x12345678)
    String valueString = colorString.split('(0x')[1].split(')')[0]; // kind of hacky..
    return valueString;
  }

  static Color? stringToColor(String? color) {
    if(color == null) return null;
    int value = int.parse(color, radix: 16);
    Color otherColor = Color(value);
    return otherColor;
  }
}