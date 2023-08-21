import 'package:flutter/material.dart';

// 검색어
String searchText = '';

// 리스트뷰에 표시할 내용
List<String> items = ['기저귀', 'ㅎ기스', '또하', '뚜니', '귀여운 하오니'];
List<String> itemContents = [
  'Item 1 Contents',
  'Item 2 Contents',
  'Item 3 Contents',
  'Item 4 Contents'
];

class FirstPageSearchPage extends StatefulWidget {
  const FirstPageSearchPage({Key? key}) : super(key: key);

  @override
  State<FirstPageSearchPage> createState() => _FirstPageSearchPageState();
}

class _FirstPageSearchPageState extends State<FirstPageSearchPage> {
  final TextEditingController _controller = TextEditingController();

  // This function is triggered when the clear buttion is pressed
  void _clearTextField() {
    // Clear everything in the text field
    _controller.clear();
    // Call setState to update the UI
    setState(() {
      searchText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 45.0,
          width: 400,
          child: TextField(
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            controller: _controller,
            onChanged: (value) {
              // Call setState to update the UI
              setState(() {
                searchText = value;
              });
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(0.0),
              labelText: 'Search',
              labelStyle: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _controller.text.isEmpty
                  ? null // Show nothing if the text field is empty
                  : IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: _clearTextField,
                    ),
              // Show the clear button if the text field has something
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('취소'))
        ],
      ),
      body: Column(
        children: [
          Expanded(child:
            ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                // 검색 기능, 검색어가 있을 경우
                if (searchText.isNotEmpty &&
                    !items[index]
                        .toLowerCase()
                        .contains(searchText.toLowerCase())) {
                  return const SizedBox.shrink();
                }
                // 검색어가 없을 경우, 모든 항목 표시
                else {
                  return Card(
                    elevation: 3,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.elliptical(20, 20))),
                    child: ListTile(
                      title: Text(items[index]),
                      onTap: () {

                      },
                    ),
                  );
                }
              },
            )
          )
        ],
      )
    );
  }
}
