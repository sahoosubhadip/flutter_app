import 'package:flutter/material.dart';
import 'package:flutter_app/SqLite.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String _image;
  String title = '';
  String note = '';
  String creat_date = '01/12/2020';
  String updated_date = '01/12/2020';
  String created_by = '';
  String save_note = ' ';






  Future getImage(source) async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: source);
    print(image.path);

    //setState(() {});
  }



  Future<void> _showChoiceDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xff201F23),
            title: Text(
              "Make a choice",
              style: TextStyle(color: Colors.red),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10.0)),
                  ListTile(
                    leading: Icon(
                      Icons.camera_alt,
                      color: Colors.red,
                    ),
                    title: Text(
                      'Open Camera',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      getImage(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.photo_library,
                      color: Colors.red,
                    ),
                    title: Text(
                      'Select from gallery',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      getImage(ImageSource.gallery);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.insert_drive_file,
                      color: Colors.red,
                    ),
                    title: Text(
                      'Select File',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            actions: [
              FlatButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text("Add New Note".toUpperCase()),
          backgroundColor: Colors.orange,
          centerTitle: true,
          elevation: 5.0,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(children: <Widget>[
              Container(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.text_fields),
                  alignLabelWithHint: false,
                  hintStyle: TextStyle(fontSize: 14.0),
                  labelStyle: TextStyle(fontSize: 16.0),
                  hintText: 'Title of the note',
                  labelText: 'T I T L E',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
              ),
              Container(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.question_answer),
                  alignLabelWithHint: false,
                  hintStyle: TextStyle(fontSize: 14.0),
                  labelStyle: TextStyle(fontSize: 16.0),
                  hintText: 'Type Here . . .',
                  labelText: ' Note . . .',
//                  border: OutlineInputBorder(
//                    borderRadius: BorderRadius.circular(5.0),
//                    borderSide: BorderSide(),
//                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    note = value;
                  });
                },
              ),
              Container(
                height: 40,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: FlatButton.icon(
                  padding:
                      EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black)),
                  color: Colors.black12,
                  textColor: Colors.black,
                  icon: Icon(Icons.attachment),
                  label: Text("Attach File".toUpperCase()),
                  onPressed: () {
                    _showChoiceDialogue(context);
                  },
                  //tooltip: 'Pick Image',
                ),
              ),
              Container(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: FlatButton.icon(
                    padding: EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black)),
                    color: Colors.orange,
                    textColor: Colors.white,
                    icon: Icon(Icons.add_circle_outline),
                    label: Text("Save Note".toUpperCase()),
                    onPressed: _AddNote),
              )
            ])));
  }

  _AddNote() async {
    if (title == "") {
      Fluttertoast.showToast(
          msg: "Plese Enter The Title ",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    } else if (note == "") {
      Fluttertoast.showToast(
          msg: "Plese write Note",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    } else {
      try {
        var data = {
          'title': title,
          'note': note,
          'creatdate': creat_date,
          'updateddate': updated_date,
          'created_by': 'abc',
        };

        await SqLite().add_data("note", data);
        Navigator.pop(context);
      } catch (e) {
        print(e);
      }
    }
  }




}
