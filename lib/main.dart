import 'package:animations/child1.dart';
import 'package:animations/screens/detailspage.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
    
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        
        Detailspage.routename:(context) =>const Detailspage()
      },
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{

  late AnimationController _controller;
  late AnimationController _drawercontroller;
  late List<Animation<Offset>> logoFadeAnimation = [];
  
  double maxslide = 225.0;
  @override
  void initState() {
    super.initState();
   _controller = AnimationController(vsync: this,duration:const Duration(milliseconds: 1000));
   _drawercontroller = AnimationController(vsync: this,duration: const Duration(milliseconds: 300));
  
  changeAnimation();
  }
 
  void changeAnimation(){
    logoFadeAnimation = List.generate(5, (index) => Tween<Offset>(begin: const Offset(-1, 0),end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve:Interval( index *(1/5), 1))));
    _controller.forward();
    
    
  }
void toggle(){
if(_drawercontroller.isDismissed){
  _drawercontroller.forward();
}else{
  _drawercontroller.reverse();
}
}

  void _incrementCounter() {
    
    // if(_controller.isCompleted){
    //   _controller.reverse();
    // }else       {
    //   _controller.forward();
    // }
  }

  @override
  Widget build(BuildContext context) {
      
    return Scaffold(
      body: AnimatedBuilder(
        animation: _drawercontroller,
        builder: (context,i) {
          double slide = maxslide*_drawercontroller.value;          
          double scale = 1-(_drawercontroller.value*0.3);
          return Stack(
            children: [
             const MyDrawer(),
              Transform(
                transform: Matrix4.identity()..translate(slide)..scale(scale),
                alignment: Alignment.centerLeft,
                child: Childs(controller: _controller,toggle: toggle,))
            ],
          );
        }
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
    );
  }
}

