import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_bank_card/blocs/add_card/add_card_bloc.dart';
import 'package:task_bank_card/consts/styles.dart';

class CardView extends StatelessWidget {
  final String? image;
  final File? file;
  final String expiration;
  final String number;
  final String type;
  final Color? color;
  CardView({Key? key, this.image, this.file, required this.expiration, required this.number, required this.type, this.color}) : super(key: key);

  final Map<String, String> cards = {
    'uzcard' : 'assets/icons/uzcard_icon.png',
    'humo' : 'assets/icons/humo_icon.png',
    'mastercard' : 'assets/icons/mastercard_icon.png',
    'danger' : 'assets/icons/danger_icon.png',
    '' : 'assets/icons/danger_icon.png',
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCardBloc, AddCardState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          height: 140,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: color ?? Colors.transparent),
          child: Stack(
            fit: StackFit.loose,
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: image != null ? Image.asset(image!, fit: BoxFit.cover, height: 140) :
                  file != null ? Image.file(file!, fit: BoxFit.cover, height: 140) : null,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: state is ChangeBlurValueState ? ImageFilter.blur(sigmaX: state.xVal, sigmaY: state.yVal) : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Undefined',
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
                    ),

                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
