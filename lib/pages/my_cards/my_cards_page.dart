import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_bank_card/blocs/my_cards/my_cards_bloc.dart';
import 'package:task_bank_card/consts/styles.dart';
import 'package:task_bank_card/pages/add_card/add_card_page.dart';
import 'package:task_bank_card/services/routes/routes.dart';

class MyCardsPage extends StatefulWidget {
  static Widget bloc() => BlocProvider(create: (context) => MyCardsBloc(), child: const MyCardsPage());
  const MyCardsPage({Key? key}) : super(key: key);

  @override
  State<MyCardsPage> createState() => _MyCardsPageState();
}

class _MyCardsPageState extends State<MyCardsPage> {
  late MyCardsBloc _bloc;
  final Map<String, String> cards = {
    'uzcard' : 'assets/icons/uzcard_icon.png',
    'humo' : 'assets/icons/humo_icon.png',
    'mastercard' : 'assets/icons/mastercard_icon.png',
    'danger' : 'assets/icons/danger_icon.png',
    '' : 'assets/icons/danger_icon.png',
  };

  @override
  void initState() {
    _bloc = context.read<MyCardsBloc>();
    _bloc.add(const GetCardsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My cards'),
          actions: [
            IconButton(
              onPressed: () => AppRoutes.push(context: context, page: const AddCardPage()),
              splashRadius: 25,
              icon: const Icon(Icons.add, size: 28),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: BlocBuilder<MyCardsBloc, MyCardsState>(
          builder: (context, state) {
            if(state is SuccessGetCardsState) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                itemCount: state.cards.length,
                itemBuilder: (context, i) {
                  final card = state.cards[i];
                  return Container(
                    padding: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: card.color ?? Colors.transparent),
                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: state.cards[i].image != null ? Image.asset(state.cards[i].image!, fit: BoxFit.cover) :
                            Image.file(File(state.cards[i].fileImage!), fit: BoxFit.cover),
                          ),
                        ),

                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: card.xValue ?? 0, sigmaY: card.yValue ?? 0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                              ),
                            ),
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
                                  Text('Undefined',
                                      style: CStyle.cStyle(fontSize: 14, fontWeight: 500, color: Colors.white)),

                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                                    child: Image.asset(cards[card.type] ?? 'assets/icons/uzcard_icon.png', fit: BoxFit.scaleDown, height: 16, width: 24),
                                  )
                                ],
                              ),

                              const SizedBox(height: 32),


                              Text('500 000 UZS',
                                  style: CStyle.cStyle(fontSize: 22, fontWeight: 600, color: Colors.white)),

                              const SizedBox(height: 10),

                              Text(card.number, style: CStyle.cStyle(fontSize: 16, fontWeight: 600, color: Colors.white)),

                              const SizedBox(height: 8),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('CARD HOLDER NAME', overflow: TextOverflow.ellipsis,
                                      style: CStyle.cStyle(fontSize: 16, fontWeight: 600, color: Colors.white)),
                                  Text(card.expiration, style: CStyle.cStyle(fontSize: 14, fontWeight: 600, color: Colors.white)),
                                ],
                              )

                            ],
                          ),
                        ),

                      ],
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          }
        )
    );
  }
}
