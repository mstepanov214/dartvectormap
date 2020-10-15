@JS()
library jsvectormap;

import 'package:js/js.dart';

@anonymous
@JS('Map')
class JsMap {
  external JsMap(VectorMapConfig options);

  external int get height;
  external int get width;
  external int get scale;
  external int get transX;
  external int get transY;

  external void clearSelectedMarkers();
  external void clearSelectedRegions();
  external void reset();
}

@JS('JsVectorMap')
class JsVectorMap {
  external JsVectorMap(VectorMapConfig options);
  external void addMap(String name, JsMap map);

  external JsMap get mapData;
}

@JS()
@anonymous
class VectorMapConfig {
  external String get selector;
  external set selector(String v);

  external String get map;
  external set map(String v);

  external String get backgroundColor;
  external set backgroundColor(String v);

  external bool get draggable;
  external set draggable(bool v);

  external bool get zoomButtons;
  external set zoomButtons(bool v);

  external bool get zoomOnScroll;
  external set zoomOnScroll(bool v);

  external int get zoomScrollSpeed;
  external set zoomScrollSpeed(int v);

  external int get zoomMax;
  external set zoomMax(int v);

  external int get zoomMin;
  external set zoomMin(int v);

  external bool get zoomAnimate;
  external set zoomAnimate(bool v);

  external double get zoomStep;
  external set zoomStep(double v);

  external bool get bindTouchEvents;
  external set bindTouchEvents(bool v);

  external List<Object> get markers;
  external set markers(List<Object> v);

  external Object get markerStyle;
  external set markerStyle(Object v);

  external Object get markerLabelStyle;
  external set markerLabelStyle(Object v);

  external bool get markersSelectable;
  external set markersSelectable(bool v);

  external bool get markerSelectableOne;
  external set markerSelectableOne(bool v);

  external List<String> get selectedRegions;
  external set selectedRegions(List<String> v);

  external bool get regionsSelectable;
  external set regionsSelectable(bool v);

  external bool get regionSelectableOne;
  external set regionSelectableOne(bool v);

  external Object get regionStyle;
  external set regionStyle(Object v);

  external Object get regionLabelStyle;
  external set regionLabelStyle(Object v);

  external Object get focusOn;
  external set focusOn(Object v);

  external void Function(JsMap) get onLoaded;
  external set onLoaded(void Function(JsMap) f);

  external void Function(Object, String) get onRegionTooltipShow;
  external set onRegionTooltipShow(void Function(Object, String) f);

  external void Function(Object, String) get onMarkerTooltipShow;
  external set onMarkerTooltipShow(void Function(Object, String) f);

  external void Function(double, double, double) get onViewportChange;
  external set onViewportChange(void Function(double, double, double) f);

  external void Function(String, bool, List) get onRegionSelected;
  external set onRegionSelected(void Function(String, bool, List) f);

  external void Function(String, bool, List) get onMarkerSelected;
  external set onMarkerSelected(void Function(String, bool, List) f);

  external factory VectorMapConfig({
    String selector,
    String map,
    String backgroundColor,
    bool draggable,
    bool zoomButtons,
    bool zoomOnScroll,
    int zoomScrollSpeed,
    int zoomMax,
    int zoomMin,
    bool zoomAnimate,
    double zoomStep,
    bool bindTouchEvents,
    List<Object> markers,
    bool markersSelectable,
    bool markerSelectableOne,
    Object markerStyle,
    List<String> selectedRegions,
    bool regionsSelectable,
    bool regionSelectableOne,
    Object regionStyle,
    Object regionLabelStyle,
    Object focusOn,
    void Function(JsMap) onLoaded,
    void Function(Object, String) onRegionTooltipShow,
    void Function(Object, String) onRegionMarkerShow,
    void Function(double, double, double) onViewPortChange,
    void Function(String, bool, List) onRegionSelected,
    void Function(String, bool, List) onMarkerSelected,
  });
}
