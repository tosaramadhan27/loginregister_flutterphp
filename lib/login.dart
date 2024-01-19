import 'package:flutter/material.dart';
import 'package:login_register/dashboard.dart';
import 'package:login_register/registration.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future _login () async {
    final response = await http.post(
      Uri.parse("http://192.168.1.9/loginregister/login.php"),
      body: {
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
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Login",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Form(
        key: formkey,
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return Register();
                      })
                    );
                  },
                  child: Text("Register!")
                  ),
                ],
              ),
                  
              SizedBox(height: 40),
              ElevatedButton(onPressed: () {
                  if (formkey.currentState!.validate()) {
                    _login().then((value) {
                      if (value) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Succesfully'),));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Failed'),));
          
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
                  'Login',
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
        ),
      ),
    );
  }
}