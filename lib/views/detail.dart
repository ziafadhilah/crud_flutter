// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:crud_flutter/models/post.dart';
import 'package:crud_flutter/views/edit.dart';
import 'package:crud_flutter/views/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {
  final Note notes;
  const Detail({Key? key, required this.notes}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    void deleteNotes() async {
      await http.delete(
        Uri.parse("http://192.168.1.10:8000/api/note/${widget.notes.id}"),
      );
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => Home(),
          ),
          (Route<dynamic> route) => false);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 32),
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.notes.title),
                      SizedBox(
                        height: 10,
                      ),
                      Text(widget.notes.description),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                // height: 455 ,
                width: MediaQuery.of(context).size.width,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Edit(
                          notes: widget.notes,
                        ),
                      ),
                    );
                  },
                  child: Icon(Icons.edit),
                ),
                TextButton(
                  onPressed: () {
                    deleteNotes();
                  },
                  child: Icon(Icons.delete),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
