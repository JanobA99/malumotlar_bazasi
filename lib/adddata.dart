import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => new _AddDataState();
}

class _AddDataState extends State<AddData> {

  bool _validate = false;
  bool _validate2 = false;
TextEditingController controllerCode = new TextEditingController();
TextEditingController controllerName = new TextEditingController();


Future<void> addData() async {
  var url="https://shaggiest-steeples.000webhostapp.com/add.php";

 await http.post(url, body: {
    "post_header": controllerCode.text,
    "post_body": controllerName.text,
  });
  Navigator.of(context).pop();
}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Dori qo'shish"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: controllerCode,
                  decoration: new InputDecoration(
                      hintText: "Dori nomi kiriting", labelText: "Dori nomi kiriting",
                    errorText: _validate2 ? 'Bo\'sh bo\'lishi mumkin emas biron nima kiriting' : null,),
                ),
                new TextField(
                  controller: controllerName,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                      hintText: "Dori narxini kiriting", labelText: "Dori narxini kiriting",
                    errorText: _validate ? 'Bo\'sh bo\'lishi mumkin emas biron nima kiriting' : null,),
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("Qo'shish"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    setState(() {
                      controllerCode.text.isEmpty ?   _validate2=true : _validate2=false;
                      controllerName.text.isEmpty ? _validate = true : _validate=false;
                    });
                    if(controllerCode.text.isNotEmpty && controllerName.text.isNotEmpty){
                      addData();
                    }

                    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Home()));
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
