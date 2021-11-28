class DistanceModel {
  List<GeocodedWaypoints> geocodedWaypoints;
  List<Routes> routes;
  String status;

  DistanceModel({this.geocodedWaypoints, this.routes, this.status});

  DistanceModel.fromJson(Map<String, dynamic> json) {
    if (json['geocoded_waypoints'] != null) {
      geocodedWaypoints = new List<GeocodedWaypoints>();
      json['geocoded_waypoints'].forEach((v) {
        geocodedWaypoints.add(new GeocodedWaypoints.fromJson(v));
      });
    }
    if (json['routes'] != null) {
      routes = new List<Routes>();
      json['routes'].forEach((v) {
        routes.add(new Routes.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.geocodedWaypoints != null) {
      data['geocoded_waypoints'] =
          this.geocodedWaypoints.map((v) => v.toJson()).toList();
    }
    if (this.routes != null) {
      data['routes'] = this.routes.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class GeocodedWaypoints {
  String geocoderStatus;
  String placeId;
  List<String> types;

  GeocodedWaypoints({this.geocoderStatus, this.placeId, this.types});

  GeocodedWaypoints.fromJson(Map<String, dynamic> json) {
    geocoderStatus = json['geocoder_status'];
    placeId = json['place_id'];
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['geocoder_status'] = this.geocoderStatus;
    data['place_id'] = this.placeId;
    data['types'] = this.types;
    return data;
  }
}

class Routes {
  Bounds bounds;
  String copyrights;
  List<Legs> legs;
  Polylines overviewPolyline;
  String summary;
  List<String> warnings;
  List<String> waypointOrder;

  Routes(
      {this.bounds,
      this.copyrights,
      this.legs,
      this.overviewPolyline,
      this.summary,
      this.warnings,
      this.waypointOrder});

  Routes.fromJson(Map<String, dynamic> json) {
    bounds =
        json['bounds'] != null ? new Bounds.fromJson(json['bounds']) : null;
    copyrights = json['copyrights'];
    if (json['legs'] != null) {
      legs = new List<Legs>();
      json['legs'].forEach((v) {
        legs.add(new Legs.fromJson(v));
      });
    }
    overviewPolyline = json['overview_polyline'] != null
        ? new Polylines.fromJson(json['overview_polyline'])
        : null;
    summary = json['summary'];
    warnings = json['warnings'].cast<String>();
    waypointOrder = json['waypoint_order'].cast<String>();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bounds != null) {
      data['bounds'] = this.bounds.toJson();
    }
    data['copyrights'] = this.copyrights;
    if (this.legs != null) {
      data['legs'] = this.legs.map((v) => v.toJson()).toList();
    }
    if (this.overviewPolyline != null) {
      data['overview_polyline'] = this.overviewPolyline.toJson();
    }
    data['summary'] = this.summary;
    data['warnings'] = this.warnings;

    data['waypoint_order'] = this.waypointOrder;
    return data;
  }
}

class Bounds {
  Northeast northeast;
  Northeast southwest;

  Bounds({this.northeast, this.southwest});

  Bounds.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ? new Northeast.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? new Northeast.fromJson(json['southwest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.northeast != null) {
      data['northeast'] = this.northeast.toJson();
    }
    if (this.southwest != null) {
      data['southwest'] = this.southwest.toJson();
    }
    return data;
  }
}

class Northeast {
  double lat;
  double lng;

  Northeast({this.lat, this.lng});

  Northeast.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Legs {
  Distance distance;
  Distance duration;
  String endAddress;
  Northeast endLocation;
  String startAddress;
  Northeast startLocation;
  List<Steps> steps;
  List<String> trafficSpeedEntry;
  List<String> viaWaypoint;

  Legs(
      {this.distance,
      this.duration,
      this.endAddress,
      this.endLocation,
      this.startAddress,
      this.startLocation,
      this.steps,
      this.trafficSpeedEntry,
      this.viaWaypoint});

  Legs.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] != null
        ? new Distance.fromJson(json['distance'])
        : null;
    duration = json['duration'] != null
        ? new Distance.fromJson(json['duration'])
        : null;
    endAddress = json['end_address'];
    endLocation = json['end_location'] != null
        ? new Northeast.fromJson(json['end_location'])
        : null;
    startAddress = json['start_address'];
    startLocation = json['start_location'] != null
        ? new Northeast.fromJson(json['start_location'])
        : null;
    if (json['steps'] != null) {
      steps = new List<Steps>();
      json['steps'].forEach((v) {
        steps.add(new Steps.fromJson(v));
      });
    }
    
    
    trafficSpeedEntry = json['traffic_speed_entry'].cast<String>();
    viaWaypoint = json['via_waypoint'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.distance != null) {
      data['distance'] = this.distance.toJson();
    }
    if (this.duration != null) {
      data['duration'] = this.duration.toJson();
    }
    data['end_address'] = this.endAddress;
    if (this.endLocation != null) {
      data['end_location'] = this.endLocation.toJson();
    }
    data['start_address'] = this.startAddress;
    if (this.startLocation != null) {
      data['start_location'] = this.startLocation.toJson();
    }
    if (this.steps != null) {
      data['steps'] = this.steps.map((v) => v.toJson()).toList();
    }
    
    data['traffic_speed_entry'] = this.trafficSpeedEntry;
    data['via_waypoint'] = this.viaWaypoint;
    return data;
  }
}

class Distance {
  String text;
  int value;

  Distance({this.text, this.value});

  Distance.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['value'] = this.value;
    return data;
  }
}

class Steps {
  Distance distance;
  Distance duration;
  Northeast endLocation;
  String htmlInstructions;
  Polylines polyline;
  Northeast startLocation;
  String travelMode;

  Steps(
      {this.distance,
      this.duration,
      this.endLocation,
      this.htmlInstructions,
      this.polyline,
      this.startLocation,
      this.travelMode});

  Steps.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] != null
        ? new Distance.fromJson(json['distance'])
        : null;
    duration = json['duration'] != null
        ? new Distance.fromJson(json['duration'])
        : null;
    endLocation = json['end_location'] != null
        ? new Northeast.fromJson(json['end_location'])
        : null;
    htmlInstructions = json['html_instructions'];
    polyline = json['polyline'] != null
        ? new Polylines.fromJson(json['polyline'])
        : null;
    startLocation = json['start_location'] != null
        ? new Northeast.fromJson(json['start_location'])
        : null;
    travelMode = json['travel_mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.distance != null) {
      data['distance'] = this.distance.toJson();
    }
    if (this.duration != null) {
      data['duration'] = this.duration.toJson();
    }
    if (this.endLocation != null) {
      data['end_location'] = this.endLocation.toJson();
    }
    data['html_instructions'] = this.htmlInstructions;
    if (this.polyline != null) {
      data['polyline'] = this.polyline.toJson();
    }
    if (this.startLocation != null) {
      data['start_location'] = this.startLocation.toJson();
    }
    data['travel_mode'] = this.travelMode;
    return data;
  }
}

class Polylines {
  String points;

  Polylines({this.points});

  Polylines.fromJson(Map<String, dynamic> json) {
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['points'] = this.points;
    return data;
  }
}
