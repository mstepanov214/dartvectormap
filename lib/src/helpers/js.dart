@JS()
library dartvectormap.helpers.js;

import 'dart:js_util';

import 'package:js/js.dart';

Map<String, dynamic> jsToMap(jsObject) {
  if (jsObject == null) return null;

  return Map<String, dynamic>.fromIterable(
    getKeysOfObject(jsObject),
    value: (key) => getProperty(jsObject, key),
  );
}

@JS('Object.keys')
external List<String> getKeysOfObject(jsObject);
