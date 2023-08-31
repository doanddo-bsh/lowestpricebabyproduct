import 'package:flutter/material.dart';

final List<String> itemsProductName = [
  '23매직컴포트',
  '23네이처메이드',
  '보송보송',
  '맥스드라이',
];

final List<String> itemsStage = [
  '1',
  '2',
  '3',
  '4',
];

final List<String> itemsType = [
  '팬티',
  '밴드',
];
final List<String> itemsSex = [
  '공용',
  '남아',
  '여아',
];

class Selected with ChangeNotifier {


  List<String> _selectedItemsProductName = [];
  List<String> _selectedItemsStage = [];
  List<String> _selectedItemsType = [];
  List<String> _selectedItemsSex = [];
  bool _filterClicked = false ;

  // show list at screen
  List<List<dynamic>> _changeData = [];
  // all product list
  List<List<dynamic>> _productListData = [];

  List<String> get selectedItemsProductName => _selectedItemsProductName ;
  List<String> get selectedItemsStage => _selectedItemsStage ;
  List<String> get selectedItemsType => _selectedItemsType ;
  List<String> get selectedItemsSex => _selectedItemsSex ;
  List<List<dynamic>> get changeData => _changeData ;
  List<List<dynamic>> get productListData => _productListData ;
  bool get filterClicked => _filterClicked ;

  // void add() {
  //   _count++;
  //   notifyListeners();
  // }

  // void remove() {
  //   _count--;
  //   notifyListeners();
  // }

  void setSelectedItemsProduct(List<String> itemList){
    _selectedItemsProductName = itemList;
    // print('_selectedItemsProductName ${_selectedItemsProductName}');
    // notifyListeners();
  }

  void setSelectedItemsStage(List<String> itemList){
    _selectedItemsStage = itemList;
    // print('_selectedItemsStage ${_selectedItemsStage}');
    // notifyListeners();
  }

  void setSelectedItemsType(List<String> itemList){
    _selectedItemsType = itemList;
    // print('_selectedItemsStage ${_selectedItemsStage}');
    // notifyListeners();
  }
  void setSelectedItemsSex(List<String> itemList){
    _selectedItemsSex = itemList;
    // print('_selectedItemsStage ${_selectedItemsStage}');
    // notifyListeners();
  }
  void setProductListData(List<List<dynamic>> productListData) {
    _productListData = productListData;
  }

  List<String> orderingMatch(List<String> original, List<String> selected){
    List<String> rlt = [];

    original.forEach((e) {
      if (selected.contains(e)){
        rlt.add(e);
      }
    });

    return rlt ;
  }

  void filter(){

    _changeData = _productListData;

    print('filter work');

    List<List<String>> originalList =
    [
      itemsProductName,
      itemsStage,
      itemsType,
      itemsSex,
    ];

    // get list have elements
    List<List<String>> selectedItemList =
    [_selectedItemsProductName,
      _selectedItemsStage,
      _selectedItemsType,
      _selectedItemsSex,
    ];

    List<List<String>> originalItemListHave = [];
    List<List<String>> selectedItemListHave = [];

    // 체크가 된 리스트만 가지고 오기
    for (final j in List.generate(4, (i) => i)){
      print(j);
      if (selectedItemList[j].length > 0){
        selectedItemListHave.add(selectedItemList[j]);
        originalItemListHave.add(originalList[j]);
      }
    }

    if (selectedItemListHave.length == 0){
      // no filter
      // print('no filter');
      _filterClicked = false ;
      _changeData = _productListData;
      notifyListeners();
      } else {
      // yes filter
      // print('yes filter');
      _filterClicked = true ;
      for (final j in List.generate(selectedItemListHave.length, (k) => k))
      {
        print(j);
        List<String> finalOrderingSelect =
        orderingMatch(
            originalItemListHave[j],
            selectedItemListHave[j]
        );

        search(finalOrderingSelect);
      }
      notifyListeners();
    }

  }


  // List<List<dynamic>>
  void search(List<String> targetSelectedItemList) {

    print('target_text ${targetSelectedItemList}');

    List<List<dynamic>> rlt = [];

    int target_item1_int = 0;

      targetSelectedItemList.forEach((target_item1) {
        print(target_item1);
        bool int_yn = false;
        try {
          target_item1_int = int.parse(target_item1);
          int_yn = true;
        } on FormatException {
          target_item1_int = -1;
        }

        // print(target_item1);
        _changeData.forEach((target_item2) {
          // print(target_item2);
          // print(item2);
          if (int_yn) {
            if (target_item2.contains(target_item1_int)) {
              // print(target_item2);
              rlt.add(target_item2);
            }
          } else {
            if (target_item2.contains(target_item1)) {
              // print(target_item2);
              rlt.add(target_item2);
              // print(rlt);
            }
          }
        });
      });

      // for result 0
      if (rlt.length == 0) {
        _changeData = [];
      } else {
        _changeData = rlt;
        // notifyListeners();
      }
    }
}