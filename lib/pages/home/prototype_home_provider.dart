import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

class PrototypeHomeProvider extends ChangeNotifier {

  double blur = 0;


  setBlur(double rawOffset){
    double processOffset = rawOffset.toStringAsFixed(0).toInt() / 10;
    double offset = processOffset < 10.0 ? processOffset : 10.0;

    if(offset != blur){
      print(offset);
      blur = offset;
      notifyListeners();
    }
  }

}