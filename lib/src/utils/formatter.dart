import 'package:intl/intl.dart';

class FormatterConvert {
  FormatterConvert._internal();
  static final FormatterConvert _instance = FormatterConvert._internal();
  factory FormatterConvert() => _instance;
  var numberFormat = NumberFormat("#,###.00");
  var numberNoDecimalFormat = NumberFormat("#,###");

  String currency(dynamic value) {
    try{

      return NumberFormat("#,###").format(value);
    }catch(e){
      return "0.00";
    }

  }

  String withComma(dynamic value){
    return numberNoDecimalFormat.format(value);
  }

  int expirationDate(dynamic value) {
    try {
      DateTime expired = DateTime.parse(value.toString().split(" ")[0]);
      final nowDate = DateTime.now();
      final expiredInMin = expired
          .difference(nowDate)
          .inMinutes;
      final expiredInDate = (expiredInMin / 1440).ceil();
      return expiredInDate;
    }catch(e){
      return 0;
    }
  }

  String formattedDate(String value){
    final date = DateTime.parse(value);
    final output = DateFormat('dd/MM/yyyy').format(date);
    return output;
  }
}


