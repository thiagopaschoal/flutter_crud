import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final hasAvatar =
        this.user.avatarUrl == null || this.user.avatarUrl.isEmpty;

    final avatar = hasAvatar
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(this.user.avatarUrl));

    return ListTile(
      leading: avatar,
      title: Text(this.user.name),
      subtitle: Text(this.user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.orange,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                  arguments: user,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text("Excluir Usuário"),
                          content: Text("Tem certeza?"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("Sim"),
                              onPressed: () => Navigator.of(context).pop(true),
                            ),
                            FlatButton(
                              child: Text("Não"),
                              onPressed: () => Navigator.of(context).pop(false),
                            ),
                          ],
                        )).then((isOk) => {
                      if (isOk)
                        {
                          Provider.of<UsersProvider>(context, listen: false)
                              .remove(user)
                        }
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
