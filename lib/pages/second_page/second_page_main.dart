import 'package:flutter/material.dart';

class SecondPageMain extends StatelessWidget {
  SecondPageMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title:const Text('제품상세정보', style: TextStyle(color: Colors.black),),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.navigate_before_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [IconButton(icon: Icon(Icons.search_rounded),onPressed: () {
            print('qwerqwer');
          },
          ),
            IconButton(icon: Icon(Icons.favorite_border_outlined),onPressed: () {
              print('zxcvzxcv');
            },),
          ],
        ),
        body: Column(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Container(child: Image.asset
                    ('assets/product_image_huggies/organic1bandpublic.png',
                    width: 125,
                    height: 125,
                    ),
                    ),
                  const Text('하기스',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey
                    ),
                  ),
                  const Text('네이처메이드 3단계 밴드 여아',
                    style: TextStyle(
                        fontSize: 15,
                        height: 1.7,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Container(width: 380, height: 40,
                    child: Divider(color: Colors.grey,thickness: 0.2),)
                ],
              ),
            ),
            Container(
                alignment:Alignment.topLeft,
                child: Text("최저가(매당가격)",textAlign: TextAlign.start)
            ),
          ],
        )
    );
  }
}