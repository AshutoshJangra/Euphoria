import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:euphoria/configuration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Edit extends StatefulWidget {
  final String p;
  final String tid;
  final String i;

  const Edit({Key? key, required this.p, required this.tid, required this.i})
      : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  String txt = "";
  final rcontroller = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  void initState() {
    super.initState();
    getThread(widget.p);
  }

  Future<void> getThread(pb) {
    return FirebaseFirestore.instance
        .collection('threads')
        .doc(widget.tid)
        .collection('thread')
        .where('pb', isEqualTo: pb)
        .get()
        .then((QuerySnapshot q) => (q.docs.forEach((element) {
              dynamic a = element.data();
              setState(() {
                txt = a['text'];
              });
            })));
  }

  Future<void> addText() async {
    String tmp = "";
    await FirebaseFirestore.instance
        .collection('threads')
        .doc(widget.tid)
        .collection('thread')
        .doc(widget.i)
        .collection('comments')
        .orderBy('upvote', descending: true)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) => tmp = element['text']);
    });

    DocumentReference docref = FirebaseFirestore.instance
        .collection('threads')
        .doc(widget.tid)
        .collection('thread')
        .doc(widget.i);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snap = await transaction.get(docref);

      if (!snap.exists) {
        throw Exception("Err");
      }

      String newText = snap["text"] + " " + tmp;

      transaction.update(docref, {'text': newText});
      return newText;
    }).then((value) => print(value));

    return docref
        .collection('comments')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        if (element.exists) {
          element.reference.delete();
        }
      });
    });
  }

  Future<void> incCounter(doc) {
    DocumentReference docref = FirebaseFirestore.instance
        .collection('threads')
        .doc(widget.tid)
        .collection('thread')
        .doc(widget.i)
        .collection('comments')
        .doc(doc);

    return FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snap = await transaction.get(docref);

      if (!snap.exists) {
        throw Exception("Err");
      }

      int newCount = snap["upvote"] + 1;

      transaction.update(docref, {'upvote': newCount});
      return newCount;
    }).then((value) => print('comment liked'));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.p);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
        backgroundColor: bgPrimeDark,
        elevation: 0,
        actions: [
          TextButton.icon(
            onPressed: () {
              addText();
            },
            icon: Icon(
              Icons.add_circle,
            ),
            label: Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Text('Add'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.white10,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                txt,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('threads')
                    .doc(widget.tid)
                    .collection('thread')
                    .doc(widget.i)
                    .collection('comments')
                    .snapshots(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, i) {
                        return Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    snapshot.data!.docs[i]['photo']),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        incCounter(snapshot.data!.docs[i].id);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.white12,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 15),
                                        child: Container(
                                          width: 250,
                                          child: Text(
                                            snapshot.data!.docs[i]['text'],
                                            style: TextStyle(
                                                color: textPrimeDark,
                                                fontSize: 16),
                                            softWrap: true,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                snapshot.data!.docs[i]['upvote'].toString(),
                                style: TextStyle(
                                    color: Colors.blue[300], fontSize: 22),
                              )
                            ],
                          ),
                        );
                      });
                }),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  style: TextStyle(color: textPrimeDark),
                  decoration: InputDecoration(
                    fillColor: textPrimeDark.withOpacity(0.3),
                    filled: true,
                    focusColor: textPrimeDark,
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                        borderSide: BorderSide(width: 0)),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                        borderSide: BorderSide(width: 0)),
                  ),
                  controller: rcontroller,
                ),
              ),
              TextButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('threads')
                        .doc(widget.tid)
                        .collection("thread")
                        .doc(widget.i)
                        .collection('comments')
                        .add({
                      "name": user.displayName,
                      "text": rcontroller.text,
                      "photo": user.photoURL.toString(),
                      "upvote": 0,
                    });
                    rcontroller.text = "";
                  },
                  child: Text('Send')),
            ],
          )
        ],
      ),
    );
  }
}
