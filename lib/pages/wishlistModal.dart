import 'package:flutter/foundation.dart';

class WishlistModel extends ChangeNotifier {
  List<bool> isFavoriteList = [];

  void initializeIsFavoriteList(int length) {
    isFavoriteList = List.generate(length, (index) => false);
  }

  void toggleFavorite(int index) {
    isFavoriteList[index] = !isFavoriteList[index];
    notifyListeners();
  }
}