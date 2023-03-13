import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_cards_event.dart';
part 'my_cards_state.dart';

class MyCardsBloc extends Bloc<MyCardsEvent, MyCardsState> {
  MyCardsBloc() : super(MyCardsInitial()) {
    on<MyCardsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
