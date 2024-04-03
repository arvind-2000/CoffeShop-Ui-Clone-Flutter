import 'package:animations/const.dart';
import 'package:animations/screens/detailspage.dart';
import 'package:flutter/material.dart';

class ListCardContainer extends StatelessWidget {
  const ListCardContainer({
    super.key,
    required this.title,
    required this.price,
    required this.index,
    required this.listindex
  });
  final String title;
  final String price;
  final int index;
  final int listindex;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, Detailspage.routename,arguments: [listindex,index]);
      },
      child: Container(
        height: 100,
        margin:const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              spreadRadius: 3,
              offset: const Offset(5, 10)
            )
          ],
          color: Colors.white
        ),
      child: Row(
        
        children: [
         Container(
          margin:const EdgeInsets.only(right:16),
            width: 100,
            color: col[(listindex%4).round()][0],
            child: Center(child: Image.asset(index==0?'assets/coffee.png':'assets/donut.png')),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: [
              Text(title,style:const TextStyle(fontWeight: FontWeight.bold),),
              Text(price,style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),)
            ],
          )
        ],
      ),
      
      ),
    );
  }
}
