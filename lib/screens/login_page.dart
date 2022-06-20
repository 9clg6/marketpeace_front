import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:market_peace/constants.dart';
import 'package:market_peace/data/auth_manager.dart';
import 'package:market_peace/exception/authentication_exception.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Stack(
        children: [
          buildBackground(context),
          buildWhiteContainer(context),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: distinctiveColor,
      shadowColor: Colors.transparent,
      leading: InkWell(
        onTap: () => context.router.pop(),
        child: const Icon(
          Icons.arrow_back,
          color: darkAccentuation,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.router.pushNamed('/register-page'),
          child: const Text(
            "S'inscrire",
            style: TextStyle(
              color: darkAccentuation,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        )
      ],
    );
  }

  Container buildBackground(BuildContext context) {
    return Container(
      color: distinctiveColor,
      width: double.infinity,
      height: double.infinity,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
        height: MediaQuery.of(context).size.height / 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "MarketPeace",
              style: TextStyle(
                color: darkAccentuation,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Align buildWhiteContainer(BuildContext context) {
    final mailController = TextEditingController();
    final passwordController = TextEditingController();

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          vertical: 25,
          horizontal: 15,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(50),
            topEnd: Radius.circular(50),
          ),
        ),
        height: MediaQuery.of(context).size.height / 1.4,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            buildConnectionTitle(),
            Expanded(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildMailField(mailController),
                    const SizedBox(height: 15),
                    buildPasswordField(passwordController),
                    const SizedBox(height: 20),
                    buildConnectionBtn(formKey, mailController, passwordController, context)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Align buildConnectionTitle() {
    return const Align(
      alignment: Alignment.topCenter,
      child: Text(
        "Connexion",
        style: TextStyle(
          color: darkAccentuation,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Container buildMailField(TextEditingController mailController) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: beige,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextFormField(
        controller: mailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value == "") {
            return "Veuillez insérer une adresse mail";
          }
          return null;
        },
        decoration: const InputDecoration(
          label: Text(
            "Nom d'utilisateur",
            style: TextStyle(
              color: darkAccentuation,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Column buildPasswordField(TextEditingController passwordController) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: beige,
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextFormField(
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            validator: (value) {
              if (value == null || value == "") {
                return "Veuillez insérer un mot de passe";
              }
              return null;
            },
            decoration: const InputDecoration(
              label: Text(
                "Mot de passe ",
                style: TextStyle(
                  color: darkAccentuation,
                ),
              ),
              border: InputBorder.none,
            ),
            obscureText: true,
          ),
        ),
        buildForgotPasswordBtn(),
      ],
    );
  }

  Row buildForgotPasswordBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => null,
          child: const Text(
            "Mot de passe oublié ?",
            style: TextStyle(
              fontSize: 12,
              color: darkAccentuation,
            ),
          ),
        ),
      ],
    );
  }

  InkWell buildConnectionBtn(
    GlobalKey<FormState> formKey,
    TextEditingController mailController,
    TextEditingController passwordController,
    BuildContext context,
  ) {
    return InkWell(
      onTap: () {
        if (formKey.currentState!.validate()) {
          signInUser(mailController, passwordController, context);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 45),
        decoration: BoxDecoration(
          color: distinctiveColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Text(
          "Se connecter",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: darkAccentuation,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Future<void> signInUser(
    TextEditingController mailController,
    TextEditingController passwordController,
    BuildContext context,
  ) async {
    try {
      final signInResult = await AuthManager.signIn(username: mailController.text, password: passwordController.text);
      if(signInResult) context.router.replaceNamed('/');
    } on AuthenticationException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Erreur de connexion"),
            content: Text("Impossible de se connecter Error: ${e.cause}"),
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
  }
}
