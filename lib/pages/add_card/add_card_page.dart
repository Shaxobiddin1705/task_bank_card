import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_bank_card/blocs/add_card/add_card_bloc.dart';
import 'package:task_bank_card/consts/colors.dart';
import 'package:task_bank_card/consts/styles.dart';
import 'package:task_bank_card/pages/add_card/widgets/card_number_textfield.dart';
import 'package:task_bank_card/pages/add_card/widgets/card_view.dart';
import 'package:task_bank_card/pages/add_card/widgets/color_picker/color_picker_dialog.dart';
import 'package:task_bank_card/pages/add_card/widgets/custom_image/choose_back_image.dart';
import 'package:task_bank_card/pages/add_card/widgets/expiration_formatter.dart';
import 'package:task_bank_card/pages/add_card/widgets/custom_image/select_image_external.dart';
import 'package:task_bank_card/pages/my_cards/my_cards_page.dart';
import 'package:task_bank_card/services/image_service.dart';
import 'package:task_bank_card/services/routes/routes.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({Key? key}) : super(key: key);

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final _formKey = GlobalKey<FormState>();
  List<String> images = ['card_back_image_1.jpg', 'card_back_image_2.jpg', 'card_back_image_3.png'];
  int selectedImageIndex = 0;
  String? selectedImage;
  String cardNumber = '';
  String cardType = '';
  File? fileImage;
  Color? selectedColor;

  final TextStyle titleStyle = CStyle.cStyle(fontSize: 12, fontWeight: 400, color: const Color(0xFF9CA3AF));
  final TextStyle hintStyle = CStyle.cStyle(fontSize: 16, fontWeight: 400, color: const Color(0xFF9CA3AF));
  final TextStyle textFieldStyle = CStyle.cStyle(fontSize: 16, fontWeight: 400, color: Colors.white);

  TextEditingController expirationDateController = TextEditingController();
  TextEditingController cardNameController = TextEditingController();

  @override
  void initState() {
    final randomIndex = Random().nextInt(3);
    selectedImageIndex = randomIndex;
    selectedImage = 'assets/images/${images[selectedImageIndex]}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add card')),
      body: BlocProvider(
        create: (context) => AddCardBloc(),
        child: Form(
          key: _formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero, shrinkWrap: true,
            children: [

              CardView(
                expiration: expirationDateController.text.trim(), file: fileImage, color: selectedColor,
                number: cardNumber, type: cardType, image: selectedImage, name: cardNameController.text.trim(),
              ),

              const SizedBox(height: 35),

              _padding(child: Text('Card number', style: titleStyle)),

              const SizedBox(height: 8),

              ///cardNumberTextField
              _padding(
                  child: CardNumberTextfield(
                    onChange: (String number) {
                      cardNumber = number;
                      if(cardNumber.length == 19) setState(() {});
                    },
                    typeChange: (String type) => cardType = type,
                  )
              ),

              const SizedBox(height: 24),

              _padding(child: Text('Expiration date', style: titleStyle)),

              const SizedBox(height: 8),

              ///expirationDate
              _padding(
                  child: TextFormField(
                    inputFormatters: [LengthLimitingTextInputFormatter(5), ExpirationDateFormatter()],
                    controller: expirationDateController,
                    style: textFieldStyle,
                    onChanged: (String value) {
                      if(isExpirationDateValid(value)) setState(() {});
                    },
                    validator: (value) {
                      if(value == null || value.isEmpty || value.length != 5) return 'Incorrect expiration date';
                      if(!isExpirationDateValid(value)) return 'Incorrect expiration date';
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                      hintText: 'MM/YY',
                      hintStyle: hintStyle,
                    ),
                  )
              ),

              const SizedBox(height: 24),

              _padding(child: Text('Card name', style: titleStyle)),

              const SizedBox(height: 8),

              ///cardName
              _padding(
                  child: TextFormField(
                    controller: cardNameController,
                    style: textFieldStyle,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                      hintText: 'Card name',
                      hintStyle: hintStyle,
                    ),
                  )
              ),

              const SizedBox(height: 24),

              _padding(child: const Divider(thickness: 1, color: MyColors.darkBlue)),

              const SizedBox(height: 18),

              _padding(child: Text('Choose card background image', style: hintStyle)),

              const SizedBox(height: 12),

              SizedBox(
                height: 60,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 24, right: 16),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  shrinkWrap: true,
                  itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: InkWell(
                      onTap: () {
                        selectedImageIndex = i;
                        selectedImage = 'assets/images/${images[i]}';
                        fileImage = null;
                        setState(() {});
                      },
                      child: ChooseBackImage(selectedIndex: selectedImage != null ? selectedImageIndex : null, i: i, image: images[i]),
                    ),
                  ),
                ),
              ),

              SelectImageFromExternal(
                onChange: (String image, File file) {
                  fileImage = file;
                  selectedImage = null;
                  setState(() {});
                },
              ),

              const SizedBox(height: 12),

              Padding(
                padding: EdgeInsets.only(left: 24, right: MediaQuery.of(context).size.width * 0.6),
                child: InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (context) => ColorPickerDialog(color: selectedColor)).then((value) {
                      if(value != null) {
                        selectedColor = value;
                        fileImage = null;
                        selectedImage = null;
                        setState(() {});
                      }
                    });
                  },
                  child: Container(
                    width: 120, height: 40, alignment: Alignment.center,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: MyColors.primaryWhite),
                    child: Text('Select Color', style: CStyle.cStyle(fontSize: 16, fontWeight: 500, color: MyColors.darkBlue))
                  ),
                ),
              ),

              const SizedBox(height: 36),

              _padding(
                  child: BlocConsumer<AddCardBloc, AddCardState>(
                      listener: (context, state) {
                        if(state is SuccessSavedCardState) {
                          AppRoutes.pushReplace(context: context, page: MyCardsPage.bloc());
                        }
                      },
                      builder: (context, state) {
                        return MaterialButton(
                          onPressed: () async{
                            FocusManager.instance.primaryFocus?.unfocus();
                            if(_formKey.currentState!.validate() && cardType != 'danger'){
                              final img = fileImage != null ? await ImageService.compressImage(fileImage!) : null;
                              if(context.mounted) {
                                context.read<AddCardBloc>().add(SaveCardEvent(cardNum: cardNumber, cardName: cardNameController.text.trim(), fileImage: img,
                                    expiration: expirationDateController.text.trim(), image: selectedImage, type: cardType));
                              }
                            }
                          },
                          color: Colors.white,
                          child: Text('Save card', style: CStyle.cStyle(fontSize: 16, fontWeight: 500, color: MyColors.darkBlue)),
                        );
                      }
                  )
              ),

              const SizedBox(height: 25),

            ],
          )
        ),
      ),
    );
  }

  Widget _padding({required Widget child}) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: child);
  }

  bool isExpirationDateValid(String input) {
    input = input.replaceAll('/', '');
    if (input.length != 4) return false;
    int? year = int.tryParse(input.substring(2));
    int? month = int.tryParse(input.substring(0, 2));
    if (year == null || month == null) return false;
    if (year < DateTime.now().year % 100) return false;
    if (month > 12) return false;
    if (year == DateTime.now().year % 100 && month < DateTime.now().month) return false;
    return true;
  }
}