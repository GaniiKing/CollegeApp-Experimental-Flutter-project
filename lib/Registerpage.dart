import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled1/Loginpage.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  TextEditingController username = TextEditingController();
  TextEditingController Regnumber = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController Re_typepass = TextEditingController();


  Future<void> InsertData() async {
    if(username.text!="" && Regnumber.text!="" && Password.text!="") {
      if(Password.text == Re_typepass.text) {
        try{
          String url = "http://your_ip_address/sample_api/registerstudent.php";

          var res = await http.post(Uri.parse(url),body: {
            'name':username.text,
            'register-number':Regnumber.text,
            'password':Password.text,
          });

          var response2 = json.decode(res.body);
          if ( response2['message'] == 'Successful') {
            print('Record insertion successful');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Loginpage()));
            Fluttertoast.showToast(
                msg: "Registered Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.greenAccent,
                textColor: Colors.white,
                fontSize: 16.0
            );
          } else if (response2['error']=='Error inserting record:') {
            Fluttertoast.showToast(
                msg: "Error try again later",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
            print('Failed Registration');
          } else {
            print('Unexpected response format');
          }


        }catch(e){
          print(e);
        }
      }else{
        Fluttertoast.showToast(
            msg: "Password didnt match",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.yellow,
            textColor: Colors.white,
            fontSize: 16.0
        );
        print('password didnt match');
      }
    }else{
      Fluttertoast.showToast(
          msg: "Please enter all the Details",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.yellow,
          textColor: Colors.white,
          fontSize: 16.0
      );
      print('enter all the details');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/main_background_design2.png'),fit: BoxFit.fill
        ),
      ),
      child: Scaffold(
        backgroundColor:Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Card(
                    color: Colors.white.withOpacity(0.4),
                    elevation:30,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/student_loginimage.png'),
                            ),
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage('assets/usernameside_pic.png'),
                              ),
                              SizedBox(height: 10,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 20),
                                  child: TextField(
                                    controller: username,
                                    decoration: InputDecoration(
                                        labelText: 'Username',
                                        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15,),


                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage('assets/usernameside_pic.png'),
                              ),
                              SizedBox(height: 10,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 20),
                                  child: TextField(
                                    controller: Regnumber,
                                    decoration: InputDecoration(
                                        labelText: 'Registration Number',
                                        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15,),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage('assets/usernameside_pic.png'),
                              ),
                              SizedBox(height: 10,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 20),
                                  child: TextField(
                                    controller: Password,
                                    obscureText: true,
                                    decoration: InputDecoration(

                                        labelText: 'Password',
                                        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage('assets/usernameside_pic.png'),
                              ),
                              SizedBox(height: 10,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 20),
                                  child: TextField(
                                    obscureText: true,
                                    controller: Re_typepass,
                                    decoration: InputDecoration(
                                        labelText: 'Re-type password',
                                        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15,),
                          const SizedBox(height: 30,),
                          ElevatedButton(onPressed: (){

                            InsertData();

                          }, child: const Text('Register',style: TextStyle(fontWeight: FontWeight.bold),)),
                          const SizedBox(height: 20,),
                          TextButton(onPressed: (){

                            Navigator.pushReplacementNamed(context, 'login');

                          }, child: const Text('Login',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ),
      ),
    );
  }
}


