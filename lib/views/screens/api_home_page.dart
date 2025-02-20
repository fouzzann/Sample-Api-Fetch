// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:sample_api_practice/model/api_model.dart';
import 'package:sample_api_practice/service/api_service.dart';
import 'package:sample_api_practice/utils/them.dart';

class UserListScreen extends StatefulWidget {
  UserListScreen({super.key});
  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<User>> userList;
  @override
  void initState() {
    super.initState();
    userList = ApiService.fetchUser();
  }
  @override
  void fetchUsers()async{
    setState(() {
      userList = ApiService.fetchUser();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.backgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed:fetchUsers ,
            icon: Icon(Icons.refresh_rounded),  
          ),
          Icon(Icons.menu),
          SizedBox(
            width: 15,
          )
        ],
        title: Text(
          'User List',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: FutureBuilder(
          future: userList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor,), 
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error : ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('No User Found'),
              );
            }

            final users = snapshot.data!;
            return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(
                    color: AppColors.cardColor,
                    elevation: 3,
                    margin: EdgeInsets.all(8),
                    child: SingleChildScrollView(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0), 
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor:AppColors.circleAvatharColor,
                              child: Text(
                                user.name[0].toUpperCase(),
                                style:
                                    TextStyle(color:AppColors.primaryColor, fontSize: 20),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start, 
                            children: [
                              SizedBox(height: 13),
                              Text(
                                user.name,
                                style: TextStyle(
                                    color: AppColors.primaryColor, 
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Email:${user.email}",
                                style: TextStyle(color: AppColors.subTitle),
                              ),
                              Text(
                                "Department:${user.department}",
                                style: TextStyle(color:AppColors.subTitle),
                              ),
                              SizedBox(
                                height: 13,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
