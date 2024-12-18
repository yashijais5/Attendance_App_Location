class Member {
  final String name;
  final String id;
  final String status;
  final String? loginTime;
  final String? logoutTime;
  final String avatarUrl;
  final Location location;
  final List<PastLocation>? pastLocations;

  Member({
    required this.name,
    required this.id,
    required this.status,
    this.loginTime,
    this.logoutTime,
    required this.avatarUrl,
    required this.location,
    this.pastLocations,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      name: json['name'] as String,
      id: json['id'] as String,
      status: json['status'] as String,
      loginTime: json['login_time'] as String?,
      logoutTime: json['logout_time'] as String?,
      avatarUrl: json['avatar_url'] as String,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      pastLocations: (json['past_location'] as List<dynamic>?)
          ?.map((item) => PastLocation.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Location {
  final String name;
  final double latitude;
  final double longitude;

  Location({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }
}

class PastLocation {
  final String name;
  final double latitude;
  final double longitude;
  final String entryTime;
  final String exitTime;

  PastLocation({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.entryTime,
    required this.exitTime,
  });

  factory PastLocation.fromJson(Map<String, dynamic> json) {
    return PastLocation(
      name: json['name'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      entryTime: json['entry_time'] as String,
      exitTime: json['exit_time'] as String,
    );
  }
}