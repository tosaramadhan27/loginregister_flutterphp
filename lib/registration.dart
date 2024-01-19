import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_register/dashboard.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formkey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

 Future _register () async {
    final response = await http.post(
      Uri.parse("http://192.168.1.9/loginregister/register.php"),
      body: {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
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
                  return "Name harus diisi";
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
                  return "Email harus diisi";
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: password,
              obscureText: true,
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
                _register().then((value) {
                  if (value) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration Succesfully'),));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration Failed'),));

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
            child: Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
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