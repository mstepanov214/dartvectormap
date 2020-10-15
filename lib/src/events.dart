import 'dart:html';

import 'package:dartvectormap/models.dart';

abstract class VectorMapEvent {}

class RegionTooltipEvent extends VectorMapEvent {
  RegionTooltipEvent(this.tooltip, this.code);

  final HtmlElement tooltip;
  final String code;
}

class MarkerTooltipEvent extends VectorMapEvent {
  MarkerTooltipEvent(this.tooltip, this.index);

  final HtmlElement tooltip;
  final int index;
}

class RegionSelectEvent extends VectorMapEvent {
  RegionSelectEvent(this.code, this.isSelected, this.selectedRegions);

  final String code;
  final bool isSelected;
  List<String> selectedRegions;
}

class MarkerSelectEvent extends VectorMapEvent {
  MarkerSelectEvent(this.marker, this.isSelected, this.selectedMarkers);

  final Marker marker;
  final bool isSelected;
  List<Marker> selectedMarkers;
}

class ViewportChangeEvent extends VectorMapEvent {
  ViewportChangeEvent(this.scale, this.transX, this.transY);

  final double scale;
  final double transX;
  final double transY;
}
