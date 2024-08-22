import 'package:flutter/material.dart';
import 'package:untitled1/ShowHomePage.dart';
import 'AccountPage.dart';
import 'BusBay.dart';
import 'CrewWriteAndDisplayData.dart';
import 'UpdatesOptionsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with SingleTickerProviderStateMixin {
  var currentpage = DrawerSections.dashboard;

  @override
  void initState(){
    //TODO:implement initState
    super.initState();
    getUser();
  }


  bool? crew;

  getUser() async {
    SharedPreferences myprefs2 = await SharedPreferences.getInstance();
    bool? checkCrew=myprefs2.getBool('Crew?');
    if(checkCrew==true){
      setState(() {
        crew=true;
      });
    }else{
      crew=false;
    }
    ListcontentsCheck(crew);
    print(crew);
  }


  List<Tab> tabs = [
    Tab(child: Center(child: Icon(Icons.home,size: 40,)),),
    Tab(child: Center(child: Icon(Icons.update,size: 40,)),),
];

  List<Widget> ListcontentsCheck(bool? crew) {
    print('List content function is running $crew');
    List<Widget> TabsContent = [];

    if (crew == false){
      TabsContent = [
        ShowHomePage(),
        UpdatesOptionsPage(),
      ];

    } else if (crew == true) {
      TabsContent = [
        ShowHomePage(),
        WriteAndShowUpdatesOptionsPage(),
      ];

    }



    return TabsContent;
  }


  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(top: 15,),
      child: Column(
        children: [
          menuItem(3,'BusBay',Icons.location_on,
              currentpage==DrawerSections.busbay ?  true:false),
          menuItem(5,'Complaints',Icons.report_problem_outlined,
              currentpage==DrawerSections.complaints ?  true:false),
          menuItem(6,'Results',Icons.mark_as_unread,
              currentpage==DrawerSections.results ?  true:false),
          menuItem(7,'Gallery',Icons.photo_album_outlined,
              currentpage==DrawerSections.gallery ?  true:false),
        ],
      ),
    );
  }


  Widget menuItem(int id,String title,IconData icon,bool selected) {
    return  Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.pop(context);
          _navigateToPage(context,DrawerSections.values[id - 1]);
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(child: Icon(
                icon,
                size: 20,
                color: Colors.black,
              )),
              Expanded(
                  flex: 3,
                  child: Text(title,style: TextStyle(color: Colors.black,fontSize: 16),))
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context ,DrawerSections section) {
    switch (section) {
      case DrawerSections.busbay:
       Navigator.push(context , MaterialPageRoute(builder: (context) => BusBay(),));
        break;
      case DrawerSections.complaints:
       // Navigator.push(context , MaterialPageRoute(builder: (context) => Complaints(),));
        break;
      case DrawerSections.results:
        //Navigator.push(context , MaterialPageRoute(builder: (context) => Results(),));
        break;
      case DrawerSections.gallery:
       // Navigator.push(context , MaterialPageRoute(builder: (context) => Gallery(),));
        break;
      default:
        break;
    }
  }






  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/homepagebackground.jpg'),fit: BoxFit.fill,
          )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.blue.withOpacity(0.4),
              title: Text('Welcome to AVEV',style: TextStyle(fontSize: 20),),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountPage()));
                  }, icon: Icon(Icons.account_circle_rounded,size: 50,)),
                )
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: TabBar(
                  isScrollable: true,
                  indicatorPadding: EdgeInsets.only(top: 45),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.purple, // Change this color to the desired indicator color
                  ),
                  tabs: tabs,
                ),
              ),
            ),
          ),
          drawer: Drawer(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    MyHeaderDrawer(),
                    MyDrawerList(),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: ListcontentsCheck(crew),
          ),

        ),
      ),
    );
  }
}

enum DrawerSections {
  home,
  updates,
  busbay,
  events,
  complaints,
  results,
  gallery,
  about_us,
  settings,
  dashboard,
}



class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({super.key});

  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/student_loginimage.png'),
              ),
            ),
          ),
          const Text('Ganesh',style: TextStyle(color: Colors.white,fontSize: 20),),
          const SizedBox(height: 2),
          Text('22Q71A4446',style: TextStyle(color: Colors.grey[200],fontSize: 14,),),
        ],
      ),
    );
  }
}
