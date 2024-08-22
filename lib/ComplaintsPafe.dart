import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ComplaintsPage extends StatefulWidget {
  const ComplaintsPage({super.key});

  @override
  State<ComplaintsPage> createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  TextEditingController complaint = TextEditingController();

  TextEditingController Commment_controller= TextEditingController();

  bool idToggled = true;

  String name = 'Student: Ganesh';
  String rgNo = '';
  String reg='Rg No: ..........';
  String imagePath = 'assets/login_picstu.png';

  @override
  void initState() {
    super.initState();
    FetchSharedPrefs();
  }

  Future<void> FetchSharedPrefs() async {
    SharedPreferences myprefs = await SharedPreferences.getInstance();
    String? Number34 = myprefs.getString('Number');
    setState(() {
      rgNo=Number34!;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/main_background_design2.png'),fit: BoxFit.cover,
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Switch(
                        activeColor: Colors.red,
                        value: idToggled, onChanged: (value){
                      setState(() {
                        idToggled = value;
                        print(idToggled);
                        if (value) {
                          reg = 'Rg No: ..........';
                          imagePath = 'assets/login_picstu.png';
                        } else {
                          reg = 'Rg No: $rgNo';
                          imagePath = 'assets/people.png';
                        }
                      });
                    })
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(imagePath),
                        ),
                      ),
                    ),
                    Text(reg, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                  ],
                ),
                SizedBox(height: 30,),
                Container(
                  color: Colors.white.withOpacity(0.3),
                  height: 300,
                  child: TextField(
                    controller: complaint,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none
                      ),
                      hintText: 'Type something...',
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  SubmitComplaint();
                }, child: Text('Submit'))
              ],
            ),
          ),
        ),
      ),
    );
  }


  SubmitComplaint() async {
    if(idToggled==true){
      //complaint ananonymosly
      var url = "http://your_ip_address/sample_api/anonyComplaints.php";
      var response = await http.post(Uri.parse(url),body: {
        'complaint':complaint.text,
      });
      print(response.statusCode);
      print(response.body);
    }else{
      //complaint with identity
      var url = "http://your_ip_address/sample_api/anonyComplaints.php";
      var response = await http.post(Uri.parse(url),body: {
        'identitycomplaint':complaint.text,
        'number':rgNo
      });
      print(response.statusCode);
      print(response.body);
    }
  }



}

