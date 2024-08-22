import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class WriteDeptUpdates extends StatefulWidget {
  const WriteDeptUpdates({super.key});

  @override
  State<WriteDeptUpdates> createState() => _WriteDeptUpdatesState();
}

class _WriteDeptUpdatesState extends State<WriteDeptUpdates> {
  String? selectedOptions;
  List Updates =[];
  String number="";
  List<String> OptionsFromDB=[];
  List<String> Options=['2st year csd','2nd year csm'];
  String branchfromdb ="";
  List<DropdownMenuItem<String>>? dropdownItems=[];
  TextEditingController Post = TextEditingController();



  @override
  void initState(){
    //TODO:implement initState
    super.initState();
    retrieveData();
  }

  Future<void> retrieveData() async {
    SharedPreferences myprefs = await SharedPreferences.getInstance();
    String? name2 = myprefs.getString('Number2');
    String? password2 = myprefs.getString('Password2');
    print(name2);
    print(password2);
    var url = "http://your_ip_address/sample_api/RetrieveCrewBranch.php";
    var response = await http.post(Uri.parse(url),body: {
      'crewname':name2,
      'password':password2
    });
    print('Object are');
    print(response.body);
    print(response.statusCode);
    if(response.statusCode==200){
      var item = json.decode(response.body);
      print(item[0]['dept']);
      setState(() {
        branchfromdb=item[0]['dept'];
      });
    }
    print(branchfromdb);
    fetchOptions(branchfromdb);
  }

  List<String> extractOptions(List<dynamic> data) {
    List<String> optionsList = [];
    for (var item in data) {
      optionsList.add(item['options']);
    }
    return optionsList;
  }

  Future<void> fetchOptions(branchfromdb) async {
    print(branchfromdb);
    var url = "http://your_ip_address/sample_api/fetchdeptoptionsfromdb.php";
    var response = await http.post(Uri.parse(url),body: {
      'department':branchfromdb,
    });
    print('Running fetch options');
    print(response.statusCode);
    print('fetch options body is ');
    print(response.body);
    if(response.statusCode==200){
      var item = json.decode(response.body);
      print(item);
      setState(() {
        OptionsFromDB=extractOptions(item);
        dropdownItems = buildDropdownMenuItems(OptionsFromDB);

      });
    }
    print(OptionsFromDB);
    print(dropdownItems);
  }



  Future<void> fetchUpdates(selectedOptions) async {

    print('fetching Updates...');
    var url="http://your_ip_address/sample_api/fetchclassupdatescrew.php";
    var response = await http.post(Uri.parse(url),body: {
      'option':selectedOptions,
    });
    print(response.body);
    if(response.statusCode==200){
      var items = json.decode(response.body);
      print('items are $items');
      setState(() {
        Updates=items;
      });
    }else{
      Updates=[];
    }
  }



  Widget getBody() {
    print(Updates);
    var reversedUpdates = Updates.reversed.toList();
    return ListView.builder(
        itemCount: reversedUpdates.length,
        itemBuilder: (context,index){
          return getCard(reversedUpdates[index]);
        });
  }

  Widget getCard(part){
    var name = part['name'];
    var update = part['update'];
    var time = part['time'];


    return ListTile(
      title: Card(
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(20/2),topLeft: Radius.circular(20/2),bottomRight: Radius.circular(20/2),)
        ),
        color: Colors.yellow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0,top: 8.0),
              child: Text('$name :',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('$update',style: TextStyle(fontSize: 20),),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0,bottom: 8.0),
                  child: Text('$time'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/main_background_design2.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Year level',
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: getBody(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: Post,
                      decoration: InputDecoration(
                        hintText: 'Write Something..',
                        fillColor: Colors.lightGreen.shade100,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8,),
                  DropdownButton(
                      items: dropdownItems,
                      hint: Text('Select'),
                      value: selectedOptions,
                      onChanged: (newValue){
                        setState(() {
                          selectedOptions=newValue;
                        });
                        fetchUpdates(selectedOptions);
                        print(selectedOptions);
                      }),
                  IconButton(
                    onPressed: () {
                      postData(selectedOptions, Post.text);
                      fetchUpdates(selectedOptions);
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> buildDropdownMenuItems(List<String> options) {
    List<DropdownMenuItem<String>> items = [];
    for (String option in options) {
      items.add(
        DropdownMenuItem(
          value: option,
          child: Text(option),
        ),
      );
    }
    return items;
  }

  postData(selectedOptions,String Post) async {
    if(Post!=""){
      print('in postData $selectedOptions,$Post');
      print('postingUpdate');
      SharedPreferences myprefs = await SharedPreferences.getInstance();
      String? name2 = myprefs.getString('Number2');
      print(name2);

      var url = "http://your_ip_address/sample_api/postintoclassdata.php";
      var response = await http.post(Uri.parse(url),body: {
        'option':selectedOptions,
        'post':Post,
        'name':name2,
      });
      print(response.statusCode);
      print(response.body);



    }else{
      return;
    }
  }


}
