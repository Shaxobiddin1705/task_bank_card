part of 'add_card_bloc.dart';

abstract class AddCardEvent extends Equatable {
  const AddCardEvent();
}

class SaveCardEvent extends AddCardEvent{
  final String cardNum;
  final String expiration;
  final String? image;
  final String? fileImage;
  final String type;
  final double? xValue;
  final double? yValue;
  final File? file;
  final Color? color;
  const SaveCardEvent({required this.cardNum, required this.expiration, this.image, this.fileImage, required this.type, this.xValue, this.yValue, this.file, this.color});

  @override
  List<Object?> get props => [cardNum, expiration, image, fileImage];
}

class ChangeBlurValueEvent extends AddCardEvent{
  final double xVal;
  final double yVal;
  const ChangeBlurValueEvent({required this.xVal, required this.yVal});
  @override
  List<Object?> get props => [xVal, yVal];
}

class ChangeBlurValueState extends AddCardState{
  final double xVal;
  final double yVal;
  const ChangeBlurValueState({required this.xVal, required this.yVal});

  @override
  List<Object?> get props => [xVal, yVal];
}
