import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SelectUser.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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
          title: Text('My account',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        ),
        body: ElevatedButton(onPressed: () async {
          SharedPreferences myprefs = await SharedPreferences.getInstance();
          await myprefs.clear();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SelectUserPage()));
        }, child: Row(
          children: [
            Icon(Icons.logout),
            SizedBox(width: 4,),
            Text('Logout',style: TextStyle(fontSize: 20),),
          ],
        )),
      ),
    );
  }
}
