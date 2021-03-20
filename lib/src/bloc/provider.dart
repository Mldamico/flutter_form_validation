import 'package:flutter/material.dart';
import 'package:form_validation/src/bloc/login_bloc.dart';
import 'package:form_validation/src/bloc/productos_bloc.dart';

class Provider extends InheritedWidget {
  static Provider _instancia;

  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;
  }
  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  final loginBloc = LoginBloc();
  final _productosBloc = ProductosBloc();

  // Provider({Key key, Widget child}) : super(key: key, child: child);

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  static ProductosBloc productosBloc(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<Provider>()
        ._productosBloc;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
