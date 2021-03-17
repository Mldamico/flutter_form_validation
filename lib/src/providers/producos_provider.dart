import 'dart:convert';

import 'package:form_validation/src/models/producto_model.dart';
import 'package:http/http.dart' as http;

class ProductosProvider {
  final String _url = 'flutter-mix-f976c-default-rtdb.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto) async {
    final uri = Uri.https(_url, '/productos.json');
    final resp = await http.post(uri, body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);

    print(decodedData);
    return true;
  }
}
