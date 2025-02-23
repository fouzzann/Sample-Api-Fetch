import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_api_practice/service/api_service.dart';
import 'package:sample_api_practice/utils/them.dart';
import 'package:sample_api_practice/views/screens/api_home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emialController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Image(image: AssetImage('assets/login image.png')),
              ),
              TextFormField(
                controller: emialController,
                decoration: InputDecoration(
                    hintText: 'Enter Email',
                    prefixIcon: Icon(
                      Icons.person,
                      color: AppColors.primaryColor,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: AppColors.primaryColor, width: 2)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              SizedBox(
                height: 13,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: 'Enter Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: AppColors.primaryColor,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            color: AppColors.primaryColor, width: 2)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () async {
                  bool success = await ApiService.login(
                    emialController.text,
                    passwordController.text,
                  );

                  if (success) {
                    print("✅ Successfully Logged In!");
                    Get.to(()=>UserListScreen());
                  } else {  
                    print("❌ Login Failed!");
                  }
                },
                child: Container(
                  height: 45,
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: AppColors.backgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
