part of 'my_cards_bloc.dart';

abstract class MyCardsState extends Equatable {
  const MyCardsState();
}

class MyCardsInitial extends MyCardsState {
  @override
  List<Object> get props => [];
}

class SuccessGetCardsState extends MyCardsState{
  final List<SqlCardModel> cards;
  const SuccessGetCardsState({required this.cards});

  @override
  List<Object?> get props => [cards];
}