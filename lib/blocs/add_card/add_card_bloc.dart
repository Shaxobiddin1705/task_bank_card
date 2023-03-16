import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task_bank_card/di.dart';
import 'package:task_bank_card/services/sql/models/sql_card_model.dart';

part 'add_card_event.dart';
part 'add_card_state.dart';

class AddCardBloc extends Bloc<AddCardEvent, AddCardState> {
  AddCardBloc() : super(AddCardInitial()) {
    on<SaveCardEvent>((event, emit) async{
      await _saveCard(event, emit);
    });
    on<ChangeBlurValueEvent>((event, emit){
      _changeBlur(event, emit);
    });
  }

  Future<void> _saveCard(SaveCardEvent event, Emitter<AddCardState> emit) async {
    EasyLoading.show(status: 'Loading...');
    final cardModel = SqlCardModel(number: event.cardNum, expiration: event.expiration,
        image: event.image, type: event.type, fileImage: event.fileImage, xValue: event.xValue, yValue: event.yValue);
    final result = await sql.insertCard(cardModel);
    log('This is result ----- $result');
    emit(const SuccessSavedCardState());
    EasyLoading.dismiss();
  }

  void _changeBlur(ChangeBlurValueEvent event, Emitter<AddCardState> emit) {
    emit(ChangeBlurValueState(xVal: event.xVal, yVal: event.yVal));
  }

}
