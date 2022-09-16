import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:motor_flutter/motor_flutter.dart';
import 'package:todo_app/login_page.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key, this.title = "Create Account"});

  final String title;

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController passwordController = TextEditingController();

  void _handleCreateAccountResponse(CreateAccountResponse? response) {
    if (response != null) {
      print(response);
      // GetStorage box = GetStorage();
      // box.write('aesDsc', response.aesDsc);
      // box.write('aesPsk', response.aesPsk);
      // box.write('address', response.address);
      print(response.whoIs);
      Get.off(const LoginPage(title: "Login here"));
    }
  }

  void _createAccount() async {
    setState(() {
      MotorFlutter motor = Get.find<MotorFlutter>();

      print(motor.createAccount(passwordController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    height: 150,
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 5, bottom: 0),
                    child: const Text("Let's get creative!",
                        style: TextStyle(fontSize: 20))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 7.0),
              child: Center(
                child: Container(
                    width: 200,
                    child: const Text("Please Enter a Password",
                        style: TextStyle(fontSize: 15))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 5, bottom: 0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your secure password'),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(25),
              child: ElevatedButton(
                onPressed: () {
                  _createAccount();
                },
                child: const Text("Create Account"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
