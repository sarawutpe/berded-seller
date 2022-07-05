
String getNumberSum(String numberString) {
  try {
    final pureNumber = numberString.replaceAll(new RegExp(r"\D"), "");
    int sum = 0;
    pureNumber.runes.forEach((int rune) {
      var character = new String.fromCharCode(rune);
      sum += int.parse(character);
    });
    return sum.toString();
  } catch (e) {
    return "";
  }
}

String getBerdedPackageName(int package_id) {
  switch (package_id) {
    case 1:
      return "Trail";
    case 2:
      return "Basic";
    case 3:
      return "Smart";
    case 5:
      return "Pro";
    case 6:
      return "Premier";
    case 8:
      return "Mini";
    case 9:
      return "Premier Plus";
    case 10:
      return "Lite";
  }
  return "TrailX";
}

int getBerdedPackageColor(int package_id) {
  switch (package_id) {
    case 1: //Trail
      return 0xFFBA9754;
    case 2: //Basic
      return 0xFF2AC48C;
    case 3: //Smart
      return 0xFF1D61DC;
    case 5: //Pro
      return 0xFFFFB400;
    case 6: // Premier
      return 0xFFFF8400;
    case 8: //Mini
      return 0xFF2B96F0;
    case 9: //Premier Plus
      return 0xFFF60000;
    case 10: //Lite
      return 0xFF909090;
  }
  return 0xFF000000; //TrailX
}


double forceToDouble(dynamic value) {
  try {
    if (value == null){
      return 0.0;
    } else if (value is int) {
      return 0.0 + value;
    } else {
      return value;
    }
  }catch(e){
    return 0.0;
  }
}

