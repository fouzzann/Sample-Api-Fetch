import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_api_practice/model/api_model.dart';
import 'package:sample_api_practice/service/api_service.dart';
import 'package:sample_api_practice/utils/them.dart';
import 'package:sample_api_practice/views/screens/login_page.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<User>> userList;
  @override
  void initState() {
    userList = ApiService.fetchUser();
    super.initState();
  }

  void refreshData() {
    setState(() {
      userList = ApiService.fetchUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(backgroundColor: AppColors.backgroundColor,
        actions: [
          IconButton(
              onPressed: () {
                refreshData();
              },
              icon: Icon(Icons.refresh)),
          IconButton(
              onPressed: () {
                Get.to(() => LoginPage());
              },
              icon: Icon(Icons.logout))
        ],
        title: Text(
          'User list',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
          future: userList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("ERROR : ${snapshot.error}"),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('No data found'),
              );
            }

            final users = snapshot.data!;
            return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(color: AppColors.backgroundColor,
                    margin: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: AppColors.circleAvatharColor,
                            radius: 24,
                            child: Text(
                              user.name[0].toUpperCase(),
                              style: TextStyle(
                                  fontSize: 20, color: AppColors.primaryColor),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              user.name,
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 0,
                            ),
                            Text("Emial : ${user.email},",
                                style: TextStyle(
                                  color: AppColors.subTitle,
                                )),
                            Text("Department : ${user.department},",
                                style: TextStyle(
                                  color: AppColors.subTitle,
                                )),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
