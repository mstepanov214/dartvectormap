part of 'package:dartvectormap/models.dart';

/// Target to focus on
///
/// * [target] - region code or list of region's codes
/// * [animate] - whether to animate focus
class Focus with EquatableMixin implements JsObjectEncodable {
  dynamic target;

  bool animate;

  Focus(this.target, {this.animate = false}) {
    if (target is! String && (target is! List<String> || target.isEmpty)) {
      throw ArgumentError.value(
          target, 'target', 'Must be String or not empty List<String>');
    }
  }

  factory Focus.fromJsObject(jsObject) {
    final focusMap = jsToMap(jsObject);
    return Focus(focusMap['target'], animate: focusMap['animate']);
  }

  @override
  dynamic toJsObject() {
    return jsify({
      'animate': animate,
      if (target is String) 'region': target.toUpperCase(),
      if (target is List<String>)
        'regions': target.map((code) => code.toUpperCase()),
    });
  }

  @override
  List<Object> get props => [target, animate];

  @override
  bool get stringify => true;
}
