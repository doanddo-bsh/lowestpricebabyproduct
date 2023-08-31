import 'package:flutter/material.dart';
import 'first_page_search_button.dart';
import 'first_page_button.dart';
import 'first_page_item_list.dart';
import 'first_page_middle_drop_button.dart';
import 'package:flutter/services.dart' show PlatformException, rootBundle;
import 'package:csv/csv.dart';
import 'first_page_initPlugin.dart';
import 'package:provider/provider.dart';
import '../../component/provider_selected_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

var priceInfoMap = Map();

class FirstPageMain extends StatelessWidget {
  const FirstPageMain({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
          child: NSView(), // NestedScrollView
        )
    );
  }
}

// 검색어
String searchText = '';


class NSView extends StatefulWidget {
  const NSView({Key? key}) : super(key: key);

  @override
  State<NSView> createState() => _NSViewState();
}

class _NSViewState extends State<NSView> {

  List<List<dynamic>> _productListData = []; // all list
  List<List<dynamic>> productListFinal = []; // show list
  bool _loadDateCsv = false;
  bool _listFormat = true ;
  bool _loadDateFireStore = false;


  // read csv
  void _loadCSV() async {
    final rawData = await rootBundle.loadString("assets/product_list/haggies_product_list_sample.csv");
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
    // print('이거임 ${listData[0]}');
    setState(() {
        _productListData = listData.sublist(1,);
      }
    );
    _loadDateCsv = true;
  }

  // read firestore
  final db = FirebaseFirestore.instance;

  void checkIfAdmin() async{
    var rlt_test =
    await db
        .collection("TABLE_TEST")
        .doc('0')
        .get();

    var list = List.generate(rlt_test.data()!.length, (i) => i);

    for (var i in list){
      // print(rlt_test.data()![i.toString()]);
      priceInfoMap[rlt_test.data()![i.toString()
      ]['key']]=rlt_test.data()![i.toString()]['장단가'];
    }
    print(priceInfoMap);

    if(rlt_test.exists){
      setState((){
        _loadDateFireStore=true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) =>initPlugin());

    _loadCSV();
    checkIfAdmin();
    // _loadDate = true;
  }

  @override
  Widget build(BuildContext context) {

    print('_loadDateCsv ${_loadDateCsv}');
    print('_loadDateFireStore ${_loadDateFireStore}');
    print('_loadDateCsv&&_loadDateFireStore ${_loadDateCsv&&_loadDateFireStore}');

    Selected selectedItemsProvider = Provider.of<Selected>(context);
    selectedItemsProvider.setProductListData(_productListData);

    // filtering 후 항목 리스트인 changeDate 설정 전에는 전체 datalist를 보여줌
    if (!selectedItemsProvider.filterClicked){
      productListFinal = _productListData;
    } else {
      productListFinal = selectedItemsProvider.changeData;
    }

    return NestedScrollView(
      // Changes the way the inner and outer scroll are linked together
      floatHeaderSlivers: true,
      // This builds the scrollable content above the body
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        // SliverAppBar(
        //   scrolledUnderElevation: 0.0,
        //   elevation: 1,
        //   expandedHeight: 50,
        //   floating: true,
        //   // pinned: true, // 안없어지고 남는 것
        //   forceElevated: innerBoxIsScrolled,
        //   title: const FirstPageSearchButton(),
        //   // backgroundColor: Colors.white,
        // ),
        SliverAppBar(
          toolbarHeight:90.0,
          scrolledUnderElevation: 0.0,
          elevation: 1,
          // expandedHeight: 100,
          // floating: true,
          pinned: true, // 안없어지고 남는 것
          // forceElevated: innerBoxIsScrolled,
          title: FirstPageMiddleDropButton(),
          // backgroundColor: Colors.white,
        ),
        SliverAppBar(
          toolbarHeight:20.0,
          scrolledUnderElevation: 0.0,
          elevation: 1,
          // expandedHeight: 100,
          // floating: true,
          pinned: true, // 안없어지고 남는 것
          // forceElevated: innerBoxIsScrolled,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: (){
                setState(() {
                  print(_listFormat);
                  if (_listFormat==false){
                    _listFormat = true;
                    print(_listFormat);
                  }else{
                    _listFormat = false;
                  }
                });
                }, icon: _listFormat? Icon(Icons.list):Icon(Icons.grid_view)
              )
            ],
          )
          // backgroundColor: Colors.white,
        ),
      ],
      // body: Text("${_changeData.toString()}"),
      // The content of the scroll view
      body:
      _loadDateCsv&&_loadDateFireStore ?
        _listFormat ? Container(
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: productListFinal.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 8 / 12
            ),
            itemBuilder: (context, index){
              return FirstPageButton(
                imageAdress:'assets/product_image_huggies/organic1bandpublic.png',
                productType:productListFinal[index][0].toString(),
                productStage:productListFinal[index][1].toString(),
                productShape:productListFinal[index][2].toString(),
                productSex:productListFinal[index][3].toString(),
              );
            },
          ),
        ):Padding(
          padding: const EdgeInsets.only(top:15.0),
          child: Container(
            child: ListView.builder(
              itemCount: productListFinal.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20.0,3.0,10.0,3.0),
                  child: Row(
                    children: [
                      Text(productListFinal[index][0].toString()),
                      SizedBox(width: 3.0,),
                      Text(productListFinal[index][1].toString()),
                      SizedBox(width: 3.0,),
                      Text(productListFinal[index][2].toString()),
                      SizedBox(width: 3.0,),
                      Text(productListFinal[index][3].toString()),
                      SizedBox(width: 3.0,),
                      Text('가격'),
                    ],
                  ),
                );
              }
            ),
          ),
        )
      :Center(child: CircularProgressIndicator())
    );
  }
}
