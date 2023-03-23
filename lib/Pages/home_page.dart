import 'package:flutter/material.dart';
import 'package:flutter_restfulapi/Model/user_model.dart';
import 'package:flutter_restfulapi/Service/user_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Data>? users = [];
  final UserService _service = UserService();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _service.fetchUsers().then((value) {
      if (value != null && value.data != null) {
        setState(() {
          users = value.data;
          isLoading = true;
        });
      } else {
        isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Accounts')),
      ),
      body: isLoading == false
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: users?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    child: ListTile(
                      title: Text(users![index].firstName! + users![index].lastName!),
                      subtitle: Text(users![index].email!),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(users![index].avatar!),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
