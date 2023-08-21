import 'package:flutter/material.dart';
import '../second_page/second_page_main.dart';

class FirstPageButton extends StatefulWidget {

  String imageAdress;
  String productType;
  String productStage;
  String productShape;
  String productSex;

  FirstPageButton({
    required this.imageAdress,
    required this.productType,
    required this.productStage,
    required this.productShape,
    required this.productSex,
    Key? key}) :
        super(key: key);

  @override
  State<FirstPageButton> createState() => _FirstPageButtonState();
}

class _FirstPageButtonState extends State<FirstPageButton> {
  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        child: Container(
          height: 400,
          margin: EdgeInsets.only(left: 15, right: 15),
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
                  Text('하기스'
                      ,textAlign: TextAlign.start,
                  ),
                  Text(widget.productType),
                  Text("${widget.productStage}단계"),
                  Text(widget.productShape),
                  Text(widget.productSex),
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
