import 'package:flutter/material.dart';

Widget select({label, items, value, onChanged}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      SizedBox(
        height: 5,
      ),
      Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: DropdownButton(
          dropdownColor: Colors.white,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 36,
          isExpanded: true,
          underline: const SizedBox(),
          style: const TextStyle(color: Colors.black54, fontSize: 15),
          onChanged: onChanged,
          items: items,
          value: value,
        ),
      ),
    ],
  );
}
