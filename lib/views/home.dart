// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:crud_flutter/models/post.dart';
import 'package:crud_flutter/services/remote_service.dart';
import 'package:crud_flutter/views/add.dart';
import 'package:crud_flutter/views/detail.dart';
import 'package:crud_flutter/views/edit.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Note>? notes;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    notes = await RemoteService().getPosts();
    if (notes != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: notes?.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: SingleChildScrollView(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detail(
                          notes: notes![index],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(
                          30,
                        ),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Title : ",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                notes![index].title,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Description : ",
                                style: TextStyle(fontSize: 20),
                              ),
                              Flexible(
                                flex: 1,
                                child: Text(
                                  notes![index].description,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Add(),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
    );
  }
}
