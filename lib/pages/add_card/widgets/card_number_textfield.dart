import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_bank_card/consts/styles.dart';

class CardNumberTextfield extends StatefulWidget {
  final Function(String number) onChange;
  final Function(String type) typeChange;
  const CardNumberTextfield({Key? key, required this.onChange, required this.typeChange}) : super(key: key);

  @override
  State<CardNumberTextfield> createState() => _CardNumberTextfieldState();
}

class _CardNumberTextfieldState extends State<CardNumberTextfield> {
  TextEditingController cardNumberController = TextEditingController();
  final TextStyle hintStyle = CStyle.cStyle(fontSize: 16, fontWeight: 400, color: const Color(0xFF9CA3AF));
  final TextStyle textFieldStyle = CStyle.cStyle(fontSize: 16, fontWeight: 400, color: Colors.white);
  final Map<String, String> cards = {
    'uzcard' : 'assets/icons/uzcard_icon.png',
    'humo' : 'assets/icons/humo_icon.png',
    'mastercard' : 'assets/icons/mastercard_icon.png',
    'danger' : 'assets/icons/danger_icon.png',
    '' : 'assets/icons/danger_icon.png',
  };
  String cardType = '';

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: cardNumberController,
      style: textFieldStyle,
      inputFormatters: [LengthLimitingTextInputFormatter(19)],
      onChanged: (value) {
        checkCardNumber(value);
      },
      validator: (value) {
        if(value == null || value.isEmpty || value.length != 19) {
          return 'Incorrect card number';
        }
        return null;
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        hintText: '0000 0000 0000 0000',
        hintStyle: hintStyle,
        suffixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(cards[cardType] ?? '', height: 16, width: 28, fit: BoxFit.scaleDown)
        ),
      ),
    );
  }

  void checkCardNumber(String value) {
    String number = formatCardNumber(value);
    cardNumberController.clear();
    cardNumberController.text = number.trim();
    cardNumberController.selection = TextSelection.fromPosition(TextPosition(offset: cardNumberController.text.length));
    widget.onChange(cardNumberController.text.trim());
    widget.typeChange(cardType);
    if(value.length > 4 && value.substring(0, 4) == '8600') {
      cardType = 'uzcard';
    } else if(value.length > 4 && value.substring(0, 4) == '9860') {
      cardType = 'humo';
    }else if(value.length > 4 && value.substring(0, 4) == '5412') {
      cardType = 'mastercard';
    } else if (value.length > 4) {
      cardType = 'danger';
    } else {
      cardType = '';
    }
    setState(() {});
  }

  String formatCardNumber(String cardNumber) {
    cardNumber = cardNumber.replaceAll(RegExp(r'\D'), '');
    String formatted = '';
    for (int i = 0; i < cardNumber.length; i++) {
      if (i % 4 == 0 && i > 0) {
        formatted += ' ';
      }
      formatted += cardNumber[i];
    }
    return formatted;
  }

}
