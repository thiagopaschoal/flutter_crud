import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';

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
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
