import 'package:flutter/cupertino.dart';

class PageModel with ChangeNotifier {
  double pageNumber = 1;

  void increasePageNumber() {
    pageNumber++;
    notifyListeners();
  }

  void decreasePageNumber() {
    pageNumber++;
    notifyListeners();
  }
}
