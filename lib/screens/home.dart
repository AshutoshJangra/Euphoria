import 'package:euphoria/screens/thread.dart';
import 'package:euphoria/screens/upload.dart';
import 'package:flutter/material.dart';
import '../configuration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/thread.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: null,
            icon: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.search,
                color: textPrimeDark,
              ),
            ),
          ),
        ],
        backgroundColor: bgPrimeDark,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: bgPrimeDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 30, 120, 30),
                child: Text(
                  'Twilight Of The Bots',
                  style: TextStyle(
                    fontSize: 32,
                    color: textPrimeDark,
                    letterSpacing: 5,
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.left,
                  softWrap: true,
                ),
              ),
              // search(),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Popular',
                        style: TextStyle(
                          fontSize: 14,
                          color: textPrimeDark,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      height: 200,
                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      child: popular(),
                    )
                  ],
                ),
              ),
              threads(),
            ],
          ),
        ),
      ),
    );
  }
}

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
          setState(() {
            list.add({'data': doc.data(), 'tid': doc.id});
            list = list;
          });
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 10,
          );
        },
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Thread(root: list[index]!),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              height: 250,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.network(
                      list[index]!['data']["img"],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      colors: [
                        bgPrimeDark.withOpacity(0.7),
                        bgPrimeDark.withOpacity(0.5)
                      ],
                    )),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 10, 100, 10),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(color: Colors.pink[300]),
                          child: Text(
                            list[index]!['data']['genre'],
                            style: TextStyle(
                              fontSize: 12,
                              color: bgPrimeDark,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          list[index]!['data']['name'],
                          style: TextStyle(
                            fontSize: 20,
                            color: textPrimeDark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          list[index]!['data']['text'],
                          style: TextStyle(
                            fontSize: 12,
                            color: textPrimeDark.withOpacity(0.8),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class popular extends StatelessWidget {
  const popular({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 8),
          width: 160,
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: NetworkImage(
                    'https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Forig11.deviantart.net%2F127e%2Ff%2F2013%2F083%2Fe%2F8%2Ftaxi_driver___alternative_poster_by_crisvector-d5z6rnc.jpg&f=1&nofb=1'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 8),
          width: 160,
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: NetworkImage(
                    "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimages.wallpapersden.com%2Fimage%2Fdownload%2Fthe-batman-official-poster_72699_1920x2400.jpg&f=1&nofb=1"),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 8),
          width: 160,
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: NetworkImage(
                    "https://www.themoviedb.org/t/p/original/wREIB9jx3qGg2ZLsOMgauOfAwTV.jpg"),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 8),
          width: 160,
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: NetworkImage(
                    "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fjanksreviews.com%2Fwp-content%2Fuploads%2F2016%2F12%2Fjohn_wick_chapter_two_poster.jpg&f=1&nofb=1"),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}

class search extends StatelessWidget {
  const search({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        onChanged: null,
        decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.search_rounded,
            color: textPrimeDark,
          ),
          hintText: 'Search',
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: bgSecondDark,
          focusColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
            color: textPrimeDark,
          ),
        ),
        style: TextStyle(
          fontSize: 14,
          color: textPrimeDark,
        ),
      ),
    );
  }
}
