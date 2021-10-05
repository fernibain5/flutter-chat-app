import 'package:chat/models/user.dart';
import 'package:chat/pages/login_page.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPage extends StatefulWidget {
  static const routeName = 'users-page';

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final users = [
    User(online: true, email: 'test1@test.com', uid: '1', nombre: 'Fernando'),
    User(online: true, email: 'test2@test.com', uid: '2', nombre: 'Arturo'),
    User(online: false, email: 'test3@test.com', uid: '3', nombre: 'Jose'),
  ];
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    final user = authServices.user!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          user.nombre,
          style: TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black54,
          onPressed: () {
            //TODO: Desconectar del sockets server
            Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
            AuthServices.deleteToken();
          },
          icon: Icon(Icons.exit_to_app),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.check_circle,
              color: Colors.blue[400],
            ),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: () => _loadUsers(),
        header: WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: Colors.blue[400],
          ),
          waterDropColor: Colors.blue[400]!,
        ),
        child: _listViewUsers(),
      ),
    );
  }

  _loadUsers() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  ListView _listViewUsers() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _UserListTile(user: users[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: users.length,
    );
  }
}

class _UserListTile extends StatelessWidget {
  const _UserListTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.nombre),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(user.nombre.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: user.online ? Colors.green[300] : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
