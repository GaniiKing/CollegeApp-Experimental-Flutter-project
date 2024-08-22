import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/HomePage.dart';
import 'package:untitled1/Registerpage.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController checkregnumber = TextEditingController();
  TextEditingController checkpassword = TextEditingController();

  Future<void> evaluatelogin(name)  async {
    String nodivide = checkregnumber.value.text;
    String yearcode = nodivide.substring(0,2);
    String branchcode = nodivide.substring(6,8);
    SharedPreferences mydata = await SharedPreferences.getInstance();
    mydata.setString('year', yearcode);
    mydata.setString('branch', branchcode);
    mydata.setString('Number', nodivide);
    mydata.setString('name', name);

    print(yearcode);
    print(branchcode);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Homepage()));
  }


  Future<void> authenticateuser() async{
    if(checkregnumber.text !="" && checkpassword.text !=""){
      try{

        String uri = "http://your_ip_address/sample_api/loginstudent.php";

        var res= await http.post(Uri.parse(uri),body:{
          "registerer":checkregnumber.text,
          "password":checkpassword.text,
        });

        try {

          var response = json.decode(res.body);
          if (  response['message'] == 'Success') {
            print('Login successful');
            String number = checkregnumber.text;
            String studentName = response['Student_Name'];

            SharedPreferences myprefs = await SharedPreferences.getInstance();
            myprefs.setString('Number', number);
            myprefs.setBool('Crew?', false);


            evaluatelogin(studentName);
            Fluttertoast.showToast(
                msg: "Login Successful",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );


          } else if ( response['error'] == 'Failed') {
            print('Login Failed');
          } else {
            print('Unexpected response format');
          }

        } catch (e) {
          print('Error decoding response: $e');
        }


      }catch (e){
        print(e);
      }
    }else{
      print('Enter all the fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextField(
                          controller: checkregnumber,
                          decoration: InputDecoration(
                              labelText: 'Registration Number',
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
                        authenticateuser();
                      }, child: const Text('Login',style: TextStyle(fontWeight: FontWeight.bold),)),
                      const SizedBox(height: 20,),
                      TextButton(onPressed: (){

                        Navigator.pushReplacementNamed(context, 'register');

                      }, child: const Text('Register',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))
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
