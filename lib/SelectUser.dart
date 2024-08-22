import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/CrewLogin.dart';
import 'package:untitled1/Loginpage.dart';

class SelectUserPage extends StatefulWidget {
  const SelectUserPage({super.key});

  @override
  State<SelectUserPage> createState() => _SelectUserPageState();
}

class _SelectUserPageState extends State<SelectUserPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/main_background_design2.png'),fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Card(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                color: Colors.blue.withOpacity(0.4),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/usernameside_pic.png'),
                        radius: 40,
                      ),
                      SizedBox(height: 30,),
                      Text('Select User',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                      SizedBox(height: 30,),
                      ElevatedButton(onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const CrewLogin()));
                      }, child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Crew',style: TextStyle(fontSize: 50),),
                      )),
                      SizedBox(height: 30,),
                      ElevatedButton(onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Loginpage()));
                      }, child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Student',style: TextStyle(fontSize: 50),),
                      )),
                      SizedBox(height: 30,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
