import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:market_peace/constants.dart';
import 'package:market_peace/data/auth_manager.dart';
import 'package:market_peace/widgets/custom_formfield.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final _mailController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: distinctiveColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildBackground(),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: buildBody(context),
          ),
        ],
      ),
    );
  }

  buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Inscription",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: 600,
            width: 300,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomFormField(
                    controller: _usernameController,
                    formType: "Pseudo",
                  ),
                  CustomFormField(
                    controller: _nameController,
                    formType: "Nom",
                    isRequired: false,
                  ),
                  CustomFormField(
                    controller: _surnameController,
                    formType: "Prénom",
                    isRequired: false,
                  ),
                  CustomFormField(
                    controller: _mailController,
                    formType: "Adresse mail",
                  ),
                  CustomFormField(
                    controller: _passwordController,
                    formType: "Mot de passe",
                    obscureText: true,
                  ),
                  CustomFormField(
                    controller: _confirmPasswordController,
                    formType: "Confirmer le mot de passe",
                    obscureText: true,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        registerUser(context);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 45),
                      decoration: BoxDecoration(
                        color: distinctiveColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Text(
                        "S'inscrire",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: darkAccentuation,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> registerUser(BuildContext context) async {
    AuthManager.signup(
      username: _usernameController.text,
      password: _passwordController.text,
      mailAddress: _mailController.text,
      name: _nameController.text,
      surname: _surnameController.text,
    ).then((signUpResult) {
      if (signUpResult) {
        context.router.pushNamed('/');
        showNotification(context, "Felicitation !", "Vous êtes désormais inscrit !");
      }
    }).catchError((error) {
      showNotification(context, "Erreur d'inscription", error.cause.toString());
    });
  }

  Future<dynamic> showNotification(BuildContext context, String title, String message) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => context.router.pop(),
              child: const Text("D'accord"),
            )
          ],
        );
      },
    );
  }

  buildBackground() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        decoration: const BoxDecoration(
          color: lightAccentuation,
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(50),
            bottomEnd: Radius.circular(50),
          ),
        ),
        height: 400,
        width: double.infinity,
      ),
    );
  }
}
