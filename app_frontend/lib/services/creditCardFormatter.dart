import 'package:flutter/services.dart';

class CardNumberInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue){

    var newText = newValue.text;

    if(newValue.selection.baseOffset == 0){
      return newValue;
    }

    var buffer = new StringBuffer();
    for(int i=0;i < newText.length; i++){
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != newText.length) {
        buffer.write(' ');
      }
    }
    var string = buffer.toString();

    return newValue.copyWith(text: string,selection: new TextSelection.collapsed(offset: string.length));
  }
}

class CardMonthInputFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue){

    var newText = newValue.text;

    if(newValue.selection.baseOffset == 0){
      return newValue;
    }

    var buffer = new StringBuffer();
    for(int i=0;i < newText.length; i++){
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }
    var string = buffer.toString();

    return newValue.copyWith(text: string,selection: new TextSelection.collapsed(offset: string.length));
  }
}