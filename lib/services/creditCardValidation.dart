class ErrorString{
  static const String reqField = 'This field is required';
  static const String invalidCardNumber = 'Card is invalid';
}

enum CardType{
  Master,
  Visa,
  Verve,
  Discover,
  AmericanExpress,
  DinersClub,
  Jcb,
  Others,
  Invalid
}

class PaymentCard{
  CardType type;
  int month;
  int year;
  int cvv;
  String name;

  PaymentCard({this.type, this.month, this.year, this.cvv, this.name});

  @override
  String toString(){
    return '[Type: $type, Month: $month, Year: $year]';
  }
}


class CreditCardValidation{
  static String validateCVV(String value) {
    if (value.isEmpty) {
      return ErrorString.reqField;
    }

    if (value.length < 3 || value.length > 4) {
      return "CVV is invalid";
    }
    return null;
  }

  static String validateDate(String value){
    if(value.isEmpty){
      return ErrorString.reqField;
    }

    int year;
    int month;

    if (value.contains(new RegExp(r'(\/)'))) {
      var split = value.split(new RegExp(r'(\/)'));
      month = int.parse(split[0]);
      year = int.parse(split[1]);

    }
    else {
      month = int.parse(value.substring(0, (value.length)));
      year = -1;
    }

    if ((month < 1) || (month > 12)) {
      return 'Expiry month is invalid';
    }

    var fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      return 'Expiry year is invalid';
    }

    if (!hasDateExpired(month, year)) {
      return "Card has expired";
    }
    return null;
  }

  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return !(month == null || year == null) && isNotExpired(year, month);
  }

  static List<int> getExpiryDate(String value) {
    var split = value.split(new RegExp(r'(\/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }

  static bool isNotExpired(int year, int month) {
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    return fourDigitsYear < now.year;
  }

  static String formatCardNumber(String text){
    RegExp exp = new RegExp(r"[^0-9]");
    return text.replaceAll(exp,'');

  }

  static String validateCardNumber(String input){
    if(input.isEmpty){
      return ErrorString.reqField;
    }

    input = formatCardNumber(input);
    if(input.length < 12){
      return ErrorString.invalidCardNumber;
    }

    int sum = 0;
    int length = input.length;
    for (var i = 0; i < length; i++) {
      int digit = int.parse(input[length - i - 1]);
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }

    if (sum % 10 == 0) {
      return null;
    }
    return ErrorString.invalidCardNumber;
  }
}