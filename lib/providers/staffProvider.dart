// ignore_for_file: file_names

import 'package:flutter/material.dart';

class StaffProvider extends ChangeNotifier {
  Map<String, dynamic>? userData;
  String? accessToken;
  String? refreshToken;

  void setStaffData(Map<String, dynamic> userData, String accessToken, String refreshToken) {
    this.userData = userData;
    this.accessToken = accessToken;
    this.refreshToken = refreshToken;
    notifyListeners();
  }
    void clearStaffData() {
    userData = null;
    accessToken = null;
    refreshToken = null;
    notifyListeners();
  }
}
