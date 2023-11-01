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
  int selectedValue;

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
      child: DropdownButton<int>(
        isExpanded: true,
        isDense: true,
        value: selectedValue,
        underline: Container(),
        padding: EdgeInsets.zero,
        onChanged: (int? value) {
          setState(() {
            selectedValue = value!;
            widget.onSelected(selectedValue);
          });
        },
        items: widget.questionResultList.map((int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Text(value.toString()),
          );
        }).toList(),
      ),
    );
  }
}
