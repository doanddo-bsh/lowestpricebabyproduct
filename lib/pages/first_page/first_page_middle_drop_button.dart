import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

final List<String> itemsProductName = [
  '매직컴포트',
  '네이처메이드',
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



class FirstPageDropDownButton extends StatefulWidget {

  String buttonName;
  List<String> itemsList;
  double widthCustom ;

  List<String> selectedItems = [];

  FirstPageDropDownButton({
    required this.buttonName,
    required this.itemsList,
    required this.widthCustom,
    Key? key}) : super(key: key);

  @override
  State<FirstPageDropDownButton> createState() => _FirstPageDropDownButtonState();
}

class _FirstPageDropDownButtonState extends State<FirstPageDropDownButton> {

  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {

    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            widget.buttonName,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: widget.itemsList.map((item) {
            return DropdownMenuItem(
              value: item,
              //disable default onTap to avoid closing menu when selecting an item
              enabled: false,
              child: StatefulBuilder(
                builder: (context, menuSetState) {
                  final isSelected = selectedItems.contains(item);
                  return InkWell(
                    onTap: () {
                      isSelected ? selectedItems.remove(item) : selectedItems.add(item);
                      //This rebuilds the StatefulWidget to update the button's text
                      setState(() {});
                      //This rebuilds the dropdownMenu Widget to update the check mark
                      menuSetState(() {});
                    },
                    child: Container(
                      height: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          if (isSelected)
                            const Icon(Icons.check_box_outlined)
                          else
                            const Icon(Icons.check_box_outline_blank),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }).toList(),
          //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
          value: selectedItems.isEmpty ? null : selectedItems.last,
          onChanged: (value) {

          },
          selectedItemBuilder: (context) {
            print(selectedItems);
            return widget.itemsList.map(
                  (item) {
                return Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    selectedItems.join(', '),
                    style: const TextStyle(
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                );
              },
            ).toList();
          },
          buttonStyleData: ButtonStyleData(
            padding: EdgeInsets.only(left: 16, right: 8),
            height: 40,
            width: widget.widthCustom,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.redAccent,
            ),
            offset: const Offset(-20, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}


class FirstPageMiddleDropButton extends StatelessWidget {
  const FirstPageMiddleDropButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 13.0,
                  top: 10.0,
                  bottom: 10.0),
              child: Text('하기스',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 1.0, right: 1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FirstPageDropDownButton(buttonName:'제품이름'
                  ,itemsList: itemsProductName
                  ,widthCustom: 100.0
              ),
              FirstPageDropDownButton(buttonName:'단계'
                  ,itemsList: itemsStage
                  ,widthCustom: 80.0
              ),
              FirstPageDropDownButton(buttonName:'종류'
                  ,itemsList: itemsType
                  ,widthCustom: 80.0
              ),
              FirstPageDropDownButton(buttonName:'성별'
                  ,itemsList: itemsSex
                  ,widthCustom: 80.0
              ),
            ],
          ),
        ),
      ],
    );
  }
}
