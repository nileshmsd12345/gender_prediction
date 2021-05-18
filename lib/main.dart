import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import'package:flutter_spinkit/flutter_spinkit.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    );
  }
}
 
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TextEditingController _nameController = TextEditingController();
  AnimationController _controller;
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller= AnimationController(vsync: this, duration: Duration(seconds: 3));
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
      print(_controller.value);
     _controller.addStatusListener((status) {
       print(status);
       // if(status== AnimationStatus.completed){
       //   _controller.reverse(from: 1);
       // }
       // else if(status== AnimationStatus.dismissed){
       //   _controller.forward();
       // }
     });


    });
  }
  getColor(){
    if(_controller.value.floor().isEven){
     Color color= Colors.blue;
    }
    else{
      Color color= Colors.red;
    }
  }
  var result;
  predictGender(String name)async{
    var url = "http://api.genderize.io/?name=$name";
    var res = await http.get(url);
    var body = jsonDecode(res.body);
   result = "Gender:  ${body['gender']}, Probability :  ${body['probability']} %";
   setState(() {

   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Center(child: Text('Gender Prediction')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(child: Text('Enter a name to predict its gender')),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Enter a name",
                ),
              ),
            ),
            RaisedButton(
              onPressed: () => predictGender(_nameController.text),
              child: Text('Predict'),
            ),
             SpinKitCircle(
               color: _controller.value.floor().isEven ? Colors.blue : Colors.red,
               size: _controller.value*100,

             ),


             if (result != null) Text(result),
          ],
        ),
      ),
    );
  }
}
