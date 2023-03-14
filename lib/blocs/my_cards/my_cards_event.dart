part of 'my_cards_bloc.dart';

abstract class MyCardsEvent extends Equatable {
  const MyCardsEvent();
}

class GetCardsEvent extends MyCardsEvent{
  const GetCardsEvent();
  @override
  List<Object?> get props => throw UnimplementedError();
}
