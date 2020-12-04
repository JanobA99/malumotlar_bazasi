import 'package:flutter/material.dart';
import './editdata.dart';
import 'package:http/http.dart' as http;
import './main.dart';

// ignore: must_be_immutable
class Detail extends StatefulWidget {
  final List<MyClass> words;
  int index;
  Detail({this.index, this.words,});
  @override
  _DetailState createState() => new _DetailState();
}

class _DetailState extends State<Detail> {

void deleteData() async{
  var url="https://shaggiest-steeples.000webhostapp.com/delete.php";
 await http.post(url, body: {
    'id': "${widget.words[widget.index].id}",
  });
  Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (BuildContext context)=> new Home(),
      )
  );
}

void confirm (){
  AlertDialog alertDialog = new AlertDialog(
    content: new Text("'${widget.words[widget.index].word2}' O'chirilsinmi? "),
    actions: <Widget>[
      new RaisedButton(
        child: new Text("Ha O'chirilsin!",style: new TextStyle(color: Colors.black),),
        color: Colors.red,
        onPressed: (){
          deleteData();
        },
      ),
      new RaisedButton(
        child: new Text("Bekor qilish",style: new TextStyle(color: Colors.black)),
        color: Colors.green,
        onPressed: ()=> Navigator.pop(context),
      ),
    ],
  );

  showDialog(context: context, child: alertDialog);
}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("${widget.words[widget.index].word2}")),
      body: new Container(
        height: 270.0, 
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Padding(padding: const EdgeInsets.only(top: 30.0),),
                new Text(widget.words[widget.index].word2, style: new TextStyle(fontSize: 20.0),),
                new Text("Narxi : ${widget.words[widget.index].word1}", style: new TextStyle(fontSize: 18.0),),
                new Padding(padding: const EdgeInsets.only(top: 30.0),),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new RaisedButton(
                      child: new Text("O'zgartirish"),
                      color: Colors.green,
                      onPressed: ()=>Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context)=>new EditData(words: widget.words, index: widget.index,),
                        )
                      ),
                    ),
                    new RaisedButton(
                      child: new Text("O'chirish"),
                      color: Colors.red,
                      onPressed: ()=>confirm(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}