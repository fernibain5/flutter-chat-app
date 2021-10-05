import 'package:chat/helpers/showAlert.dart';
import 'package:chat/main.dart';
import 'package:chat/pages/register_page.dart';
import 'package:chat/pages/users_page.dart';
import 'package:chat/services/auth_service.dart';

import 'package:chat/widgets/CustomInput.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/blue_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static const routeName = 'logIn-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * .9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(
                    title: 'Messenger',
                  ),
                  _Form(),
                  Labels(
                    route: RegisterPage.routeName,
                    title: '¿No tienes cuenta?',
                    subtitle: 'Crear una cuenta ahora!',
                  ),
                  Text(
                    'Terminos y condiciones de uso',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outlined,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          BlueBtn(
            onPressedHandler: authServices.authenticating
                ? null
                : () async {
                    final loginOk = await authServices.login(
                        emailCtrl.text.trim(), passCtrl.text.trim());
                    FocusScope.of(context).unfocus();

                    if (loginOk) {
                      Navigator.of(context)
                          .pushReplacementNamed(UsersPage.routeName);
                    } else {
                      //Mostrar alerta
                      showAlert(context, 'Login Incorrecto',
                          'Revise sus credenciales');
                    }
                  },
            text: 'Ingrese',
          ),
        ],
      ),
    );
  }
}
