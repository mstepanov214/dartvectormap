part of 'package:dartvectormap/models.dart';

/// Style set for different states
///
/// Applicable to:
/// * marker
/// * marker label
/// * region
/// * region label
class VectorMapStyleSet with EquatableMixin implements JsObjectEncodable {
  Map<String, dynamic> initial;
  Map<String, dynamic> hover;
  Map<String, dynamic> selected;
  Map<String, dynamic> selectedHover;

  VectorMapStyleSet(
      {this.initial, this.hover, this.selected, this.selectedHover});

  factory VectorMapStyleSet.fromJsObject(jsObject) {
    final styleMap = jsToMap(jsObject);

    return VectorMapStyleSet(
        initial: jsToMap(styleMap['initial']),
        hover: jsToMap(styleMap['hover']),
        selected: jsToMap(styleMap['selected']),
        selectedHover: jsToMap(styleMap['selectedHover']));
  }

  @override
  dynamic toJsObject() {
    return jsify({
      'initial': initial,
      'hover': hover,
      'selected': selected,
      'selectedHover': selectedHover
    }..removeWhere((key, value) => value == null));
  }

  @override
  List<Object> get props => [initial, hover, selected, selectedHover];

  @override
  bool get stringify => true;
}
