
import 'package:flutter/material.dart';

class ChooseBackImage extends StatelessWidget {
  final int? selectedIndex;
  final int i;
  final String image;
  const ChooseBackImage({Key? key, required this.selectedIndex, required this.image, required this.i}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Visibility(
          visible: selectedIndex != null && selectedIndex == i,
          child: const Icon(Icons.done, size: 30, color: Colors.white),
        ),
        Opacity(
          opacity: selectedIndex == i ? 0.5 : 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset('assets/images/$image', fit: BoxFit.cover, height: 60, width: 120),
          ),
        ),
      ],
    );
  }
}
