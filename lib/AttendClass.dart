import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class AttendClass extends StatefulWidget {
  const AttendClass({super.key});

  @override
  State<AttendClass> createState() => _AttendClassState();
}

class _AttendClassState extends State<AttendClass> {
  List Students = [];
  String number2 ="";

  @override
  void initState() {
    super.initState();
    getStudents();
  }

  Future<void> sendAllAttendanceData() async {
    List<Map<String, String>> attendanceData = [];

    for (int i = 0; i < Students.length; i++) {
      var attendanceStatus = checkboxValues[i] ? 'present' : 'absent';

      attendanceData.add({
        'student_name': Students[i]['Students'],
        'attendance_status': attendanceStatus,
      });
    }

    print(attendanceData);

    var url = "http://your_ip_address/sample_api/insertAttendance.php";
    var response2 = await http.post(Uri.parse(url), body: {
      'data': jsonEncode(attendanceData),
      'Number':number2,
    });



    print(response2.body);
    if (response2.statusCode == 200) {
      print("All attendance submitted successfully");
    } else {
      print("Failed to submit attendance");
    }
  }







  Future<void> getStudents() async {

    SharedPreferences myprefs = await SharedPreferences.getInstance();
    String? number = myprefs.getString('Number');
    print(number);
    setState(() {
      number2=number!;
    });
    print(number2);

    var url = "http://your_ip_address/sample_api/add_new_column.php";
    var response = await http.post(Uri.parse(url),body:{
      'number':number,
    });
    print(response.statusCode);

    if(response.statusCode==200) {
      print(response.body);

      var BodyUsers = json.decode(response.body);



        print('Body after decode is $BodyUsers');

        setState(() {
          Students = BodyUsers;
          checkboxValues = List.generate(
              Students.length, (index) => false); // Initialize checkboxValues
        });
      }


  }

  List<bool> checkboxValues = [];

  void handleCheckbox(int index,bool value) {
    setState(() {
      checkboxValues[index] = value;
    });
  }



  Widget GetStudentAttend(finaleStudent,int index) {

    var name = finaleStudent['Students'];

    Color cardColor = checkboxValues[index] ? Colors.green : Colors.red;

    return Padding(
      padding: EdgeInsets.only(top: 10,bottom: 20,left: 25,right: 25),
      child: Card(
          color: cardColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('$name',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              CheckboxMenuButton(child: Text('Clickhere'),
                  value: checkboxValues[index], onChanged: (value){
                    handleCheckbox(index,value!);
              }),
            ],
          )),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/TimeTableBackground.jpg'),fit: BoxFit.cover,
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
              sendAllAttendanceData();
            }, icon: Icon(Icons.save)),
          ],
          title: Text('Attendance(Only CR)',style: TextStyle(fontSize: 20),),
        ),
        body: ListView.builder(
            itemCount: Students.length,
            itemBuilder: (context,index){
          return GetStudentAttend(Students[index],index);
        }),
      ),
    );
  }
}
