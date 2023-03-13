import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_bank_card/blocs/my_cards/my_cards_bloc.dart';

class MyCardsPage extends StatefulWidget {
  static Widget bloc() => BlocProvider(create: (context) => MyCardsBloc(), child: const MyCardsPage());
  const MyCardsPage({Key? key}) : super(key: key);

  @override
  State<MyCardsPage> createState() => _MyCardsPageState();
}

class _MyCardsPageState extends State<MyCardsPage> {
  late MyCardsBloc _bloc;
  bool isDeletedCard = false;
  // final maskFormatterCardNumber = MaskTextInputFormatter(mask: '####  ##**  ****  ####');

  @override
  void initState() {
    // _bloc = context.read<CardsBloc>();
    // _bloc.add(const GetCardsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyCardsBloc, MyCardsState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('My cards'),
            ),
            body: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              itemCount: 5,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/card_back_image_1.jpg'),
                            fit: BoxFit.cover, opacity: 0.6
                        ),
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('My card', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white)),

                            const SizedBox(width: 6),
                            SvgPicture.asset('assets/icons/logo.svg', height: 16, fit: BoxFit.scaleDown),

                            // const Spacer(),
                            // Image.asset(state.cards[i].cardType == 'uzcard' ? 'assets/images/uzcard_card.png' : 'assets/images/humo_card.png',
                            //     height: 22, fit: BoxFit.scaleDown),
                          ],
                        ),

                        const SizedBox(height: 32),


                        Text('500 000 UZS',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white)),

                        const SizedBox(height: 10),

                        Text('9860 1701 **** 1025', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),

                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('SULTONOV SHAXOBIDDIN', overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                            Text('02/02', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                          ],
                        )

                      ],
                    ),
                  ),
                );
              },
            )
          );
        }
    );
  }
}
