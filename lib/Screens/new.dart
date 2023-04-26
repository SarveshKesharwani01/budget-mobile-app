import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:managment/data/listdata.dart';
import 'package:managment/data/model/add_date.dart';
import 'package:managment/data/utlity.dart';
import 'package:managment/widgets/profile.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var history;
  final box = Hive.box<Add_data>('data');
  final List<String> day = [
    'Monday',
    "Tuesday",
    "Wednesday",
    "Thursday",
    'friday',
    'saturday',
    'sunday'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text("Account", style: Theme.of(context).textTheme.headline4),
        actions: [IconButton(onPressed: () {}, icon: Icon(false ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [


              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100), child: const Image(image: NetworkImage(
                          "https://media.licdn.com/dms/image/C5603AQEeqMnvamHK1g/profile-displayphoto-shrink_800_800/0/1641790985939?e=2147483647&v=beta&t=IRX4QfQwWykPUsiyHYRrbFDinVEiPwvdwpUzj5HFKJU"
                          ))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white70),
                      child: const Icon(
                        LineAwesomeIcons.alternate_pencil,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text("Sarvesh Kesharwani", style: Theme.of(context).textTheme.headline4),
              Text("IIIT Pune", style: Theme.of(context).textTheme.bodyText2),
              const SizedBox(height: 20),

              /// -- BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amberAccent, side: BorderSide.none, shape: const StadiumBorder()),
                  child: const Text("Edit", style: TextStyle(color: Colors.blueAccent)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(title: "Settings", icon: LineAwesomeIcons.cog, onPress: () {}),
              // ProfileMenuWidget(title: "Billing Details", icon: LineAwesomeIcons.wallet, onPress: () {}),
              ProfileMenuWidget(title: "User Management", icon: LineAwesomeIcons.user_check, onPress: () {}),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(title: "Information", icon: LineAwesomeIcons.info, onPress: () {}),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: LineAwesomeIcons.alternate_sign_out,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    
                  },
                  // onPress: () {
                  //   Get.defaultDialog(
                  //     title: "LOGOUT",
                  //     titleStyle: const TextStyle(fontSize: 20),
                  //     content: const Padding(
                  //       padding: EdgeInsets.symmetric(vertical: 15.0),
                  //       child: Text("Are you sure, you want to Logout?"),
                  //     ),
                  //     confirm: Expanded(
                  //       child: ElevatedButton(
                  //         onPressed: () => AuthenticationRepository.instance.logout(),
                  //         style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, side: BorderSide.none),
                  //         child: const Text("Yes"),
                  //       ),
                  //     ),
                  //     cancel: OutlinedButton(onPressed: () => Get.back(), child: const Text("No")),
                  //   );
                  // }),
          )],
          ),
        ),
      ),
    );
  }

  // Widget getList(Add_data history, int index) {
  //   return Dismissible(
  //       key: UniqueKey(),
  //       onDismissed: (direction) {
  //         history.delete();
  //       },
  //       child: get(index, history));
  // }

  // ListTile get(int index, Add_data history) {
  //   return ListTile(
  //     leading: ClipRRect(
  //       borderRadius: BorderRadius.circular(5),
  //       child: Image.asset('images/${history.name}.png', height: 40),
  //     ),
  //     title: Text(
  //       history.name,
  //       style: TextStyle(
  //         fontSize: 17,
  //         fontWeight: FontWeight.w600,
  //       ),
  //     ),
  //     subtitle: Text(
  //       '${day[history.datetime.weekday - 1]}  ${history.datetime.year}-${history.datetime.day}-${history.datetime.month}',
  //       style: TextStyle(
  //         fontWeight: FontWeight.w600,
  //       ),
  //     ),
  //     trailing: Text(
  //       history.amount,
  //       style: TextStyle(
  //         fontWeight: FontWeight.w600,
  //         fontSize: 19,
  //         color: history.IN == 'Income' ? Colors.green : Colors.red,
  //       ),
  //     ),
  //   );
  // }

  // Widget _head() {
  //   return Stack(
  //     children: [
  //       Column(
  //         children: [
  //           Container(
  //             width: double.infinity,
  //             height: 240,
  //             decoration: BoxDecoration(
  //               color: Color(0xff368983),
  //               borderRadius: BorderRadius.only(
  //                 bottomLeft: Radius.circular(20),
  //                 bottomRight: Radius.circular(20),
  //               ),
  //             ),
  //             child: Stack(
  //               children: [
  //                 Positioned(
  //                   top: 35,
  //                   left: 340,
  //                   child: ClipRRect(
  //                     borderRadius: BorderRadius.circular(7),
  //                     child: Container(
  //                       height: 40,
  //                       width: 40,
  //                       color: Color.fromRGBO(250, 250, 250, 0.1),
  //                       child: Icon(
  //                         Icons.notification_add_outlined,
  //                         size: 30,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.only(top: 35, left: 10),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         'Good afternoon',
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.w500,
  //                           fontSize: 16,
  //                           color: Color.fromARGB(255, 224, 223, 223),
  //                         ),
  //                       ),
  //                       Text(
  //                         'Enjelin Morgeana',
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.w600,
  //                           fontSize: 20,
  //                           color: Colors.white,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //       Positioned(
  //         top: 140,
  //         left: 37,
  //         child: Container(
  //           height: 170,
  //           width: 320,
  //           decoration: BoxDecoration(
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Color.fromRGBO(47, 125, 121, 0.3),
  //                 offset: Offset(0, 6),
  //                 blurRadius: 12,
  //                 spreadRadius: 6,
  //               ),
  //             ],
  //             color: Color.fromARGB(255, 47, 125, 121),
  //             borderRadius: BorderRadius.circular(15),
  //           ),
  //           child: Column(
  //             children: [
  //               SizedBox(height: 10),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 15),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       'Total Balance',
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.w500,
  //                         fontSize: 16,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                     Icon(
  //                       Icons.more_horiz,
  //                       color: Colors.white,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(height: 7),
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 15),
  //                 child: Row(
  //                   children: [
  //                     Text(
  //                       '\$ ${total()}',
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 25,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(height: 25),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 15),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Row(
  //                       children: [
  //                         CircleAvatar(
  //                           radius: 13,
  //                           backgroundColor: Color.fromARGB(255, 85, 145, 141),
  //                           child: Icon(
  //                             Icons.arrow_downward,
  //                             color: Colors.white,
  //                             size: 19,
  //                           ),
  //                         ),
  //                         SizedBox(width: 7),
  //                         Text(
  //                           'Income',
  //                           style: TextStyle(
  //                             fontWeight: FontWeight.w500,
  //                             fontSize: 16,
  //                             color: Color.fromARGB(255, 216, 216, 216),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     Row(
  //                       children: [
  //                         CircleAvatar(
  //                           radius: 13,
  //                           backgroundColor: Color.fromARGB(255, 85, 145, 141),
  //                           child: Icon(
  //                             Icons.arrow_upward,
  //                             color: Colors.white,
  //                             size: 19,
  //                           ),
  //                         ),
  //                         SizedBox(width: 7),
  //                         Text(
  //                           'Expenses',
  //                           style: TextStyle(
  //                             fontWeight: FontWeight.w500,
  //                             fontSize: 16,
  //                             color: Color.fromARGB(255, 216, 216, 216),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(height: 6),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 30),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       '\$ ${income()}',
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.w600,
  //                         fontSize: 17,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                     Text(
  //                       '\$ ${expenses()}',
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.w600,
  //                         fontSize: 17,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }
}
