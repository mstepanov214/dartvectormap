part of 'package:dartvectormap/models.dart';

class Marker with EquatableMixin implements JsObjectEncodable {
  String name;
  Point<double> coords;
  Point<double> offset;
  Map<String, dynamic> style;

  Marker({
    this.name = '',
    @required this.coords,
    this.offset,
    this.style,
  });

  factory Marker.fromJsObject(jsObject) {
    final markerMap = jsToMap(jsObject);

    final marker =
        // ignore: missing_required_param
        Marker(name: markerMap['name'], style: jsToMap(markerMap['style']));

    if (markerMap['coords'] != null) {
      marker.coords = Point(markerMap['coords'][0], markerMap['coords'][1]);
    }

    if (markerMap['offset'] != null) {
      marker.offset = Point(markerMap['offset'][0], markerMap['offset'][1]);
    }

    return marker;
  }

  @override
  dynamic toJsObject() {
    return jsify({
      'name': name,
      'coords': coords != null ? [coords.x, coords.y] : null,
      'offset': offset != null ? [offset.x, offset.y] : null,
      'syle': style
    }..removeWhere((key, value) => value == null));
  }

  @override
  List<Object> get props => [name, coords, offset];

  @override
  bool get stringify => true;
}
