import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:motor_flutter/motor_flutter.dart';
import 'package:todo_app/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController addressController =
      TextEditingController(text: Get.find<MotorFlutter>().didUrl.toString());
  TextEditingController passwordController = TextEditingController();

  void _login() async {
    print("logging in");
    final res = await Get.find<MotorFlutter>()
        .login(password: passwordController.text, did: addressController.text);
    if (res != null) {
      print(res);
    } else {
      print('Login failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    padding: const EdgeInsets.all(25),
                    child: const Text("Please Login",
                        style: TextStyle(fontSize: 20))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: addressController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'SNR DID Address',
                    hintText: 'Enter valid DID as did:snr:aksldjfenkjaof29oi'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
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
              height: 50,
              width: 250,
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () => _login(),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            Container(
              height: 50,
              width: 200,
              margin: const EdgeInsets.only(top: 20),
              child: MaterialButton(
                color: Colors.white,
                child: const Text('Register Account'),
                // --
                // 2. Add the RegisterAccount ModalView on tap
                // --
                onPressed: () async {
                  Get.put(RegisterController());
                  final res =
                      await MotorFlutter.to.showRegisterModal(onError: (err) {
                    Get.snackbar("Error", err.toString());
                  });
                  if (res != null) {
                    // Store the address in the controller???
                    Get.offAll(() => const LoginPage(title: "Login"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
