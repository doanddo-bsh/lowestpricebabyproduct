import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'first_page_main.dart';

class FirstPageButtonList extends StatefulWidget {

  String imageAdress;
  String productType;
  String productStage;
  String productShape;
  String productSex;
  String priceInfo;

  FirstPageButtonList({
    required this.imageAdress,
    required this.productType,
    required this.productStage,
    required this.productShape,
    required this.productSex,
    required this.priceInfo,
    Key? key}) :
        super(key: key);

  @override
  State<FirstPageButtonList> createState() => _FirstPageButtonState();
}

class _FirstPageButtonState extends State<FirstPageButtonList> {

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.fromLTRB(20.0,3.0,10.0,3.0),
        child: Row(
          children: [
            AutoSizeText(widget.productType, maxLines: 1),
            const SizedBox(width: 3.0,),
            AutoSizeText(widget.productStage, maxLines: 1),
            const SizedBox(width: 3.0,),
            AutoSizeText(widget.productShape, maxLines: 1),
            const SizedBox(width: 3.0,),
            AutoSizeText(widget.productSex, maxLines: 1),
            const SizedBox(width: 3.0,),
            AutoSizeText(widget.priceInfo, maxLines: 1,),
          ],
        ),
      );
  }
}
