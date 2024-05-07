import 'package:chat/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _submit() {
    _formkey.currentState?.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              if (_formData.isSingup)
                TextFormField(
                  key: ValueKey('name'),
                  initialValue: _formData.name,
                  onChanged: (name) => _formData.name = name,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
              TextFormField(
                key: ValueKey('email'),
                initialValue: _formData.email,
                onChanged: (email) => _formData.email = email,
                decoration: const InputDecoration(labelText: 'E-mail'),
              ),
              TextFormField(
                key: ValueKey('password'),
                initialValue: _formData.password,
                onChanged: (password) => _formData.password = password,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                  onPressed: _submit,
                  child: _formData.isLogin
                      ? Text(
                          'Entrar :D',
                          style: TextStyle(color: Colors.white),
                        )
                      : Text(
                          'Cadastrar',
                          style: TextStyle(color: Colors.white),
                        ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.primary))),
              TextButton(
                onPressed: () {
                  setState(() {
                    _formData.toogleAuthMode();
                  });
                },
                child: _formData.isLogin
                    ? Text('Criar uma nova conta?')
                    : Text('Já possui conta?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
