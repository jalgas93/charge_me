
class GeoResponse {
  final Response response;

  GeoResponse({required this.response});

  factory GeoResponse.fromJson(Map<String, dynamic> json) {
    return GeoResponse(
      response: Response.fromJson(json['response']),
    );
  }
}

class Response {
  final GeoObjectCollection geoObjectCollection;

  Response({required this.geoObjectCollection});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      geoObjectCollection: GeoObjectCollection.fromJson(json['GeoObjectCollection']),
    );
  }
}

class GeoObjectCollection {
  final List<FeatureMember> featureMember;
  final MetaDataProperty metaDataProperty;

  GeoObjectCollection({
    required this.featureMember,
    required this.metaDataProperty,
  });

  factory GeoObjectCollection.fromJson(Map<String, dynamic> json) {
    return GeoObjectCollection(
      metaDataProperty: MetaDataProperty.fromJson(json['metaDataProperty']),
      featureMember: (json['featureMember'] as List)
          .map((item) => FeatureMember.fromJson(item))
          .toList(),
    );
  }
}

class MetaDataProperty {
  final GeocoderResponseMetaData geocoderResponseMetaData;

  MetaDataProperty({required this.geocoderResponseMetaData});

  factory MetaDataProperty.fromJson(Map<String, dynamic> json) {
    return MetaDataProperty(
      geocoderResponseMetaData:
      GeocoderResponseMetaData.fromJson(json['GeocoderResponseMetaData']),
    );
  }
}

class GeocoderResponseMetaData {
  final String request;
  final String results;
  final String found;
  final Point point;

  GeocoderResponseMetaData({
    required this.request,
    required this.results,
    required this.found,
    required this.point,
  });

  factory GeocoderResponseMetaData.fromJson(Map<String, dynamic> json) {
    return GeocoderResponseMetaData(
      request: json['request'],
      results: json['results'],
      found: json['found'],
      point: Point.fromJson(json['Point']),
    );
  }
}

class FeatureMember {
  final GeoObject geoObject;

  FeatureMember({required this.geoObject});

  factory FeatureMember.fromJson(Map<String, dynamic> json) {
    return FeatureMember(
      geoObject: GeoObject.fromJson(json['GeoObject']),
    );
  }
}

class GeoObject {
  final String name;
  final String description;
  final String uri;
  final Point point;
  final GeoObjectMetaData metaDataProperty;

  GeoObject({
    required this.name,
    required this.description,
    required this.uri,
    required this.point,
    required this.metaDataProperty,
  });

  factory GeoObject.fromJson(Map<String, dynamic> json) {
    return GeoObject(
      name: json['name'],
      description: json['description'],
      uri: json['uri'],
      point: Point.fromJson(json['Point']),
      metaDataProperty: GeoObjectMetaData.fromJson(json['metaDataProperty']['GeocoderMetaData']),
    );
  }
}

class Point {
  final String pos;

  Point({required this.pos});

  double get longitude => double.parse(pos.split(' ')[0]);
  double get latitude => double.parse(pos.split(' ')[1]);

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(pos: json['pos']);
  }
}

class GeoObjectMetaData {
  final String text;
  final String kind;
  final Address address;

  GeoObjectMetaData({
    required this.text,
    required this.kind,
    required this.address,
  });

  factory GeoObjectMetaData.fromJson(Map<String, dynamic> json) {
    return GeoObjectMetaData(
      text: json['text'],
      kind: json['kind'],
      address: Address.fromJson(json['Address']),
    );
  }
}

class Address {
  final String formatted;
  final List<Component> components;

  Address({
    required this.formatted,
    required this.components,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      formatted: json['formatted'],
      components: (json['Components'] as List)
          .map((item) => Component.fromJson(item))
          .toList(),
    );
  }
}

class Component {
  final String kind;
  final String name;

  Component({required this.kind, required this.name});

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
      kind: json['kind'],
      name: json['name'],
    );
  }
}