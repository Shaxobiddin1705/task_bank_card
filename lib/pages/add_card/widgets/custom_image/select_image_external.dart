import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_bank_card/consts/styles.dart';
import 'package:task_bank_card/services/image_service.dart';

class SelectImageFromExternal extends StatefulWidget {
  final Function(String image, File file) onChange;
  const SelectImageFromExternal({Key? key, required this.onChange}) : super(key: key);

  @override
  State<SelectImageFromExternal> createState() => _SelectImageFromExternalState();
}

class _SelectImageFromExternalState extends State<SelectImageFromExternal> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          Text('Select image from internal storage', style: CStyle.cStyle(fontSize: 16, color: const Color(0xFF9CA3AF))),

          const SizedBox(height: 8),

          Row(
            children: [
              InkWell(
                onTap: () async{
                  final image = await _picker.pickImage(source: ImageSource.camera);
                  if(image != null)  {
                    final croppedImage = await ImageService.imageCrop(image.path);
                    log(croppedImage.toString());
                    final result = await ImageService.compressImage(File(croppedImage ?? image.path));
                    widget.onChange(result ?? '', File(image.path));
                  }
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset('assets/icons/camera_icon.svg'),
                ),
              ),
              const SizedBox(width: 24),
              InkWell(
                onTap: () async{
                  final image = await _picker.pickImage(source: ImageSource.gallery);
                  if(image != null) {
                    final croppedImage = await ImageService.imageCrop(image.path);
                    log(croppedImage.toString());
                    final result = await ImageService.compressImage(File(croppedImage ?? image.path));
                    widget.onChange(result ?? '', File(image.path));
                  }
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset('assets/icons/gallery_icon.svg'),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }



}
