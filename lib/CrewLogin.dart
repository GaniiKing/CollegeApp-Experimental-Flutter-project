import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/HomePage.dart';

class CrewLogin extends StatefulWidget {
  const CrewLogin({super.key});

  @override
  State<CrewLogin> createState() => _CrewLoginState();
}

class _CrewLoginState extends State<CrewLogin> {
  TextEditingController checkcrewName = TextEditingController();
  TextEditingController checkpassword = TextEditingController();


  evaluatelogin(number,password) async {
    SharedPreferences myprefs = await SharedPreferences.getInstance();
    myprefs.setString('Number2', number);
    myprefs.setBool('Crew?', true);
    myprefs.setString('Password2',password);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homepage()));
  }


  AuthenticateUser() async {
    var url = "http://your_ip_address/sample_api/crewLogin.php";
    var response = await http.post(Uri.parse(url),body: {
      'Username':checkcrewName.text,
      'Password':checkpassword.text,
    });
    print(response.statusCode);
    print(response.body);
    if(response.statusCode==200){
      try {
        var response2 = json.decode(response.body);
        if (  response2['message'] == 'Success') {
          print('Login successful');
          String number = checkcrewName.text;
          String password = checkpassword.text;

          evaluatelogin(number,password);

        } else if ( response2['error'] == 'Failed') {
          print('Login Failed');
        } else {
          print('Unexpected response format');
        }

      } catch (e) {
        print('Error decoding response: $e');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/main_background_design2.png'),fit: BoxFit.cover
        ),
      ),
      child: Scaffold(
        backgroundColor:Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Card(
                color: Colors.white.withOpacity(0.4),
                elevation: 20,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(30.0),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/login_picstu.png'),
                        ),
                      ),
                      Text('Crew Login',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                      SizedBox(height: 40,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextField(
                          controller: checkcrewName,
                          decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextField(
                          controller: checkpassword,
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
                      const SizedBox(height: 30,),
                      ElevatedButton(onPressed: (){
                        AuthenticateUser();
                      }, child: const Text('Login',style: TextStyle(fontWeight: FontWeight.bold),)),
                      const SizedBox(height: 20,),
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
