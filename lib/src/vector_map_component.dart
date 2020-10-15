import 'dart:async';
import 'dart:html';
import 'dart:js';

import 'package:angular/angular.dart';
import 'package:dartvectormap/models.dart';
import 'package:js/js.dart';

import 'events.dart';
import 'helpers/debouncer.dart';
import 'jsvectormap_interop.dart';

/// Dart Angular implementation of https://github.com/themustafaomar/jsvectormap
@Component(
  selector: 'vector-map',
  template: '',
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class VectorMap implements AfterViewInit, AfterChanges {
  final HtmlElement _element;

  VectorMap(this._element);

  static const containerId = 'map_container';

  final _config = VectorMapConfig(selector: '#$containerId');

  /// Debouncer for vector map redrawing
  final _debouncer = Debouncer(Duration(milliseconds: 200));

  /// Map instance
  JsMap _vectorMap;

  /// Displayed region/marker tooltip
  HtmlElement _tooltip;

  @override
  void ngAfterViewInit() {
    _initCallbacks();
    _createVectorMap();
  }

  @override
  void ngAfterChanges() {
    if (_vectorMap != null) {
      _debouncer.run(_createVectorMap);
    }
  }

  void _createVectorMap() {
    document.querySelector(_config.selector)?.remove();
    _tooltip?.remove();

    final mapContainer = DivElement()
      ..id = containerId
      ..style.cssText = _element.style.cssText;

    _element.append(mapContainer);
    // _vectorMap = JsVectorMap(_config).mapData;
    JsVectorMap(_config);
    _tooltip = document.querySelector('.jsvmap-tooltip');
  }

  void _initCallbacks() {
    _config.onLoaded = allowInterop((map) {
      _vectorMap = map;
      _onLoaded.add(null);
    });

    _config.onRegionTooltipShow = allowInterop((tooltip, code) =>
        _onRegionTooltipShow.add(RegionTooltipEvent(_tooltip, code)));

    _config.onMarkerTooltipShow = allowInterop((tooltip, index) =>
        _onMarkerTooltipShow
            .add(MarkerTooltipEvent(_tooltip, int.parse(index))));

    _config.onRegionSelected = allowInterop(
        (code, isSelected, selectedRegions) => _onRegionSelected.add(
            RegionSelectEvent(
                code, isSelected, selectedRegions.cast<String>())));

    _config.onMarkerSelected =
        allowInterop((index, isSelected, selectedMarkersIndexes) {
      var selectedMarkers = selectedMarkersIndexes
          .map((index) => markers[int.parse(index)])
          .toList();
      _onMarkerSelected.add(MarkerSelectEvent(
          markers[int.parse(index)], isSelected, selectedMarkers));
    });

    _config.onViewportChange = allowInterop((scale, transX, transY) =>
        _onViewportChange.add(ViewportChangeEvent(scale, transX, transY)));
  }

  String get map => _config.map;
  @Input()
  set map(String v) {
    _config.map = v;
  }

  String get backgroundColor => _config.backgroundColor;
  @Input()
  set backgroundColor(String v) {
    _config.backgroundColor = v;
  }

  bool get draggable => _config.draggable;
  @Input()
  set draggable(bool v) {
    _config.draggable = v;
  }

  bool get zoomButtons => _config.zoomButtons;
  @Input()
  set zoomButtons(bool v) {
    _config.zoomButtons = v;
  }

  bool get zoomOnScroll => _config.zoomOnScroll;
  @Input()
  set zoomOnScroll(bool v) {
    _config.zoomOnScroll = v;
  }

  int get zoomScrollSpeed => _config.zoomScrollSpeed;
  @Input()
  set zoomScrollSpeed(int v) {
    _config.zoomScrollSpeed = v;
  }

  int get zoomMax => _config.zoomMax;
  @Input()
  set zoomMax(int v) {
    _config.zoomMax = v;
  }

  int get zoomMin => _config.zoomMin;
  @Input()
  set zoomMin(int v) {
    _config.zoomMin = v;
  }

  bool get zoomAnimate => _config.zoomAnimate;
  @Input()
  set zoomAnimate(bool v) {
    _config.zoomAnimate = v;
  }

  double get zoomStep => _config.zoomStep;
  @Input()
  set zoomStep(double v) {
    _config.zoomStep = v;
  }

  bool get bindTouchEvents => _config.bindTouchEvents;
  @Input()
  set bindTouchEvents(bool v) {
    _config.bindTouchEvents = v;
  }

  List<String> get selectedRegions => _config.selectedRegions;
  @Input()
  set selectedRegions(List<String> regions) {
    _config.selectedRegions =
        regions.map((code) => code.toUpperCase()).toList();
  }

  bool get regionsSelectable => _config.regionsSelectable;
  @Input()
  set regionsSelectable(bool v) {
    _config.regionsSelectable = v;
  }

  bool get regionSelectableOne => _config.regionSelectableOne;
  @Input()
  set regionSelectableOne(bool v) {
    _config.regionsSelectable = v;
  }

  VectorMapStyleSet get regionStyle =>
      VectorMapStyleSet.fromJsObject(_config.regionStyle);
  @Input()
  set regionStyle(VectorMapStyleSet style) {
    _config.regionStyle = style.toJsObject();
  }

  VectorMapStyleSet get regionLabelStyle =>
      VectorMapStyleSet.fromJsObject(_config.regionLabelStyle);
  @Input()
  set regionLabelStyle(VectorMapStyleSet style) {
    _config.regionLabelStyle = style.toJsObject();
  }

  List<Marker> get markers =>
      _config.markers.map((marker) => Marker.fromJsObject(marker)).toList();
  @Input()
  set markers(List<Marker> markers) {
    _config.markers = markers.map((marker) => marker.toJsObject()).toList();
  }

  VectorMapStyleSet get markerStyle =>
      VectorMapStyleSet.fromJsObject(_config.markerStyle);
  @Input()
  set markerStyle(VectorMapStyleSet style) {
    _config.markerStyle = style.toJsObject();
  }

  VectorMapStyleSet get markerLabelStyle =>
      VectorMapStyleSet.fromJsObject(_config.markerLabelStyle);
  @Input()
  set markerLabelStyle(VectorMapStyleSet style) {
    _config.markerLabelStyle = style.toJsObject();
  }

  bool get markersSelectable => _config.markersSelectable;
  @Input()
  set markersSelectable(bool v) {
    _config.markersSelectable = v;
  }

  bool get markerSelectableOne => _config.markerSelectableOne;
  @Input()
  set markerSelectableOne(bool v) {
    _config.markerSelectableOne = v;
  }

  Focus get focusOn => Focus.fromJsObject(_config.focusOn);
  @Input()
  set focusOn(Focus focus) {
    _config.focusOn = focus.toJsObject();
  }

  @Output()
  Stream<Null> get onLoaded => _onLoaded.stream;
  final _onLoaded = StreamController<Null>();

  @Output()
  Stream<RegionTooltipEvent> get onRegionTooltipShow =>
      _onRegionTooltipShow.stream;
  final _onRegionTooltipShow = StreamController<RegionTooltipEvent>();

  @Output()
  Stream<MarkerTooltipEvent> get onMarkerTooltipShow =>
      _onMarkerTooltipShow.stream;
  final _onMarkerTooltipShow = StreamController<MarkerTooltipEvent>();

  @Output()
  Stream<RegionSelectEvent> get onRegionSelected => _onRegionSelected.stream;
  final _onRegionSelected = StreamController<RegionSelectEvent>();

  @Output()
  Stream<MarkerSelectEvent> get onMarkerSelected => _onMarkerSelected.stream;
  final _onMarkerSelected = StreamController<MarkerSelectEvent>();

  @Output()
  Stream<ViewportChangeEvent> get onViewportChange => _onViewportChange.stream;
  final _onViewportChange = StreamController<ViewportChangeEvent>();

  void clearSelectedMarkers() => _vectorMap.clearSelectedMarkers();

  void clearSelectedRegions() => _vectorMap.clearSelectedRegions();

  void reset() => _vectorMap.reset();
}
