import 'package:animations/const.dart';
import 'package:animations/screens/detailspage.dart';
import 'package:animations/widgets/curvedbottom.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'widgets/listcardcontainer.dart';
import 'widgets/roundcontainer.dart';

class Childs extends StatefulWidget {
  const Childs({super.key, required this.controller, required this.toggle});
  final AnimationController controller;
  final Function toggle;

  @override
  State<Childs> createState() => _ChildsState();
}

class _ChildsState extends State<Childs> {

    int chooseOption = 0;

    void changeOption(int val){
    setState(() {
        chooseOption = val;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: CoffeeCarouselTop(toggle: widget.toggle,choose: chooseOption,)),
            Expanded(child: Container(
            
              width: MediaQuery.of(context).size.width,
           
              child:Column(
              children: [
               Padding(
                 padding: const EdgeInsets.all(16.0),
                 child:  Row(
                    children: [
                        RoundContainer(title: "Drinks",isSelected:chooseOption == 0?true:false,toggle: changeOption,index: 0,),
                        RoundContainer(title: "Donuts",isSelected:chooseOption == 1?true:false,toggle: changeOption,index: 1,)
                    ],
                  ),
               ),
                Expanded(child: ListView(
                  physics:const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children:chooseOption==0?coffeename.asMap().entries.map((e) => ListCardContainer(title: e.value.entries.first.key,price: e.value.entries.first.value.toString(),index: chooseOption,listindex: e.key,)).toList():donutname.asMap().entries.map((e) => ListCardContainer(title: e.value.entries.first.key,price: e.value.entries.first.value.toString(),index: chooseOption,listindex: e.key,)).toList(),
                ))
              ],
              ),
            ))



        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.done),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}




class CoffeeCarouselTop extends StatefulWidget {
  const CoffeeCarouselTop({
    super.key,
    required this.toggle,
    required this.choose
  });

  final Function toggle;
  final int choose;
  @override
  State<CoffeeCarouselTop> createState() => _CoffeeCarouselTopState();
}

class _CoffeeCarouselTopState extends State<CoffeeCarouselTop> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  int index = 0;
  late Animation<double> fade;
  late Animation<double> fade2;
  late Animation<Offset> slide;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this,duration:const Duration(milliseconds: 1000));
        fade = Tween<double>(begin: 0.5,end: 1).animate(controller);
        fade2 = Tween<double>(begin: 0,end: 1).animate(controller);
        slide = Tween<Offset>(begin: Offset(0.5, 0),end:Offset(0,0)).animate(controller);
    controller.forward();
  }
  void onPageChange(int val){
   
    setState(() {
      index = (val%4).round();
    });
      if(controller.isDismissed){
        controller.forward();
      }else{
        controller.reset();
        controller.forward();
      
      }
      
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 0,
            child: ClipPath(
              clipper: CurvedBottomClipper(),
              child: Hero(
                tag: "gradients",
                child: FadeTransition(
                  opacity: fade,
                  child: Container(
                    height: 170,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors:col[index]
                            )),
                  ),
                ),
              ),
            )),
        Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,      

              leading: IconButton(
                  onPressed: () {
                    widget.toggle();
                  },
                  icon: const Icon(Icons.menu)),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.shopping_bag)),
              ],
            ),
            CarouselSlider(
                items: List.generate(
                  5,
                  (index) => InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, Detailspage.routename,arguments:[index,widget.choose]);
                    },
                    child: Container(
                      height: 500,
                      width: 500,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Hero(

                           tag: 'CoffeeHero$index',
                        child: Image.asset(
                          "assets/coffee.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),  
                options: CarouselOptions(
                  onPageChanged: (index, reason){
                     onPageChange(index);
                  },
                  animateToClosest: true,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.4,
                  autoPlayCurve: Curves.easeIn,
                  viewportFraction: 0.5,
                )),
            
            
              FadeTransition(
                opacity: fade,
                child: SlideTransition(
                  position: slide,
                  child: Column(
                    children: [
                      Text(coffeename[index].entries.first.key,style: TextStyle(fontSize: 16,color: Colors.brown,fontWeight: FontWeight.bold),),
                      Text(coffeename[index].entries.first.value.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
          ],
        ),              
      
      ],
    );
  }
}
