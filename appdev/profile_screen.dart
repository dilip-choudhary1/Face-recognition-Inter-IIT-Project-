import 'package:flutter/material.dart';
import 'package:interiit/Screens/home_screen.dart';
import 'package:interiit/main.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({super.key});

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/19.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(),
            Container(
              padding:const EdgeInsets.only(left: 35, top: 50),
              child: const Text(
                'Check your Attendance',
                style: TextStyle(color: Colors.black, fontSize: 33,fontWeight: FontWeight.w700),
              ),
            ),
            
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 50, right: 50, top: 0),
                            child: const Text('Total Classes ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.amber,
                            padding: const EdgeInsets.only(left: 50, right: 50, top:10),
                            child: const Text('100',style: TextStyle(fontSize: 20),),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            
                            padding: const EdgeInsets.only(left: 50, right: 50, top: 0),
                            child: const Text('Total Present ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                            
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.amber,
                            padding: const EdgeInsets.only(left: 50, right: 50, top:10),
                            child: const Text('50',style: TextStyle(fontSize: 20),),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 50, right: 50, top: 0),
                            child: const Text('Attendance % ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: Colors.amber,
                            padding: const EdgeInsets.only(left: 50, right: 50, top:10),
                            child: const Text('50',style: TextStyle(fontSize: 20),),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Padding(padding: const EdgeInsets.only(left: 1, right: 0),),
                              const Text(
                                'Mark Attendance',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                              
                                radius: 30,
                                backgroundColor: Colors.black,
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const MyRegister()));
                                    },
                                    icon:const  Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Padding(padding: const EdgeInsets.only(left: 50,right: 30)),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                                },
                                child: Text(
                                  'Log out',
                                  textAlign:  TextAlign.left,
                                  style: TextStyle(
                                      
                                      color: Colors.black,
                                      fontSize: 18),
                                ),
                                style: const ButtonStyle(),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    
  }
}
