import 'package:flutter/foundation.dart';
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
  GetStorage box = GetStorage();
  TextEditingController addressController =
      TextEditingController(text: GetStorage().read('address'));
  TextEditingController passwordController = TextEditingController();

  void _login() async {
    final res = await Get.find<MotorFlutter>().login(
        password: passwordController.text,
        address: addressController.text,
        pskKey: GetStorage().read('passwordSecuredKey').cast<int>(),
        dscKey: GetStorage().read('deviceSharedKey').cast<int>());
    if (res != null) {
      if (Get.find<MotorFlutter>().authorized.isTrue) {
        Get.snackbar("Success", "Login successful");
        Get.offAll(() => const MyHomePage(title: 'Flutter Demo Home Page'));
      } else {
        Get.snackbar('Error', 'Login failed');
      }
    } else {
      Get.snackbar("Login", "Login failed");
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
                    labelText: 'SNR Address',
                    hintText:
                        'Enter valid Address as snr1ioiaksldjfenkjaof29oi...'),
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
              margin: const EdgeInsets.only(top: 20),
              child: ContinueOnSonrButton(
                onSuccess: (ai) {
                  if (ai == null) {
                    throw Exception("AuthInfo is null");
                  }
                  debugPrint("Address: ${ai.address}");
                  debugPrint("deviceSharedKey: ${ai.aesDscKey}");
                  debugPrint("passwordSecuredKey: ${ai.aesPskKey}");

                  GetStorage().write("address", ai.address);
                  GetStorage().write("deviceSharedKey", ai.aesDscKey);
                  GetStorage().write("passwordSecuredKey", ai.aesPskKey);
                },
                onError: (err) {
                  Get.snackbar("Error", err.toString());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

void debugPrint(Object? message) {
  if (kDebugMode) {
    print(message);
  }
}
