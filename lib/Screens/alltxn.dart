import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:managment/data/listdata.dart';
import 'package:managment/data/model/add_date.dart';
import 'package:managment/data/utlity.dart';
import 'package:managment/widgets/categorylist.dart';

class Alltxn extends StatefulWidget {
  const Alltxn({Key? key}) : super(key: key);

  @override
  State<Alltxn> createState() => _AlltxnState();
}

class _AlltxnState extends State<Alltxn> {
  String plus='+';
  String minus="-";
  List type = ['Time', 'Category'];
  List f = [today(), week(), month(), year()];
  List<Add_data> a = [];
  int index_color = 0;
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
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, value, child) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: SizedBox(height: 20,),),
                    SliverToBoxAdapter(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...List.generate(
                            2,
                                (index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    index_color = index;

                                  });
                                  if(index==1) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                        builder: (context) => Category()));
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: index_color == index
                                        ? Color.fromARGB(255, 47, 125, 121)
                                        : Colors.white,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    type[index],
                                    style: TextStyle(
                                      color: index_color == index
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),),
                    SliverToBoxAdapter(child: SizedBox(height: 20,),),
              
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Transactions History',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 19,
                                color: Colors.black,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                print("seen");
                              },
                              child: Text(
                                'See all',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          history = box.values.toList()[index];
                          return getList(history, index);
                        },
                        childCount: box.length,
                      ),
                    )
                  ],
                );
              })),
    );
  }

  Widget getList(Add_data history, int index) {
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          history.delete();
        },
        child: get(index, history));
  }

  ListTile get(int index, Add_data history) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset('images/${history.name}.png', height: 40),
      ),
      title: Text(
        history.name,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        '${day[history.datetime.weekday - 1]}  ${history.datetime.year}-${history.datetime.day}-${history.datetime.month}',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        history.amount,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 19,
          color: history.IN == 'Income' ? Colors.green : Colors.red,
        ),
      ),
    );
  }

 
  
}