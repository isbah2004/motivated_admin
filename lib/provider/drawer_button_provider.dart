import 'dart:async';

import 'package:flutter/material.dart';

class HomeButtonProvider extends ChangeNotifier {
  bool _isButtonPressed = false;
  bool get isButtonPressed => _isButtonPressed;
  void setButtonPressed() {
    _isButtonPressed = !_isButtonPressed;
    Timer(const Duration(milliseconds: 250), () {
      _isButtonPressed = !_isButtonPressed;
      notifyListeners();
    });
    notifyListeners();
  }
}

class ContactButtonProvider extends ChangeNotifier {
  bool _isButtonPressed = false;
  bool get isButtonPressed => _isButtonPressed;
  void setButtonPressed() {
    _isButtonPressed = !_isButtonPressed;
    Timer(const Duration(milliseconds: 250), () {
      _isButtonPressed = !_isButtonPressed;
      notifyListeners();
    });
    notifyListeners();
  }
}

class AboutButtonProvider extends ChangeNotifier {
  bool _isButtonPressed = false;
  bool get isButtonPressed => _isButtonPressed;
  void setButtonPressed() {
    _isButtonPressed = !_isButtonPressed;
    Timer(const Duration(milliseconds: 250), () {
      _isButtonPressed = !_isButtonPressed;
      notifyListeners();
    });
    notifyListeners();
  }
}

class RateButtonProvider extends ChangeNotifier {
  bool _isButtonPressed = false;
  bool get isButtonPressed => _isButtonPressed;
  void setButtonPressed() {
    _isButtonPressed = !_isButtonPressed;
    Timer(const Duration(milliseconds: 250), () {
      _isButtonPressed = !_isButtonPressed;
      notifyListeners();
    });
    notifyListeners();
  }
}
