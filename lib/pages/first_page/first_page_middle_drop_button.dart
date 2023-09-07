import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:provider/provider.dart';
import '../../component/provider_selected_list.dart';


class FirstPageDropDownButton extends StatefulWidget {

  String buttonName;
  List<String> itemsList;
  double widthCustom ;
  final void Function(List<String>) getSelectedItemList;

  FirstPageDropDownButton({
    required this.buttonName,
    required this.itemsList,
    required this.widthCustom,
    required this.getSelectedItemList,
    Key? key}) : super(key: key);

  @override
  State<FirstPageDropDownButton> createState() => _FirstPageDropDownButtonState();
}

class _FirstPageDropDownButtonState extends State<FirstPageDropDownButton> {

  List<String> selectedItems = [];
  List<String> selectedItemsOrder = [];

  @override
  Widget build(BuildContext context) {

    Selected selectedItemsProvider = Provider.of<Selected>(context);

    var seen = Set<String>();
    List<String> uniquelist = widget.itemsList.where((e) => seen.add
      (e)).toList();

    // print('${widget.buttonName} ${widget.itemsList} ${selectedItems}');
    // widget.selectedItemList = selectedItems ;

    widget.getSelectedItemList(selectedItems);

    return Container(
      // height: 150.0,
      width: widget.widthCustom,
      child: Center(
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
            items: uniquelist.map((item) {
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

                        selectedItemsOrder = selectedItemsProvider
                            .orderingMatch(widget.itemsList, selectedItems);

                        //This rebuilds the StatefulWidget to update the button's text
                        setState(() {
                          selectedItemsProvider.filter();
                        });
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
            onChanged: (item) {

            },
            selectedItemBuilder: (context) {
              // drop down 버튼 선택시
              // print('selectedItems ${selectedItems}');

              // search(selectedItems,);

              return uniquelist.map(
                    (item) {
                  return Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      // selectedItems.join(', '),
                      selectedItemsOrder.join(', '),
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
              padding: const EdgeInsets.only(left: 16, right: 8),
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
      ),
    );
  }
}



class FirstPageMiddleDropButton extends StatefulWidget {
  FirstPageMiddleDropButton(
      {Key? key}) : super(key: key);

  @override
  State<FirstPageMiddleDropButton> createState() => _FirstPageMiddleDropButtonState();
}

class _FirstPageMiddleDropButtonState extends State<FirstPageMiddleDropButton> {

  // final firestoreInstance = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {

    Selected selectedItemsProvider = Provider.of<Selected>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
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
            const Expanded(child: SizedBox()),
            IconButton(onPressed: () async {
              print('즐겨찾기 구현 필요..');
              }
              , icon: const Icon(Icons.bookmark)
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
                  ,getSelectedItemList : selectedItemsProvider
                      .setSelectedItemsProduct
              ),
              FirstPageDropDownButton(buttonName:'단계'
                  // ,itemsList: itemsStage
                  ,itemsList: itemsStage
                  ,widthCustom: 80.0
                  ,getSelectedItemList : selectedItemsProvider
                      .setSelectedItemsStage
              ),
              FirstPageDropDownButton(buttonName:'종류'
                  ,itemsList: itemsType
                  ,widthCustom: 80.0
                  ,getSelectedItemList : selectedItemsProvider
                      .setSelectedItemsType
              ),
              FirstPageDropDownButton(buttonName:'성별'
                  ,itemsList: itemsSex
                  ,widthCustom: 80.0
                  ,getSelectedItemList : selectedItemsProvider
                      .setSelectedItemsSex
              ),
            ],
          ),
        ),
      ],
    );
  }
}
