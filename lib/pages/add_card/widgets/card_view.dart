import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_bank_card/consts/styles.dart';

class CardView extends StatelessWidget {
  final String? image;
  final String name;
  final File? file;
  final String expiration;
  final String number;
  final String type;
  CardView({Key? key, this.image, this.file, required this.name, required this.expiration, required this.number, required this.type}) : super(key: key);

  final Map<String, String> cards = {
    'uzcard' : 'assets/icons/uzcard_icon.png',
    'humo' : 'assets/icons/humo_icon.png',
    'mastercard' : 'assets/icons/mastercard_icon.png',
    'danger' : 'assets/icons/danger_icon.png',
    '' : 'assets/icons/danger_icon.png',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: 140,
      color: Colors.transparent,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: file == null ? Image.asset(image!, fit: BoxFit.cover) : Image.file(file!, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text( name.isNotEmpty ? name : 'Undefined',
                        style: CStyle.cStyle(fontSize: 14, fontWeight: 500, color: Colors.white)),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                      child: Image.asset(cards[type] ?? 'assets/icons/uzcard_icon.png', fit: BoxFit.scaleDown, height: 16, width: 24),
                    )
                  ],
                ),


                const Spacer(),

                Text(number.isNotEmpty ? number : '0000 0000 0000 0000',
                    style: CStyle.cStyle(fontSize: 16, fontWeight: 600, color: Colors.white)),

                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('CARD HOLDER NAME', overflow: TextOverflow.ellipsis,
                        style: CStyle.cStyle(fontSize: 16, fontWeight: 600, color: Colors.white)),
                    Text(expiration.isNotEmpty ? expiration : '00/00', style: CStyle.cStyle(fontSize: 14, fontWeight: 600, color: Colors.white)),
                  ],
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}
