import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task_bank_card/di.dart';
import 'package:task_bank_card/services/sql/models/sql_card_model.dart';

part 'my_cards_event.dart';
part 'my_cards_state.dart';

class MyCardsBloc extends Bloc<MyCardsEvent, MyCardsState> {
  MyCardsBloc() : super(MyCardsInitial()) {
    on<GetCardsEvent>((event, emit) async{
      await _getCards(event, emit);
    });
  }

  Future<void> _getCards(GetCardsEvent event, Emitter<MyCardsState> emit) async{
    EasyLoading.show(status: 'Loading...');
    final result = await sql.getCardList();
    log(result.toString());
    emit(SuccessGetCardsState(cards: result));
    EasyLoading.dismiss();
  }

}
