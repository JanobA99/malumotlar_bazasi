import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './main.dart';

class EditData extends StatefulWidget {
  final List<MyClass> words;
  final int index;

  EditData({ this.index, this.words});

  @override
  _EditDataState createState() => new _EditDataState();
}

class _EditDataState extends State<EditData> {
  bool _validate = false;
  bool _validate2 = false;
  TextEditingController controllerPrise;
  TextEditingController controllerName;



  void editData() async {
    var url="https://shaggiest-steeples.000webhostapp.com/upgrade.php";
   await http.post(url,body: {
      "id": "${widget.words[widget.index].id}",
      "post_body": "${controllerPrise.text}",
      "post_header": "${controllerName.text}",

    });
   print('update ${widget.words[widget.index].id} ${controllerPrise.text} ${controllerName.text}');
    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (BuildContext context)=>new Home()
        )
    );
  }


  @override
    void initState() {
      controllerPrise= new TextEditingController(text: "${widget.words[widget.index].word1}" );
      controllerName= new TextEditingController(text: "${widget.words[widget.index].word2}");
      super.initState();
    }

    @override
  void dispose() {
    controllerName.dispose();
    controllerPrise.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Ma'lumotlarni o'zgartirish"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: controllerName,
                  decoration: new InputDecoration(
                      hintText: "Nomini kiriting", labelText: "Nomini kiriting",
                    errorText: _validate ? 'Bo\'sh bo\'lishi mumkin emas biron nima kiriting' : null,),
                ),
                new TextField(
                  keyboardType: TextInputType.number,
                  controller: controllerPrise,
                  decoration: new InputDecoration(
                      hintText: "Narxini kiriting", labelText: "Narxini kiriting",
                    errorText: _validate2 ? 'Bo\'sh bo\'lishi mumkin emas biron nima kiriting' : null,),
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("EDIT DATA"),
                  color: Colors.blueAccent,
                  onPressed: () {
                      setState(() {
                        controllerPrise.text.isEmpty ?   _validate2=true : _validate2=false;
                        controllerName.text.isEmpty ? _validate = true : _validate=false;
                      });
                    if(controllerPrise.text.isNotEmpty && controllerName.text.isNotEmpty){
                      editData();
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
