import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class OptionsAndDataScreen extends StatefulWidget {
  @override
  _OptionsAndDataScreenState createState() => _OptionsAndDataScreenState();
}

class _OptionsAndDataScreenState extends State<OptionsAndDataScreen> {
  String? selectedOption = 'csd';
  String? selectedChoice = '2_1';
  List data= [];
  List data2=[];

  List<String> optionList = ['csd', 'csm', 'cse','mech','ece'];
  List<String> choiceList = ['1_1', '1_2', '2_1', '2_2','3_1','3_2','4_1','4_2'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata(selectedOption,selectedChoice);
  }
  Future <void> fetchdata(dept,sem) async {
    String department = dept.toString();
    String semis = sem.toString();
    try{
      var url = "http://your_ip_address/sample_api/CSDsyllabusRetrieve.php";

      var res= await http.post(Uri.parse(url),body: {
        "branch":department,
        "sem":semis,
      });
      if(res.statusCode==200) {
        var items = json.decode(res.body);
        print(items);
          data=items;
          print(data);
      }else {
        data = [];
      }

    }catch(e){
      print(e);
    }
  }
  Widget getDesign(item) {
    var subject = item['subjects'];
    print(subject);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            child: ListTile(
              title: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                  ),
                ),
                onPressed: () async {
                  await fetchChapters(subject, () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)
                          ),
                          backgroundColor: Colors.yellowAccent.shade400,
                          title: Text('Chapters'),
                          content: Column(
                            children: data2.map((item) {
                              return getAlertDesign(subject, item);
                            }).toList(),
                          ),
                        );
                      },
                    );
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('$subject', style: TextStyle(fontSize: 30)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget getAlertDesign(subject, item) {
    var unitname = item['lessons'];
    print(unitname);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 10),
      title: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(unitname),
                SizedBox(height: 10),
                Text(unitname),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Download'),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> fetchChapters(subject,Function callback) async {
    try {
      var url = "http://your_ip_address/sample_api/fetchChapters.php";

      var respo = await http.post(Uri.parse(url), body: {
        "subject": subject,
      });
      print(respo.statusCode);
      if (respo.statusCode == 200) {
        var chapters = json.decode(respo.body);
        print(chapters);
        setState(() {
          data2=chapters;
        });
        print(data2);
        if (callback != null) {
          callback(); // Call the callback function
        }
      } else {
        print('error in retriving data');
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/main_background_design2.png'),fit: BoxFit.cover,
        )
      ),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.yellowAccent.shade400,
          title: Text('Courses&\nBranches'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<String>(
                  hint: Text('Branch',),
                  value: selectedOption,
                  onChanged: (newValue1){
                    setState(() {
                      selectedOption = newValue1;
                    });
                    fetchdata(newValue1, selectedChoice);
                  },
                  items: optionList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(fontSize: 20),),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                DropdownButton<String>(
                  value: selectedChoice,
                  onChanged: (newValue){
                    setState(() {
                      selectedChoice = newValue;
                    });
                    fetchdata(selectedOption, newValue);
                  },
                  items: choiceList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(fontSize: 20),),
                    );
                  }).toList(),
                ),
              ],
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
          future: fetchdata(selectedOption, selectedChoice),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return getDesign(data[index]);
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
