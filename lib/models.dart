import 'dart:html';
import 'dart:js_util';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'src/helpers/js.dart';

part 'src/models/marker.dart';
part 'src/models/style_set.dart';
part 'src/models/focus.dart';

abstract class JsObjectEncodable {
  dynamic toJsObject();
}
