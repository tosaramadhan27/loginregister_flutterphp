import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_register/edit_data.dart';
import 'package:login_register/login.dart';
import 'package:login_register/registration.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List _listdata = [];

  Future _getdata() async {
    try {
      final response =
          await http.get(Uri.parse("http://192.168.1.9/loginregister/read.php"));
      if (response.statusCode == 200) {
        print(response.body);
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _deletedata(String id) async {
    try {
      final response = await http
          .post(Uri.parse("http://192.168.1.9/loginregister/delete.php"), body: {
        "name": id,
      });
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    print(_listdata);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Dashboard", style: TextStyle(color: Colors.white, letterSpacing: 2),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) {
                return Login();
              })
            );
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: ListView.builder(
          itemCount: _listdata.length,
          itemBuilder: ((context, index) {
            return Card(
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return EditData(
                      listData: {
                        "id": _listdata[index]['id'],
                        "name": _listdata[index]['name'],
                        "email": _listdata[index]['email'],
                        "password": _listdata[index]['password'],
                      },
                    );
                  }));
                },
                child: ListTile(
                  title: Text(_listdata[index]['name']),
                  subtitle: Text(_listdata[index]['email']),
                  trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text("Hapus Data?"),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _deletedata(_listdata[index]['name'])
                                          .then((value) {
                                        if (value) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content:
                                                Text('Data Berhasil Dihapus'),
                                          ));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text('Data Gagal Dihapus'),
                                          ));
                                        }
                                      });
                                      Navigator.pushAndRemoveUntil(context,
                                          MaterialPageRoute(builder: (context) {
                                        return Dashboard();
                                      }), (route) => false);
                                    },
                                    child: Text("Hapus"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Cancel"),
                                  ),
                                ],
                              );
                            });
                      },
                      icon: Icon(Icons.delete)),
                ),
              ),
            );
          })),
          floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return Register();
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
