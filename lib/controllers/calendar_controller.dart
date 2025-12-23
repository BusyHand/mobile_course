import 'package:flutter/material.dart';

import '../models/calendar_model.dart';

class CalendarController extends ChangeNotifier {
  late CalendarModel _model;

  CalendarController() {
    final now = DateTime.now();
    _model = CalendarModel(year: now.year, month: now.month);
  }

  CalendarModel get model => _model;

  void nextMonth() {
    if (_model.month == 12) {
      _model = CalendarModel(year: _model.year + 1, month: 1);
    } else {
      _model = CalendarModel(year: _model.year, month: _model.month + 1);
    }
    notifyListeners();
  }

  void prevMonth() {
    if (_model.month == 1) {
      _model = CalendarModel(year: _model.year - 1, month: 12);
    } else {
      _model = CalendarModel(year: _model.year, month: _model.month - 1);
    }
    notifyListeners();
  }

  void setYear(int year) {
    _model = CalendarModel(year: year, month: _model.month);
    notifyListeners();
  }

  void goToToday() {
    final now = DateTime.now();
    _model = CalendarModel(year: now.year, month: now.month);
    notifyListeners();
  }

  bool get isCurrentMonth {
    final now = DateTime.now();
    return now.year == _model.year && now.month == _model.month;
  }
}
