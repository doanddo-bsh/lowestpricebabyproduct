import 'package:flutter/material.dart';
import 'first_page_search_page.dart';

class FirstPageSearchButton extends StatefulWidget {
  const FirstPageSearchButton({Key? key}) : super(key: key);

  @override
  State<FirstPageSearchButton> createState() => FirstPageSearchButtonState();
}

class FirstPageSearchButtonState extends State<FirstPageSearchButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded)),
          SizedBox(
            width: 250.0,
            height: double.infinity,
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  )
                ),
                onPressed: () {
                  // go to search page
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation1,
                              Animation<double> animation2) {
                            return const FirstPageSearchPage();
                          },
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ));
                },
                child: const Row(
                  children: [
                    Icon(Icons.search)
                    ,SizedBox(width: 10.0,)
                    ,Text('최저가를 알려드릴게요!'),
                  ],
                )
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite))
        ],
      ),
    );
  }
}
