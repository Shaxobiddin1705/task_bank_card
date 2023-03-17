import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task_bank_card/di.dart';
import 'package:task_bank_card/services/apis.dart';
import 'package:task_bank_card/services/sql/models/sql_card_model.dart';

part 'add_card_event.dart';
part 'add_card_state.dart';

class AddCardBloc extends Bloc<AddCardEvent, AddCardState> {
  AddCardBloc() : super(AddCardInitial()) {
    on<SaveCardEvent>((event, emit) async{
      EasyLoading.show(status: 'Loading...');
      // await _postCard(event, emit);
      await _saveCard(event, emit);
      EasyLoading.dismiss();
    });
    on<ChangeBlurValueEvent>((event, emit){
      _changeBlur(event, emit);
    });
  }

  Future<void> _saveCard(SaveCardEvent event, Emitter<AddCardState> emit) async {
    final cardModel = SqlCardModel(number: event.cardNum, expiration: event.expiration,
        image: event.image, type: event.type, fileImage: event.fileImage, xValue: event.xValue, yValue: event.yValue, color: event.color);
    final result = await sql.insertCard(cardModel);
    log('This is result ----- $result');
    emit(const SuccessSavedCardState());
  }

  Future<void> _postCard(SaveCardEvent event, Emitter<AddCardState> emit) async {
    var formData  = FormData.fromMap({
      'card_number': event.cardNum, 'card_expiration' : event.expiration, 'card_image': event.image,
      'card_type': event.type, 'color':event.color.toString(), 'card_blur_x':event.xValue, 'card_blur_y':event.yValue,
      'file': MultipartFile.fromFileSync(event.file?.path ?? '')
    });
    final result = await dio.postFormData(api: Apis.postFormData, formData: formData);
    log('This is result ----- $result');
  }

  void _changeBlur(ChangeBlurValueEvent event, Emitter<AddCardState> emit) {
    emit(ChangeBlurValueState(xVal: event.xVal, yVal: event.yVal));
  }

}
