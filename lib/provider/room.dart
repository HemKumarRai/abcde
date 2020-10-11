import 'package:flutter/cupertino.dart';

class Room with ChangeNotifier {
  final String id;
  final String placeName;
  final double rent;
  final String description;
  final String forWhom;
  final String image;
  final String phone;
  bool isFavourite;
  Room({
    @required this.id,
    @required this.placeName,
    @required this.rent,
    @required this.description,
    @required this.image,
    @required this.phone,
    @required this.forWhom,
    this.isFavourite = false,
  });

  void toggleIsFavourite() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}
