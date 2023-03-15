import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as im;
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as ph;
import 'package:path_provider/path_provider.dart';
import 'package:task_bank_card/consts/colors.dart';
import 'package:uuid/uuid.dart';

class ImageService{

  static Future<String?> compressImage(File imageFile) async {
    var uuid = const Uuid();
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    im.Image? image = im.decodeImage(imageFile.readAsBytesSync());
    if (image == null) {
      return null;
    } else {
      im.Image smallerImage = im.copyResize(image, height: 512);
      var compressedImage = File('$path/i${uuid.v4()}.jpg')
        ..writeAsBytesSync(im.encodeJpg(smallerImage, quality: 90));
      return compressedImage.path;
    }
  }

  static Future<String?> imageCrop(String path, {CropStyle? cropStyle, List<CropAspectRatioPreset>? aspectRatioPresets}) async {
    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        compressFormat: ImageCompressFormat.jpg,
        cropStyle: cropStyle ?? CropStyle.rectangle,
        aspectRatio: aspectRatioPresets != null
            ? aspectRatioPresets.contains(CropAspectRatioPreset.square)
            ? const CropAspectRatio(ratioX: 1, ratioY: 1)
            : aspectRatioPresets.contains(CropAspectRatioPreset.ratio16x9)
            ? const CropAspectRatio(ratioX: 9, ratioY: 16)
            : null
            : null,
        aspectRatioPresets: aspectRatioPresets ?? [CropAspectRatioPreset.original, CropAspectRatioPreset.ratio16x9],
        sourcePath: path,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: MyColors.darkBlue,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
          )
        ],
      );
      if (croppedFile != null) {
        final directory = await getExternalStorageDirectory();
        final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
        final newPath = '${directory?.path}/$fileName';
        try {
          final newImage = await File(newPath).copy(newPath);
          return newImage.path;
        } catch (e) {
          log('Error saving image: $e');
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

}