import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_register/dashboard.dart';

class EditData extends StatefulWidget {
  final Map listData;
  const EditData({super.key, required this.listData});

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final formkey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

 Future _editdata () async {
    final response = await http.post(
      Uri.parse("http://192.168.1.9/loginregister/edit.php"),
      body: {
        "id" : id.text,
        "name" : name.text,
        "email" : email.text,
        "password" : password.text,
      }
    );
    if (response.statusCode == 200) {
      return true;
    } return false;
  }

  @override
  Widget build(BuildContext context) {
    id.text=widget.listData['id'];
    name.text=widget.listData['name'];
    email.text=widget.listData['email'];
    password.text=widget.listData['password'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit User"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "name harus diisi";
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "email harus diisi";
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: password,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "password harus diisi";
                }
                return null;
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(onPressed: () {
              if (formkey.currentState!.validate()) {
                _editdata().then((value) {
                  if (value) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data Berhasil Diubah'),));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data Gagal Diubah'),));
                  }
                });
                Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(
                    builder: (context) {
                      return Dashboard();
                    }
                    ), (route) => false);
              }
            },
            child: Text("Update", style: TextStyle(color: Colors.white),),
            style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    minimumSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width, 50.0),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
            )
          ],
        ),
      )),
    );
  }
}