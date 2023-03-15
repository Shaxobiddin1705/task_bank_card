part of 'add_card_bloc.dart';

abstract class AddCardEvent extends Equatable {
  const AddCardEvent();
}

class SaveCardEvent extends AddCardEvent{
  final String cardNum;
  final String expiration;
  final String cardName;
  final String? image;
  final String? fileImage;
  final String type;
  const SaveCardEvent({required this.cardNum, required this.expiration, this.image, this.fileImage, required this.cardName, required this.type});

  @override
  List<Object?> get props => [cardNum, cardName, expiration, image, fileImage];
}
