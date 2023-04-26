import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:managment/data/listdata.dart';
import 'package:managment/data/model/add_date.dart';
import 'package:managment/data/utlity.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}
ValueNotifier kj = ValueNotifier(0);
class _CategoryState extends State<Category> {
  List type = ['Time', 'Category'];
  List f = [today(), week(), month(), year()];
  List<Add_data> a = [];
  int index_color = 0;

  var history;
  String plus='+';
  String minus="-";
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
                                    // kj.value = index;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                    Color.fromARGB(255, 47, 125, 121)
                                    ,
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
                    SliverToBoxAdapter(child: Center(child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text("Education",style: TextStyle(fontSize: 20),),
                    ),),),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          history = box.values.toList()[index];
                          return getList(history, index);
                        },
                        childCount: box.length,
                      ),
                    ),
                    SliverToBoxAdapter(child: Center(child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text("food",style: TextStyle(fontSize: 20),),
                    ),),),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          history = box.values.toList()[index];
                          return getList1(history, index);
                        },
                        childCount: box.length,
                      ),
                    ),
                    SliverToBoxAdapter(child: Center(child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text("Transfer",style: TextStyle(fontSize: 20),),
                    ),),),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          history = box.values.toList()[index];
                          return getList2(history, index);
                        },
                        childCount: box.length,
                      ),
                    ),
                    SliverToBoxAdapter(child: Center(child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text("Transportation",style: TextStyle(fontSize: 20),),
                    ),),),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          history = box.values.toList()[index];
                          return getList3(history, index);
                        },
                        childCount: box.length,
                      ),
                    ),

                  ],
                );
              })),
    );
  }

  Widget getList(Add_data history, int index) {
    return get(index,history)!=ListTile?Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          history.delete();
          box.length;
        },
        child: get(index, history)):SizedBox(height: 1,);
  }

  Widget get(int index, Add_data history) {
    return history.name=="Education"?
    ListTile(
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
        history.IN == 'Income' ?plus+ history.amount:minus +
            history.amount,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 19,
          color: history.IN == 'Income' ? Colors.green : Colors.red,
        ),
      ),
    ):SizedBox(height: 1,);
  }
  Widget getList1(Add_data history, int index) {
    return get1(index,history)!=ListTile?Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          history.delete();
        },
        child: get1(index, history)):SizedBox(height: 1,);
  }

  Widget get1(int index, Add_data history) {
    return history.name=="food"?
    ListTile(
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
        history.IN == 'Income' ?plus+ history.amount:minus +
            history.amount,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 19,
          color: history.IN == 'Income' ? Colors.green : Colors.red,
        ),
      ),
    ):ListTile();
  }
  Widget getList2(Add_data history, int index) {
    return get2(index,history)!=ListTile?Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          history.delete();
        },
        child: get2(index, history)):SizedBox(height: 1,);
  }

  Widget get2(int index, Add_data history) {
    return history.name=="Transfer"?
    ListTile(
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
        history.IN == 'Income' ?plus+ history.amount:minus +
            history.amount,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 19,
          color: history.IN == 'Income' ? Colors.green : Colors.red,
        ),
      ),
    ):SizedBox(height: 1,);
  }
  Widget getList3(Add_data history, int index) {
    return get3(index,history)!=ListTile?Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          history.delete();
        },
        child: get3(index, history)):SizedBox(height: 1,);
  }

  Widget get3(int index, Add_data history) {
    return history.name=="Transportation"?
    ListTile(
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
        history.IN == 'Income' ?plus+ history.amount:minus +
            history.amount,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 19,
          color: history.IN == 'Income' ? Colors.green : Colors.red,
        ),
      ),
    ):SizedBox(height: 1,);
  }




}

