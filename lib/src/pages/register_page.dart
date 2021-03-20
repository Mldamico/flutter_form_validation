import 'package:flutter/material.dart';
import 'package:form_validation/src/bloc/login_bloc.dart';
import 'package:form_validation/src/bloc/provider.dart';
import 'package:form_validation/src/providers/usuario_provider.dart';

class RegisterPage extends StatelessWidget {
  final usuarioProvider = new UsuarioProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [_crearFondo(context), _loginForm(context)],
    ));
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(63, 63, 156, 1.0),
          Color.fromRGBO(90, 70, 178, 1.0)
        ]),
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );

    return Stack(
      children: [
        fondoMorado,
        Positioned(
          child: circulo,
          top: 90,
          left: 30,
        ),
        Positioned(
          child: circulo,
          top: -40,
          right: -30,
        ),
        Positioned(
          child: circulo,
          right: -10,
          bottom: -50,
        ),
        Positioned(
          child: circulo,
          bottom: 120,
          right: 20,
        ),
        Positioned(
          child: circulo,
          bottom: -50,
          left: -20,
        ),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              Icon(Icons.person_pin_circle, color: Colors.white, size: 100),
              SizedBox(
                height: 10,
                width: double.infinity,
              ),
              Text(
                'App Forms',
                style: (TextStyle(color: Colors.white, fontSize: 25)),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
              child: Container(
            height: 180,
          )),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0),
                ]),
            child: Column(
              children: [
                Text(
                  'Crear cuenta',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 60),
                _crearEmail(bloc),
                SizedBox(height: 30),
                _crearPassword(bloc),
                SizedBox(height: 30),
                _crearBoton(bloc)
              ],
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'login');
              },
              child: Text('Ya tienes cuenta? Login')),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
                hintText: 'Ejemplo@correo.com',
                labelText: 'Correo Electronico',
                errorText: snapshot.error),
            onChanged: (value) => bloc.changeEmail(value),
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
                labelText: 'Contraseña',
                errorText: snapshot.error),
            onChanged: (value) => bloc.changePassword(value),
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: 250, height: 40),
          child: ElevatedButton(
            onPressed: snapshot.hasData ? () => _register(bloc, context) : null,
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
            child: Text('Ingresar'),
          ),
        );
      },
    );
  }

  _register(LoginBloc bloc, BuildContext context) {
    print('=========');
    print('Email: ${bloc.email}');
    print('Password: ${bloc.password}');
    // Navigator.pushReplacementNamed(context, 'home');
    usuarioProvider.nuevoUsuario(bloc.email, bloc.password);
  }
}
