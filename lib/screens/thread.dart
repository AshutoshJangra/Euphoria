import 'package:euphoria/configuration.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './edit.dart';

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
  String id = "";

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
                id = element.id;
              });
            })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgPrimeDark,
        title: Text(widget.root['data']['name']),
        actions: bo.length <= 0
            ? [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Edit(p: pb, i: id, tid: widget.root['tid'])));
                    },
                    icon: Icon(
                      Icons.edit_attributes_rounded,
                      color: Colors.pink[400],
                    ),
                    label: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Edit',
                        style: TextStyle(color: Colors.pink[400]),
                      ),
                    ),
                  ),
                )
              ]
            : null,
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
                    margin: EdgeInsets.symmetric(horizontal: 36, vertical: 10),
                    width: double.infinity,
                    child: Text(
                      t_list[index]!,
                      style: TextStyle(
                        color: textPrimeDark,
                        fontSize: 15,
                      ),
                    ));
              }),
          TextButton(
              onPressed: () {
                pb = bo;
                getThread(pb);
              },
              child: Text(bo)),
          TextButton(
              onPressed: () {
                pb = bt;
                getThread(pb);
              },
              child: Text(bt))
        ],
      ),
    );
  }
}
