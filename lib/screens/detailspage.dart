import 'package:animations/const.dart';
import 'package:flutter/material.dart';

class Detailspage extends StatefulWidget {
  const Detailspage({super.key});
  static const String routename = "DetailsPage";

  @override
  State<Detailspage> createState() => _DetailspageState();
}

class _DetailspageState extends State<Detailspage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController slideupController;
  late AnimationController _slidecontroller;
  late AnimationController _scalecontroller;
  late Animation<double> fade;
  late Animation<Offset> slideup;
  double height = 0;
  bool isselect = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

        slideupController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _slidecontroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));

    _scalecontroller = AnimationController(vsync: this,duration:const Duration(milliseconds: 400));


    fade = Tween<double>(begin: 0, end: 1).animate(controller);
    slideup = Tween<Offset>(begin: Offset(0,-1),end:Offset(0, 0) ).animate(slideupController);
    changefirst();

    slideupController.forward();
  }

  void changefirst() {
    Future.delayed(Duration(milliseconds: 300)).then((value) {
      setState(() {
        height = 100;
      });
    });
  }

  void changeHeight() {

    if (isselect) {
      setState(() {
        height = 100;
        controller.reverse();
  
      });
    } else {
      setState(() {
        height = 300;
        controller.forward();
     
      });
    }
    changescale();

    isselect = !isselect;
  }

  void changescale(){
    if(_scalecontroller.isDismissed){
      _scalecontroller.forward();
    }else{
      _scalecontroller.reverse();
    }

  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    slideupController.dispose();
  
  }




  @override
  Widget build(BuildContext context) {
    final index = ModalRoute.of(context)!.settings.arguments as List<int>;
    int col_index = index[0]%4;
    int choose = index[1];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        backgroundColor:col[col_index][0],
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedBuilder(
              animation: _scalecontroller,
              builder: (context,i) {

                double scale = 1-(_scalecontroller.value*0.2);
                double slide = -180*_scalecontroller.value;
                double slide2 = 225*_slidecontroller.value-1;
                return Stack(
                  children: [

                    SlideTransition(
                      position: slideup,
                      child: Container(
                        width: double.infinity,
                        decoration:  BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: col[col_index])),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        right: 1,                  
                        bottom: 0,
                        
                        child: FadeTransition(
                          opacity: fade,

                          child: Transform(
                            transform: Matrix4.identity()..translate(slide2),
                            child: Container(
                              height:300,
                              width: MediaQuery.of(context).size.width/2,
                              
                              
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${choose==0?'Coffee':'Donut'} 1",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  Text("\$55.0",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                          ),
                        )),

                    Positioned(
                        top: 0,
                        right: 0,
                        bottom: 0,
                        left: 0,
                        child: Hero(
                            tag: 'CoffeeHero$index',
                            child: Transform( 
                              transform: Matrix4.identity()..translate(slide),
                              child: Image.asset(choose==0?'assets/coffee.png':'assets/donut.png',fit: BoxFit.contain,)))),

                               

                          
                  ],
                );
              }
            ),
          ),
          Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeIn,
                padding: const EdgeInsets.all(16),
                height: height,
                color: col[col_index][0],
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "About",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: changeHeight,
                            icon: isselect
                                ? const Icon(Icons.close)
                                : Icon(Icons.menu))
                      ],
                    ),
                    isselect
                        ? Expanded(
                            child: SingleChildScrollView(
                              child: Container(
                                child: const Text(dummytext),
                              ),
                            ),
                          )
                        : FadeTransition(
                            opacity: fade,
                            child: const SizedBox(),
                          )
                  ],
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
