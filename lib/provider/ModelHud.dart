
import 'package:flutter/widgets.dart';

class ModelHud extends ChangeNotifier
{

  bool isLoading = false;

  changeIsLoadein(bool value){
    isLoading = value;
    notifyListeners();
  }
}