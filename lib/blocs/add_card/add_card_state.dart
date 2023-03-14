part of 'add_card_bloc.dart';

abstract class AddCardState extends Equatable {
  const AddCardState();
}

class AddCardInitial extends AddCardState {
  @override
  List<Object> get props => [];
}

class SuccessSavedCardState extends AddCardState{
  const SuccessSavedCardState();

  @override
  List<Object?> get props => throw UnimplementedError();
}
