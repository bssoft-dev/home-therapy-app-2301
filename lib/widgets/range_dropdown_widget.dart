import 'package:flutter/material.dart';

class RangeDropdownMenu extends StatefulWidget {
  final Function(int) onSelected;
  final List<int> questionResultList;
  final int selectedValue;

  const RangeDropdownMenu({
    Key? key,
    required this.onSelected,
    required this.questionResultList,
    required this.selectedValue,
  }) : super(key: key);

  @override
  _RangeDropdownMenuState createState() =>
      _RangeDropdownMenuState(selectedValue);
}

class _RangeDropdownMenuState extends State<RangeDropdownMenu> {
  int? selectedValue;

  _RangeDropdownMenuState(this.selectedValue);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.fromLTRB(12, 4, 6, 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: DropdownButton(
        isExpanded: true,
        isDense: true,
        menuMaxHeight: MediaQuery.of(context).size.height * 0.6,
        value:
            selectedValue ?? widget.questionResultList[50], // null 체크를 추가했습니다.
        underline: Container(),
        padding: EdgeInsets.zero,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
            widget.onSelected(selectedValue!);
          });
        },
        items: widget.questionResultList.map((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value.toString()),
          );
        }).toList(),
      ),
    );
  }
}
