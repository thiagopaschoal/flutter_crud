import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class UserForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    this._formData["id"] = user.id;
    this._formData["name"] = user.name;
    this._formData["email"] = user.email;
    this._formData["url"] = user.email;
  }

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;

    if (user != null) {
      _loadFormData(user);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Usuário"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              bool isValid = this._formKey.currentState.validate();
              if (isValid) {
                this._formKey.currentState.save();

                Provider.of<UsersProvider>(context, listen: false).add(User(
                    avatarUrl: this._formData["url"],
                    email: this._formData["email"],
                    name: this._formData["name"],
                    id: this._formData["id"]));

                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                initialValue: this._formData["name"],
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome inválido!!';
                  }

                  if (value.trim().length < 3) {
                    return 'Nome muito pequeno. No mínimo 3 letras!!';
                  }

                  return null;
                },
                onSaved: (value) {
                  this._formData["name"] = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                ),
                initialValue: this._formData["email"],
                onSaved: (value) {
                  this._formData["email"] = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'URL do Avatar',
                ),
                initialValue: this._formData["url"],
                onSaved: (value) {
                  this._formData["url"] = value;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
