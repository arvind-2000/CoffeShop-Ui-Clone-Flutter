import 'package:flutter/material.dart';

class RoundContainer extends StatelessWidget {
  const RoundContainer({
    super.key,
    required this.title,
    required this.isSelected,
    required this.toggle,
    required this.index
  });
  final String title;
  final bool isSelected;
  final Function toggle;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        toggle(index);
      },
      child: Container(
        padding:const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
        margin:const EdgeInsets.only(right:8),
        decoration:isSelected?BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient:const LinearGradient(colors: [
            Colors.orange,
            Colors.amber
          ])
        ):null,
        child: Text(title,style: TextStyle(fontWeight: FontWeight.bold,color: isSelected?Colors.white:null),),
      ),
    );
  }
}