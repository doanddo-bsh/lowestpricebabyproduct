import 'package:flutter/material.dart';
import '../second_page/second_page_main.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'first_page_main.dart';

class FirstPageButtonGrid extends StatefulWidget {

  String imageAdress;
  String productType;
  String productStage;
  String productShape;
  String productSex;
  String priceInfo;

  FirstPageButtonGrid({
    required this.imageAdress,
    required this.productType,
    required this.productStage,
    required this.productShape,
    required this.productSex,
    required this.priceInfo,

    Key? key}) :
        super(key: key);

  @override
  State<FirstPageButtonGrid> createState() => _FirstPageButtonState();
}

class _FirstPageButtonState extends State<FirstPageButtonGrid> {

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        child: Container(
          height: 400,
          margin: const EdgeInsets.only(left: 15, right: 15),
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  height: 150.0,
                  child: Image(image: AssetImage(widget.imageAdress))
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('하기스'
                    ,textAlign: TextAlign.start,
                  ),
                  AutoSizeText(widget.productType, maxLines: 1,),
                  AutoSizeText("${widget.productStage}단계", maxLines: 1,),
                  AutoSizeText(widget.productShape, maxLines: 1,),
                  AutoSizeText(widget.productSex, maxLines: 1,),
                  AutoSizeText(widget.priceInfo, maxLines: 1,),
                ],
              )
            ],
          ),
        ),
        onTap: () {
          print(widget.productType);
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              SecondPageMain())
          );
        },
      );
  }
}
