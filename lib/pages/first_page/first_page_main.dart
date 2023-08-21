import 'package:flutter/material.dart';
import 'first_page_search_button.dart';
import 'first_page_button.dart';
import 'first_page_item_list.dart';
import 'first_page_middle_drop_button.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';


class FirstPageMain extends StatelessWidget {
  const FirstPageMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
          child: NSView(), // NestedScrollView
    ));
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

  List<List<dynamic>> _productListData = [];

  // This function is triggered when the floating button is pressed
  void _loadCSV() async {
    final rawData = await rootBundle.loadString("assets/product_list/haggies_product_list_sample.csv");
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
    print(listData[0]);
    setState(() {
      _productListData = listData;
    });

    _loadDate = true;
  }

  bool _loadDate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadCSV();
    // _loadDate = true;
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      // Changes the way the inner and outer scroll are linked together
      floatHeaderSlivers: true,
      // This builds the scrollable content above the body
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          scrolledUnderElevation: 0.0,
          elevation: 1,
          expandedHeight: 50,
          floating: true,
          // pinned: true, // 안없어지고 남는 것
          forceElevated: innerBoxIsScrolled,
          title: const FirstPageSearchButton(),
          // backgroundColor: Colors.white,
        ),
        const SliverAppBar(
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
      ],
      // body: Text("${_productListData.length.toString()}"),
      // The content of the scroll view
      body: _loadDate ?
        Container(
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _productListData.length-1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 9 / 12
            ),
            itemBuilder: (context, index){
              return FirstPageButton(
                imageAdress:'assets/product_image_huggies/organic1bandpublic.png',
                productType:_productListData[index+1][0].toString(),
                productStage:_productListData[index+1][1].toString(),
                productShape:_productListData[index+1][2].toString(),
                productSex:_productListData[index+1][3].toString(),
              );
            },
            // children: List.generate(_productListData.length-1, (index) {
            //   return
            // }),
          ),
        ) :
        Center(child: CircularProgressIndicator())
    );
  }
}
