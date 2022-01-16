import 'package:euphoria/screens/upload.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../configuration.dart';

class threads extends StatefulWidget {
  const threads({Key? key}) : super(key: key);

  @override
  State<threads> createState() => _threadsState();
}

class _threadsState extends State<threads> {
  List<dynamic> list = [];

  @override
  void initState() {
    super.initState();

    getThread();
  }

  Future<void> getThread() {
    return FirebaseFirestore.instance
        .collection('threads')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach(
        (doc) {
          // print(doc.data());
          setState(() {
            list.add(doc.data());
            list = list;
          });
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Upload()),
              );
            },
            child: Container(
              width: double.infinity,
              height: 100,
              child: Image.network(
                list[index]!["img"],
                fit: BoxFit.cover,
              ),
            ),
          );
        });
  }
}
