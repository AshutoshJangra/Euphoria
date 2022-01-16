import 'package:euphoria/configuration.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Thread extends StatefulWidget {
  final dynamic root;
  const Thread({Key? key, required this.root}) : super(key: key);

  @override
  _ThreadState createState() => _ThreadState();
}

class _ThreadState extends State<Thread> {
  List<dynamic> t_list = [];
  String pb = "";
  String bo = "";
  String bt = "";

  @override
  void initState() {
    super.initState();
    pb = widget.root['data']['root'];
    getThread(pb);
  }

  Future<void> getThread(pb) {
    return FirebaseFirestore.instance
        .collection('threads')
        .doc(widget.root['tid'])
        .collection('thread')
        .where('pb', isEqualTo: pb)
        .get()
        .then((QuerySnapshot q) => (q.docs.forEach((element) {
              dynamic a = element.data();
              setState(() {
                t_list.add(a['text']);
                bo = a['bo'];
                bt = a['bt'];
                print(a['text']);
              });
            })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgPrimeDark,
        title: Text(widget.root['data']['name']),
        elevation: 0,
      ),
      body: Column(
        children: [
          ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 10,
                );
              },
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: t_list.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    margin: EdgeInsets.all(20),
                    width: double.infinity,
                    child: Text(
                      t_list[index]!,
                      style: TextStyle(color: textPrimeDark),
                    ));
              }),
          TextButton(
              onPressed: () {
                getThread(bo);
              },
              child: Text(bo)),
          TextButton(onPressed: () => print(bt), child: Text(bt))
        ],
      ),
    );
  }
}
