import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

class PrototypeHomeProvider extends ChangeNotifier {

  bool isBGBlur = false;
  bool isAppbarBlur = false;

  AboutLanguage language = AboutLanguage.thai;

  bool setBlur(double rawOffset) {
    if (isBGBlur != (rawOffset != 0)) {
      isBGBlur = !isBGBlur;
      //notifyListeners();
      return true;
    }
    return false;
  }

  bool setAppbarBlur(double rawOffset) {
    if (isAppbarBlur != (rawOffset != 0)) {
      isAppbarBlur = !isAppbarBlur;
      //notifyListeners();
      return true;
    }
    return false;
  }

  setLang(AboutLanguage language) {
    if(this.language != language){
      this.language = language;
      notifyListeners();
    }
  }

}

enum AboutLanguage { thai, english, japanese }
