part of 'my_cards_bloc.dart';

abstract class MyCardsState extends Equatable {
  const MyCardsState();
}

class MyCardsInitial extends MyCardsState {
  @override
  List<Object> get props => [];
}
