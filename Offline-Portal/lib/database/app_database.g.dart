// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ClientsTable extends Clients with TableInfo<$ClientsTable, Client> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _themeColorMeta =
      const VerificationMeta('themeColor');
  @override
  late final GeneratedColumn<String> themeColor = GeneratedColumn<String>(
      'theme_color', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, themeColor];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clients';
  @override
  VerificationContext validateIntegrity(Insertable<Client> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('theme_color')) {
      context.handle(
          _themeColorMeta,
          themeColor.isAcceptableOrUnknown(
              data['theme_color']!, _themeColorMeta));
    } else if (isInserting) {
      context.missing(_themeColorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Client map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Client(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      themeColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}theme_color'])!,
    );
  }

  @override
  $ClientsTable createAlias(String alias) {
    return $ClientsTable(attachedDatabase, alias);
  }
}

class Client extends DataClass implements Insertable<Client> {
  final int id;
  final String name;
  final String themeColor;
  const Client(
      {required this.id, required this.name, required this.themeColor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['theme_color'] = Variable<String>(themeColor);
    return map;
  }

  ClientsCompanion toCompanion(bool nullToAbsent) {
    return ClientsCompanion(
      id: Value(id),
      name: Value(name),
      themeColor: Value(themeColor),
    );
  }

  factory Client.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Client(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      themeColor: serializer.fromJson<String>(json['themeColor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'themeColor': serializer.toJson<String>(themeColor),
    };
  }

  Client copyWith({int? id, String? name, String? themeColor}) => Client(
        id: id ?? this.id,
        name: name ?? this.name,
        themeColor: themeColor ?? this.themeColor,
      );
  Client copyWithCompanion(ClientsCompanion data) {
    return Client(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      themeColor:
          data.themeColor.present ? data.themeColor.value : this.themeColor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Client(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('themeColor: $themeColor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, themeColor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Client &&
          other.id == this.id &&
          other.name == this.name &&
          other.themeColor == this.themeColor);
}

class ClientsCompanion extends UpdateCompanion<Client> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> themeColor;
  const ClientsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.themeColor = const Value.absent(),
  });
  ClientsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String themeColor,
  })  : name = Value(name),
        themeColor = Value(themeColor);
  static Insertable<Client> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? themeColor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (themeColor != null) 'theme_color': themeColor,
    });
  }

  ClientsCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<String>? themeColor}) {
    return ClientsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      themeColor: themeColor ?? this.themeColor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (themeColor.present) {
      map['theme_color'] = Variable<String>(themeColor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('themeColor: $themeColor')
          ..write(')'))
        .toString();
  }
}

class $SitesTable extends Sites with TableInfo<$SitesTable, Site> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SitesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _clientIdMeta =
      const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<int> clientId = GeneratedColumn<int>(
      'client_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES clients (id)'));
  static const VerificationMeta _branchNameMeta =
      const VerificationMeta('branchName');
  @override
  late final GeneratedColumn<String> branchName = GeneratedColumn<String>(
      'branch_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
      'region', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, clientId, branchName, address, latitude, longitude, region];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sites';
  @override
  VerificationContext validateIntegrity(Insertable<Site> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('branch_name')) {
      context.handle(
          _branchNameMeta,
          branchName.isAcceptableOrUnknown(
              data['branch_name']!, _branchNameMeta));
    } else if (isInserting) {
      context.missing(_branchNameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('region')) {
      context.handle(_regionMeta,
          region.isAcceptableOrUnknown(data['region']!, _regionMeta));
    } else if (isInserting) {
      context.missing(_regionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Site map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Site(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      clientId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}client_id'])!,
      branchName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_name'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude'])!,
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude'])!,
      region: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}region'])!,
    );
  }

  @override
  $SitesTable createAlias(String alias) {
    return $SitesTable(attachedDatabase, alias);
  }
}

class Site extends DataClass implements Insertable<Site> {
  final int id;
  final int clientId;
  final String branchName;
  final String address;
  final double latitude;
  final double longitude;
  final String region;
  const Site(
      {required this.id,
      required this.clientId,
      required this.branchName,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.region});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_id'] = Variable<int>(clientId);
    map['branch_name'] = Variable<String>(branchName);
    map['address'] = Variable<String>(address);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['region'] = Variable<String>(region);
    return map;
  }

  SitesCompanion toCompanion(bool nullToAbsent) {
    return SitesCompanion(
      id: Value(id),
      clientId: Value(clientId),
      branchName: Value(branchName),
      address: Value(address),
      latitude: Value(latitude),
      longitude: Value(longitude),
      region: Value(region),
    );
  }

  factory Site.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Site(
      id: serializer.fromJson<int>(json['id']),
      clientId: serializer.fromJson<int>(json['clientId']),
      branchName: serializer.fromJson<String>(json['branchName']),
      address: serializer.fromJson<String>(json['address']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      region: serializer.fromJson<String>(json['region']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientId': serializer.toJson<int>(clientId),
      'branchName': serializer.toJson<String>(branchName),
      'address': serializer.toJson<String>(address),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'region': serializer.toJson<String>(region),
    };
  }

  Site copyWith(
          {int? id,
          int? clientId,
          String? branchName,
          String? address,
          double? latitude,
          double? longitude,
          String? region}) =>
      Site(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        branchName: branchName ?? this.branchName,
        address: address ?? this.address,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        region: region ?? this.region,
      );
  Site copyWithCompanion(SitesCompanion data) {
    return Site(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      branchName:
          data.branchName.present ? data.branchName.value : this.branchName,
      address: data.address.present ? data.address.value : this.address,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      region: data.region.present ? data.region.value : this.region,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Site(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('branchName: $branchName, ')
          ..write('address: $address, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('region: $region')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, clientId, branchName, address, latitude, longitude, region);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Site &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.branchName == this.branchName &&
          other.address == this.address &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.region == this.region);
}

class SitesCompanion extends UpdateCompanion<Site> {
  final Value<int> id;
  final Value<int> clientId;
  final Value<String> branchName;
  final Value<String> address;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<String> region;
  const SitesCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.branchName = const Value.absent(),
    this.address = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.region = const Value.absent(),
  });
  SitesCompanion.insert({
    this.id = const Value.absent(),
    required int clientId,
    required String branchName,
    required String address,
    required double latitude,
    required double longitude,
    required String region,
  })  : clientId = Value(clientId),
        branchName = Value(branchName),
        address = Value(address),
        latitude = Value(latitude),
        longitude = Value(longitude),
        region = Value(region);
  static Insertable<Site> custom({
    Expression<int>? id,
    Expression<int>? clientId,
    Expression<String>? branchName,
    Expression<String>? address,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? region,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (branchName != null) 'branch_name': branchName,
      if (address != null) 'address': address,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (region != null) 'region': region,
    });
  }

  SitesCompanion copyWith(
      {Value<int>? id,
      Value<int>? clientId,
      Value<String>? branchName,
      Value<String>? address,
      Value<double>? latitude,
      Value<double>? longitude,
      Value<String>? region}) {
    return SitesCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      branchName: branchName ?? this.branchName,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      region: region ?? this.region,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (branchName.present) {
      map['branch_name'] = Variable<String>(branchName.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SitesCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('branchName: $branchName, ')
          ..write('address: $address, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('region: $region')
          ..write(')'))
        .toString();
  }
}

class $StartingPointsTable extends StartingPoints
    with TableInfo<$StartingPointsTable, StartingPoint> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StartingPointsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, latitude, longitude];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'starting_points';
  @override
  VerificationContext validateIntegrity(Insertable<StartingPoint> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StartingPoint map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StartingPoint(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude'])!,
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude'])!,
    );
  }

  @override
  $StartingPointsTable createAlias(String alias) {
    return $StartingPointsTable(attachedDatabase, alias);
  }
}

class StartingPoint extends DataClass implements Insertable<StartingPoint> {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  const StartingPoint(
      {required this.id,
      required this.name,
      required this.latitude,
      required this.longitude});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    return map;
  }

  StartingPointsCompanion toCompanion(bool nullToAbsent) {
    return StartingPointsCompanion(
      id: Value(id),
      name: Value(name),
      latitude: Value(latitude),
      longitude: Value(longitude),
    );
  }

  factory StartingPoint.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StartingPoint(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
    };
  }

  StartingPoint copyWith(
          {int? id, String? name, double? latitude, double? longitude}) =>
      StartingPoint(
        id: id ?? this.id,
        name: name ?? this.name,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );
  StartingPoint copyWithCompanion(StartingPointsCompanion data) {
    return StartingPoint(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StartingPoint(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, latitude, longitude);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StartingPoint &&
          other.id == this.id &&
          other.name == this.name &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude);
}

class StartingPointsCompanion extends UpdateCompanion<StartingPoint> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> latitude;
  final Value<double> longitude;
  const StartingPointsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
  });
  StartingPointsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required double latitude,
    required double longitude,
  })  : name = Value(name),
        latitude = Value(latitude),
        longitude = Value(longitude);
  static Insertable<StartingPoint> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? latitude,
    Expression<double>? longitude,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    });
  }

  StartingPointsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<double>? latitude,
      Value<double>? longitude}) {
    return StartingPointsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StartingPointsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _fullNameMeta =
      const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
      'full_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passwordHashMeta =
      const VerificationMeta('passwordHash');
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
      'password_hash', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _passwordSaltMeta =
      const VerificationMeta('passwordSalt');
  @override
  late final GeneratedColumn<String> passwordSalt = GeneratedColumn<String>(
      'password_salt', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _pinMeta = const VerificationMeta('pin');
  @override
  late final GeneratedColumn<String> pin = GeneratedColumn<String>(
      'pin', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateOfBirthMeta =
      const VerificationMeta('dateOfBirth');
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
      'date_of_birth', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
      'phone_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _bioMeta = const VerificationMeta('bio');
  @override
  late final GeneratedColumn<String> bio = GeneratedColumn<String>(
      'bio', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        username,
        fullName,
        email,
        role,
        passwordHash,
        passwordSalt,
        pin,
        dateOfBirth,
        location,
        phoneNumber,
        bio,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
          _passwordHashMeta,
          passwordHash.isAcceptableOrUnknown(
              data['password_hash']!, _passwordHashMeta));
    }
    if (data.containsKey('password_salt')) {
      context.handle(
          _passwordSaltMeta,
          passwordSalt.isAcceptableOrUnknown(
              data['password_salt']!, _passwordSaltMeta));
    }
    if (data.containsKey('pin')) {
      context.handle(
          _pinMeta, pin.isAcceptableOrUnknown(data['pin']!, _pinMeta));
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
          _dateOfBirthMeta,
          dateOfBirth.isAcceptableOrUnknown(
              data['date_of_birth']!, _dateOfBirthMeta));
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    }
    if (data.containsKey('bio')) {
      context.handle(
          _bioMeta, bio.isAcceptableOrUnknown(data['bio']!, _bioMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      fullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      passwordHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password_hash'])!,
      passwordSalt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password_salt'])!,
      pin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pin']),
      dateOfBirth: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_of_birth']),
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location']),
      phoneNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone_number']),
      bio: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bio']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String fullName;
  final String email;
  final String role;
  final String passwordHash;
  final String passwordSalt;
  final String? pin;
  final DateTime? dateOfBirth;
  final String? location;
  final String? phoneNumber;
  final String? bio;
  final DateTime createdAt;
  const User(
      {required this.id,
      required this.username,
      required this.fullName,
      required this.email,
      required this.role,
      required this.passwordHash,
      required this.passwordSalt,
      this.pin,
      this.dateOfBirth,
      this.location,
      this.phoneNumber,
      this.bio,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['full_name'] = Variable<String>(fullName);
    map['email'] = Variable<String>(email);
    map['role'] = Variable<String>(role);
    map['password_hash'] = Variable<String>(passwordHash);
    map['password_salt'] = Variable<String>(passwordSalt);
    if (!nullToAbsent || pin != null) {
      map['pin'] = Variable<String>(pin);
    }
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    if (!nullToAbsent || bio != null) {
      map['bio'] = Variable<String>(bio);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      fullName: Value(fullName),
      email: Value(email),
      role: Value(role),
      passwordHash: Value(passwordHash),
      passwordSalt: Value(passwordSalt),
      pin: pin == null && nullToAbsent ? const Value.absent() : Value(pin),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      bio: bio == null && nullToAbsent ? const Value.absent() : Value(bio),
      createdAt: Value(createdAt),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      fullName: serializer.fromJson<String>(json['fullName']),
      email: serializer.fromJson<String>(json['email']),
      role: serializer.fromJson<String>(json['role']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      passwordSalt: serializer.fromJson<String>(json['passwordSalt']),
      pin: serializer.fromJson<String?>(json['pin']),
      dateOfBirth: serializer.fromJson<DateTime?>(json['dateOfBirth']),
      location: serializer.fromJson<String?>(json['location']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      bio: serializer.fromJson<String?>(json['bio']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'fullName': serializer.toJson<String>(fullName),
      'email': serializer.toJson<String>(email),
      'role': serializer.toJson<String>(role),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'passwordSalt': serializer.toJson<String>(passwordSalt),
      'pin': serializer.toJson<String?>(pin),
      'dateOfBirth': serializer.toJson<DateTime?>(dateOfBirth),
      'location': serializer.toJson<String?>(location),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'bio': serializer.toJson<String?>(bio),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  User copyWith(
          {int? id,
          String? username,
          String? fullName,
          String? email,
          String? role,
          String? passwordHash,
          String? passwordSalt,
          Value<String?> pin = const Value.absent(),
          Value<DateTime?> dateOfBirth = const Value.absent(),
          Value<String?> location = const Value.absent(),
          Value<String?> phoneNumber = const Value.absent(),
          Value<String?> bio = const Value.absent(),
          DateTime? createdAt}) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        role: role ?? this.role,
        passwordHash: passwordHash ?? this.passwordHash,
        passwordSalt: passwordSalt ?? this.passwordSalt,
        pin: pin.present ? pin.value : this.pin,
        dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
        location: location.present ? location.value : this.location,
        phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
        bio: bio.present ? bio.value : this.bio,
        createdAt: createdAt ?? this.createdAt,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      email: data.email.present ? data.email.value : this.email,
      role: data.role.present ? data.role.value : this.role,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      passwordSalt: data.passwordSalt.present
          ? data.passwordSalt.value
          : this.passwordSalt,
      pin: data.pin.present ? data.pin.value : this.pin,
      dateOfBirth:
          data.dateOfBirth.present ? data.dateOfBirth.value : this.dateOfBirth,
      location: data.location.present ? data.location.value : this.location,
      phoneNumber:
          data.phoneNumber.present ? data.phoneNumber.value : this.phoneNumber,
      bio: data.bio.present ? data.bio.value : this.bio,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('fullName: $fullName, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('passwordSalt: $passwordSalt, ')
          ..write('pin: $pin, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('location: $location, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('bio: $bio, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      username,
      fullName,
      email,
      role,
      passwordHash,
      passwordSalt,
      pin,
      dateOfBirth,
      location,
      phoneNumber,
      bio,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.fullName == this.fullName &&
          other.email == this.email &&
          other.role == this.role &&
          other.passwordHash == this.passwordHash &&
          other.passwordSalt == this.passwordSalt &&
          other.pin == this.pin &&
          other.dateOfBirth == this.dateOfBirth &&
          other.location == this.location &&
          other.phoneNumber == this.phoneNumber &&
          other.bio == this.bio &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> fullName;
  final Value<String> email;
  final Value<String> role;
  final Value<String> passwordHash;
  final Value<String> passwordSalt;
  final Value<String?> pin;
  final Value<DateTime?> dateOfBirth;
  final Value<String?> location;
  final Value<String?> phoneNumber;
  final Value<String?> bio;
  final Value<DateTime> createdAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.fullName = const Value.absent(),
    this.email = const Value.absent(),
    this.role = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.passwordSalt = const Value.absent(),
    this.pin = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.location = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.bio = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String fullName,
    required String email,
    required String role,
    this.passwordHash = const Value.absent(),
    this.passwordSalt = const Value.absent(),
    this.pin = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.location = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.bio = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : username = Value(username),
        fullName = Value(fullName),
        email = Value(email),
        role = Value(role);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? fullName,
    Expression<String>? email,
    Expression<String>? role,
    Expression<String>? passwordHash,
    Expression<String>? passwordSalt,
    Expression<String>? pin,
    Expression<DateTime>? dateOfBirth,
    Expression<String>? location,
    Expression<String>? phoneNumber,
    Expression<String>? bio,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (fullName != null) 'full_name': fullName,
      if (email != null) 'email': email,
      if (role != null) 'role': role,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (passwordSalt != null) 'password_salt': passwordSalt,
      if (pin != null) 'pin': pin,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (location != null) 'location': location,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (bio != null) 'bio': bio,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? username,
      Value<String>? fullName,
      Value<String>? email,
      Value<String>? role,
      Value<String>? passwordHash,
      Value<String>? passwordSalt,
      Value<String?>? pin,
      Value<DateTime?>? dateOfBirth,
      Value<String?>? location,
      Value<String?>? phoneNumber,
      Value<String?>? bio,
      Value<DateTime>? createdAt}) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      role: role ?? this.role,
      passwordHash: passwordHash ?? this.passwordHash,
      passwordSalt: passwordSalt ?? this.passwordSalt,
      pin: pin ?? this.pin,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      location: location ?? this.location,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (passwordSalt.present) {
      map['password_salt'] = Variable<String>(passwordSalt.value);
    }
    if (pin.present) {
      map['pin'] = Variable<String>(pin.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (bio.present) {
      map['bio'] = Variable<String>(bio.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('fullName: $fullName, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('passwordSalt: $passwordSalt, ')
          ..write('pin: $pin, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('location: $location, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('bio: $bio, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $WeatherSnapshotTable extends WeatherSnapshot
    with TableInfo<$WeatherSnapshotTable, WeatherSnapshotData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeatherSnapshotTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
      'region', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _temperatureMeta =
      const VerificationMeta('temperature');
  @override
  late final GeneratedColumn<int> temperature = GeneratedColumn<int>(
      'temperature', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _conditionMeta =
      const VerificationMeta('condition');
  @override
  late final GeneratedColumn<String> condition = GeneratedColumn<String>(
      'condition', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fetchedAtMeta =
      const VerificationMeta('fetchedAt');
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
      'fetched_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _zipCodeMeta =
      const VerificationMeta('zipCode');
  @override
  late final GeneratedColumn<String> zipCode = GeneratedColumn<String>(
      'zip_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, region, temperature, condition, fetchedAt, source, zipCode];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weather_snapshot';
  @override
  VerificationContext validateIntegrity(
      Insertable<WeatherSnapshotData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('region')) {
      context.handle(_regionMeta,
          region.isAcceptableOrUnknown(data['region']!, _regionMeta));
    } else if (isInserting) {
      context.missing(_regionMeta);
    }
    if (data.containsKey('temperature')) {
      context.handle(
          _temperatureMeta,
          temperature.isAcceptableOrUnknown(
              data['temperature']!, _temperatureMeta));
    } else if (isInserting) {
      context.missing(_temperatureMeta);
    }
    if (data.containsKey('condition')) {
      context.handle(_conditionMeta,
          condition.isAcceptableOrUnknown(data['condition']!, _conditionMeta));
    } else if (isInserting) {
      context.missing(_conditionMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(_fetchedAtMeta,
          fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta));
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('zip_code')) {
      context.handle(_zipCodeMeta,
          zipCode.isAcceptableOrUnknown(data['zip_code']!, _zipCodeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeatherSnapshotData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeatherSnapshotData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      region: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}region'])!,
      temperature: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}temperature'])!,
      condition: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}condition'])!,
      fetchedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fetched_at'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      zipCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}zip_code']),
    );
  }

  @override
  $WeatherSnapshotTable createAlias(String alias) {
    return $WeatherSnapshotTable(attachedDatabase, alias);
  }
}

class WeatherSnapshotData extends DataClass
    implements Insertable<WeatherSnapshotData> {
  final int id;
  final String region;
  final int temperature;
  final String condition;
  final DateTime fetchedAt;
  final String source;
  final String? zipCode;
  const WeatherSnapshotData(
      {required this.id,
      required this.region,
      required this.temperature,
      required this.condition,
      required this.fetchedAt,
      required this.source,
      this.zipCode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['region'] = Variable<String>(region);
    map['temperature'] = Variable<int>(temperature);
    map['condition'] = Variable<String>(condition);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || zipCode != null) {
      map['zip_code'] = Variable<String>(zipCode);
    }
    return map;
  }

  WeatherSnapshotCompanion toCompanion(bool nullToAbsent) {
    return WeatherSnapshotCompanion(
      id: Value(id),
      region: Value(region),
      temperature: Value(temperature),
      condition: Value(condition),
      fetchedAt: Value(fetchedAt),
      source: Value(source),
      zipCode: zipCode == null && nullToAbsent
          ? const Value.absent()
          : Value(zipCode),
    );
  }

  factory WeatherSnapshotData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeatherSnapshotData(
      id: serializer.fromJson<int>(json['id']),
      region: serializer.fromJson<String>(json['region']),
      temperature: serializer.fromJson<int>(json['temperature']),
      condition: serializer.fromJson<String>(json['condition']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
      source: serializer.fromJson<String>(json['source']),
      zipCode: serializer.fromJson<String?>(json['zipCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'region': serializer.toJson<String>(region),
      'temperature': serializer.toJson<int>(temperature),
      'condition': serializer.toJson<String>(condition),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
      'source': serializer.toJson<String>(source),
      'zipCode': serializer.toJson<String?>(zipCode),
    };
  }

  WeatherSnapshotData copyWith(
          {int? id,
          String? region,
          int? temperature,
          String? condition,
          DateTime? fetchedAt,
          String? source,
          Value<String?> zipCode = const Value.absent()}) =>
      WeatherSnapshotData(
        id: id ?? this.id,
        region: region ?? this.region,
        temperature: temperature ?? this.temperature,
        condition: condition ?? this.condition,
        fetchedAt: fetchedAt ?? this.fetchedAt,
        source: source ?? this.source,
        zipCode: zipCode.present ? zipCode.value : this.zipCode,
      );
  WeatherSnapshotData copyWithCompanion(WeatherSnapshotCompanion data) {
    return WeatherSnapshotData(
      id: data.id.present ? data.id.value : this.id,
      region: data.region.present ? data.region.value : this.region,
      temperature:
          data.temperature.present ? data.temperature.value : this.temperature,
      condition: data.condition.present ? data.condition.value : this.condition,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
      source: data.source.present ? data.source.value : this.source,
      zipCode: data.zipCode.present ? data.zipCode.value : this.zipCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeatherSnapshotData(')
          ..write('id: $id, ')
          ..write('region: $region, ')
          ..write('temperature: $temperature, ')
          ..write('condition: $condition, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('source: $source, ')
          ..write('zipCode: $zipCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, region, temperature, condition, fetchedAt, source, zipCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeatherSnapshotData &&
          other.id == this.id &&
          other.region == this.region &&
          other.temperature == this.temperature &&
          other.condition == this.condition &&
          other.fetchedAt == this.fetchedAt &&
          other.source == this.source &&
          other.zipCode == this.zipCode);
}

class WeatherSnapshotCompanion extends UpdateCompanion<WeatherSnapshotData> {
  final Value<int> id;
  final Value<String> region;
  final Value<int> temperature;
  final Value<String> condition;
  final Value<DateTime> fetchedAt;
  final Value<String> source;
  final Value<String?> zipCode;
  const WeatherSnapshotCompanion({
    this.id = const Value.absent(),
    this.region = const Value.absent(),
    this.temperature = const Value.absent(),
    this.condition = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.source = const Value.absent(),
    this.zipCode = const Value.absent(),
  });
  WeatherSnapshotCompanion.insert({
    this.id = const Value.absent(),
    required String region,
    required int temperature,
    required String condition,
    required DateTime fetchedAt,
    required String source,
    this.zipCode = const Value.absent(),
  })  : region = Value(region),
        temperature = Value(temperature),
        condition = Value(condition),
        fetchedAt = Value(fetchedAt),
        source = Value(source);
  static Insertable<WeatherSnapshotData> custom({
    Expression<int>? id,
    Expression<String>? region,
    Expression<int>? temperature,
    Expression<String>? condition,
    Expression<DateTime>? fetchedAt,
    Expression<String>? source,
    Expression<String>? zipCode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (region != null) 'region': region,
      if (temperature != null) 'temperature': temperature,
      if (condition != null) 'condition': condition,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (source != null) 'source': source,
      if (zipCode != null) 'zip_code': zipCode,
    });
  }

  WeatherSnapshotCompanion copyWith(
      {Value<int>? id,
      Value<String>? region,
      Value<int>? temperature,
      Value<String>? condition,
      Value<DateTime>? fetchedAt,
      Value<String>? source,
      Value<String?>? zipCode}) {
    return WeatherSnapshotCompanion(
      id: id ?? this.id,
      region: region ?? this.region,
      temperature: temperature ?? this.temperature,
      condition: condition ?? this.condition,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      source: source ?? this.source,
      zipCode: zipCode ?? this.zipCode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<int>(temperature.value);
    }
    if (condition.present) {
      map['condition'] = Variable<String>(condition.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (zipCode.present) {
      map['zip_code'] = Variable<String>(zipCode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeatherSnapshotCompanion(')
          ..write('id: $id, ')
          ..write('region: $region, ')
          ..write('temperature: $temperature, ')
          ..write('condition: $condition, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('source: $source, ')
          ..write('zipCode: $zipCode')
          ..write(')'))
        .toString();
  }
}

class $TrafficSnapshotTable extends TrafficSnapshot
    with TableInfo<$TrafficSnapshotTable, TrafficSnapshotData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrafficSnapshotTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _routeLabelMeta =
      const VerificationMeta('routeLabel');
  @override
  late final GeneratedColumn<String> routeLabel = GeneratedColumn<String>(
      'route_label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _etaMinutesMeta =
      const VerificationMeta('etaMinutes');
  @override
  late final GeneratedColumn<int> etaMinutes = GeneratedColumn<int>(
      'eta_minutes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _conditionLabelMeta =
      const VerificationMeta('conditionLabel');
  @override
  late final GeneratedColumn<String> conditionLabel = GeneratedColumn<String>(
      'condition_label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fetchedAtMeta =
      const VerificationMeta('fetchedAt');
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
      'fetched_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, routeLabel, etaMinutes, conditionLabel, fetchedAt, source];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'traffic_snapshot';
  @override
  VerificationContext validateIntegrity(
      Insertable<TrafficSnapshotData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('route_label')) {
      context.handle(
          _routeLabelMeta,
          routeLabel.isAcceptableOrUnknown(
              data['route_label']!, _routeLabelMeta));
    } else if (isInserting) {
      context.missing(_routeLabelMeta);
    }
    if (data.containsKey('eta_minutes')) {
      context.handle(
          _etaMinutesMeta,
          etaMinutes.isAcceptableOrUnknown(
              data['eta_minutes']!, _etaMinutesMeta));
    } else if (isInserting) {
      context.missing(_etaMinutesMeta);
    }
    if (data.containsKey('condition_label')) {
      context.handle(
          _conditionLabelMeta,
          conditionLabel.isAcceptableOrUnknown(
              data['condition_label']!, _conditionLabelMeta));
    } else if (isInserting) {
      context.missing(_conditionLabelMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(_fetchedAtMeta,
          fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta));
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrafficSnapshotData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrafficSnapshotData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      routeLabel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}route_label'])!,
      etaMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}eta_minutes'])!,
      conditionLabel: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}condition_label'])!,
      fetchedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fetched_at'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
    );
  }

  @override
  $TrafficSnapshotTable createAlias(String alias) {
    return $TrafficSnapshotTable(attachedDatabase, alias);
  }
}

class TrafficSnapshotData extends DataClass
    implements Insertable<TrafficSnapshotData> {
  final int id;
  final String routeLabel;
  final int etaMinutes;
  final String conditionLabel;
  final DateTime fetchedAt;
  final String source;
  const TrafficSnapshotData(
      {required this.id,
      required this.routeLabel,
      required this.etaMinutes,
      required this.conditionLabel,
      required this.fetchedAt,
      required this.source});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['route_label'] = Variable<String>(routeLabel);
    map['eta_minutes'] = Variable<int>(etaMinutes);
    map['condition_label'] = Variable<String>(conditionLabel);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    map['source'] = Variable<String>(source);
    return map;
  }

  TrafficSnapshotCompanion toCompanion(bool nullToAbsent) {
    return TrafficSnapshotCompanion(
      id: Value(id),
      routeLabel: Value(routeLabel),
      etaMinutes: Value(etaMinutes),
      conditionLabel: Value(conditionLabel),
      fetchedAt: Value(fetchedAt),
      source: Value(source),
    );
  }

  factory TrafficSnapshotData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrafficSnapshotData(
      id: serializer.fromJson<int>(json['id']),
      routeLabel: serializer.fromJson<String>(json['routeLabel']),
      etaMinutes: serializer.fromJson<int>(json['etaMinutes']),
      conditionLabel: serializer.fromJson<String>(json['conditionLabel']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
      source: serializer.fromJson<String>(json['source']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'routeLabel': serializer.toJson<String>(routeLabel),
      'etaMinutes': serializer.toJson<int>(etaMinutes),
      'conditionLabel': serializer.toJson<String>(conditionLabel),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
      'source': serializer.toJson<String>(source),
    };
  }

  TrafficSnapshotData copyWith(
          {int? id,
          String? routeLabel,
          int? etaMinutes,
          String? conditionLabel,
          DateTime? fetchedAt,
          String? source}) =>
      TrafficSnapshotData(
        id: id ?? this.id,
        routeLabel: routeLabel ?? this.routeLabel,
        etaMinutes: etaMinutes ?? this.etaMinutes,
        conditionLabel: conditionLabel ?? this.conditionLabel,
        fetchedAt: fetchedAt ?? this.fetchedAt,
        source: source ?? this.source,
      );
  TrafficSnapshotData copyWithCompanion(TrafficSnapshotCompanion data) {
    return TrafficSnapshotData(
      id: data.id.present ? data.id.value : this.id,
      routeLabel:
          data.routeLabel.present ? data.routeLabel.value : this.routeLabel,
      etaMinutes:
          data.etaMinutes.present ? data.etaMinutes.value : this.etaMinutes,
      conditionLabel: data.conditionLabel.present
          ? data.conditionLabel.value
          : this.conditionLabel,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
      source: data.source.present ? data.source.value : this.source,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrafficSnapshotData(')
          ..write('id: $id, ')
          ..write('routeLabel: $routeLabel, ')
          ..write('etaMinutes: $etaMinutes, ')
          ..write('conditionLabel: $conditionLabel, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, routeLabel, etaMinutes, conditionLabel, fetchedAt, source);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrafficSnapshotData &&
          other.id == this.id &&
          other.routeLabel == this.routeLabel &&
          other.etaMinutes == this.etaMinutes &&
          other.conditionLabel == this.conditionLabel &&
          other.fetchedAt == this.fetchedAt &&
          other.source == this.source);
}

class TrafficSnapshotCompanion extends UpdateCompanion<TrafficSnapshotData> {
  final Value<int> id;
  final Value<String> routeLabel;
  final Value<int> etaMinutes;
  final Value<String> conditionLabel;
  final Value<DateTime> fetchedAt;
  final Value<String> source;
  const TrafficSnapshotCompanion({
    this.id = const Value.absent(),
    this.routeLabel = const Value.absent(),
    this.etaMinutes = const Value.absent(),
    this.conditionLabel = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.source = const Value.absent(),
  });
  TrafficSnapshotCompanion.insert({
    this.id = const Value.absent(),
    required String routeLabel,
    required int etaMinutes,
    required String conditionLabel,
    required DateTime fetchedAt,
    required String source,
  })  : routeLabel = Value(routeLabel),
        etaMinutes = Value(etaMinutes),
        conditionLabel = Value(conditionLabel),
        fetchedAt = Value(fetchedAt),
        source = Value(source);
  static Insertable<TrafficSnapshotData> custom({
    Expression<int>? id,
    Expression<String>? routeLabel,
    Expression<int>? etaMinutes,
    Expression<String>? conditionLabel,
    Expression<DateTime>? fetchedAt,
    Expression<String>? source,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routeLabel != null) 'route_label': routeLabel,
      if (etaMinutes != null) 'eta_minutes': etaMinutes,
      if (conditionLabel != null) 'condition_label': conditionLabel,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (source != null) 'source': source,
    });
  }

  TrafficSnapshotCompanion copyWith(
      {Value<int>? id,
      Value<String>? routeLabel,
      Value<int>? etaMinutes,
      Value<String>? conditionLabel,
      Value<DateTime>? fetchedAt,
      Value<String>? source}) {
    return TrafficSnapshotCompanion(
      id: id ?? this.id,
      routeLabel: routeLabel ?? this.routeLabel,
      etaMinutes: etaMinutes ?? this.etaMinutes,
      conditionLabel: conditionLabel ?? this.conditionLabel,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      source: source ?? this.source,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (routeLabel.present) {
      map['route_label'] = Variable<String>(routeLabel.value);
    }
    if (etaMinutes.present) {
      map['eta_minutes'] = Variable<int>(etaMinutes.value);
    }
    if (conditionLabel.present) {
      map['condition_label'] = Variable<String>(conditionLabel.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrafficSnapshotCompanion(')
          ..write('id: $id, ')
          ..write('routeLabel: $routeLabel, ')
          ..write('etaMinutes: $etaMinutes, ')
          ..write('conditionLabel: $conditionLabel, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }
}

class $WorkCallsTable extends WorkCalls
    with TableInfo<$WorkCallsTable, WorkCall> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkCallsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scheduledAtMeta =
      const VerificationMeta('scheduledAt');
  @override
  late final GeneratedColumn<DateTime> scheduledAt = GeneratedColumn<DateTime>(
      'scheduled_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _workOrderNumberMeta =
      const VerificationMeta('workOrderNumber');
  @override
  late final GeneratedColumn<String> workOrderNumber = GeneratedColumn<String>(
      'work_order_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, status, scheduledAt, completedAt, workOrderNumber];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'work_calls';
  @override
  VerificationContext validateIntegrity(Insertable<WorkCall> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
          _scheduledAtMeta,
          scheduledAt.isAcceptableOrUnknown(
              data['scheduled_at']!, _scheduledAtMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    if (data.containsKey('work_order_number')) {
      context.handle(
          _workOrderNumberMeta,
          workOrderNumber.isAcceptableOrUnknown(
              data['work_order_number']!, _workOrderNumberMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkCall map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkCall(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      scheduledAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}scheduled_at']),
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
      workOrderNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}work_order_number']),
    );
  }

  @override
  $WorkCallsTable createAlias(String alias) {
    return $WorkCallsTable(attachedDatabase, alias);
  }
}

class WorkCall extends DataClass implements Insertable<WorkCall> {
  final int id;
  final String status;
  final DateTime? scheduledAt;
  final DateTime? completedAt;
  final String? workOrderNumber;
  const WorkCall(
      {required this.id,
      required this.status,
      this.scheduledAt,
      this.completedAt,
      this.workOrderNumber});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || scheduledAt != null) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    if (!nullToAbsent || workOrderNumber != null) {
      map['work_order_number'] = Variable<String>(workOrderNumber);
    }
    return map;
  }

  WorkCallsCompanion toCompanion(bool nullToAbsent) {
    return WorkCallsCompanion(
      id: Value(id),
      status: Value(status),
      scheduledAt: scheduledAt == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduledAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      workOrderNumber: workOrderNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(workOrderNumber),
    );
  }

  factory WorkCall.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkCall(
      id: serializer.fromJson<int>(json['id']),
      status: serializer.fromJson<String>(json['status']),
      scheduledAt: serializer.fromJson<DateTime?>(json['scheduledAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      workOrderNumber: serializer.fromJson<String?>(json['workOrderNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'status': serializer.toJson<String>(status),
      'scheduledAt': serializer.toJson<DateTime?>(scheduledAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'workOrderNumber': serializer.toJson<String?>(workOrderNumber),
    };
  }

  WorkCall copyWith(
          {int? id,
          String? status,
          Value<DateTime?> scheduledAt = const Value.absent(),
          Value<DateTime?> completedAt = const Value.absent(),
          Value<String?> workOrderNumber = const Value.absent()}) =>
      WorkCall(
        id: id ?? this.id,
        status: status ?? this.status,
        scheduledAt: scheduledAt.present ? scheduledAt.value : this.scheduledAt,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
        workOrderNumber: workOrderNumber.present
            ? workOrderNumber.value
            : this.workOrderNumber,
      );
  WorkCall copyWithCompanion(WorkCallsCompanion data) {
    return WorkCall(
      id: data.id.present ? data.id.value : this.id,
      status: data.status.present ? data.status.value : this.status,
      scheduledAt:
          data.scheduledAt.present ? data.scheduledAt.value : this.scheduledAt,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      workOrderNumber: data.workOrderNumber.present
          ? data.workOrderNumber.value
          : this.workOrderNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkCall(')
          ..write('id: $id, ')
          ..write('status: $status, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('workOrderNumber: $workOrderNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, status, scheduledAt, completedAt, workOrderNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkCall &&
          other.id == this.id &&
          other.status == this.status &&
          other.scheduledAt == this.scheduledAt &&
          other.completedAt == this.completedAt &&
          other.workOrderNumber == this.workOrderNumber);
}

class WorkCallsCompanion extends UpdateCompanion<WorkCall> {
  final Value<int> id;
  final Value<String> status;
  final Value<DateTime?> scheduledAt;
  final Value<DateTime?> completedAt;
  final Value<String?> workOrderNumber;
  const WorkCallsCompanion({
    this.id = const Value.absent(),
    this.status = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.workOrderNumber = const Value.absent(),
  });
  WorkCallsCompanion.insert({
    this.id = const Value.absent(),
    required String status,
    this.scheduledAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.workOrderNumber = const Value.absent(),
  }) : status = Value(status);
  static Insertable<WorkCall> custom({
    Expression<int>? id,
    Expression<String>? status,
    Expression<DateTime>? scheduledAt,
    Expression<DateTime>? completedAt,
    Expression<String>? workOrderNumber,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (status != null) 'status': status,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (workOrderNumber != null) 'work_order_number': workOrderNumber,
    });
  }

  WorkCallsCompanion copyWith(
      {Value<int>? id,
      Value<String>? status,
      Value<DateTime?>? scheduledAt,
      Value<DateTime?>? completedAt,
      Value<String?>? workOrderNumber}) {
    return WorkCallsCompanion(
      id: id ?? this.id,
      status: status ?? this.status,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      completedAt: completedAt ?? this.completedAt,
      workOrderNumber: workOrderNumber ?? this.workOrderNumber,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (workOrderNumber.present) {
      map['work_order_number'] = Variable<String>(workOrderNumber.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkCallsCompanion(')
          ..write('id: $id, ')
          ..write('status: $status, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('workOrderNumber: $workOrderNumber')
          ..write(')'))
        .toString();
  }
}

class $IndustryBriefingTable extends IndustryBriefing
    with TableInfo<$IndustryBriefingTable, IndustryBriefingData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IndustryBriefingTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _previewImageMeta =
      const VerificationMeta('previewImage');
  @override
  late final GeneratedColumn<String> previewImage = GeneratedColumn<String>(
      'preview_image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _publishedAtMeta =
      const VerificationMeta('publishedAt');
  @override
  late final GeneratedColumn<DateTime> publishedAt = GeneratedColumn<DateTime>(
      'published_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _fetchedAtMeta =
      const VerificationMeta('fetchedAt');
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
      'fetched_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, source, previewImage, publishedAt, fetchedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'industry_briefing';
  @override
  VerificationContext validateIntegrity(
      Insertable<IndustryBriefingData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('preview_image')) {
      context.handle(
          _previewImageMeta,
          previewImage.isAcceptableOrUnknown(
              data['preview_image']!, _previewImageMeta));
    }
    if (data.containsKey('published_at')) {
      context.handle(
          _publishedAtMeta,
          publishedAt.isAcceptableOrUnknown(
              data['published_at']!, _publishedAtMeta));
    } else if (isInserting) {
      context.missing(_publishedAtMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(_fetchedAtMeta,
          fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta));
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IndustryBriefingData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IndustryBriefingData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      previewImage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}preview_image']),
      publishedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}published_at'])!,
      fetchedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fetched_at'])!,
    );
  }

  @override
  $IndustryBriefingTable createAlias(String alias) {
    return $IndustryBriefingTable(attachedDatabase, alias);
  }
}

class IndustryBriefingData extends DataClass
    implements Insertable<IndustryBriefingData> {
  final int id;
  final String title;
  final String source;
  final String? previewImage;
  final DateTime publishedAt;
  final DateTime fetchedAt;
  const IndustryBriefingData(
      {required this.id,
      required this.title,
      required this.source,
      this.previewImage,
      required this.publishedAt,
      required this.fetchedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || previewImage != null) {
      map['preview_image'] = Variable<String>(previewImage);
    }
    map['published_at'] = Variable<DateTime>(publishedAt);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    return map;
  }

  IndustryBriefingCompanion toCompanion(bool nullToAbsent) {
    return IndustryBriefingCompanion(
      id: Value(id),
      title: Value(title),
      source: Value(source),
      previewImage: previewImage == null && nullToAbsent
          ? const Value.absent()
          : Value(previewImage),
      publishedAt: Value(publishedAt),
      fetchedAt: Value(fetchedAt),
    );
  }

  factory IndustryBriefingData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IndustryBriefingData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      source: serializer.fromJson<String>(json['source']),
      previewImage: serializer.fromJson<String?>(json['previewImage']),
      publishedAt: serializer.fromJson<DateTime>(json['publishedAt']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'source': serializer.toJson<String>(source),
      'previewImage': serializer.toJson<String?>(previewImage),
      'publishedAt': serializer.toJson<DateTime>(publishedAt),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
    };
  }

  IndustryBriefingData copyWith(
          {int? id,
          String? title,
          String? source,
          Value<String?> previewImage = const Value.absent(),
          DateTime? publishedAt,
          DateTime? fetchedAt}) =>
      IndustryBriefingData(
        id: id ?? this.id,
        title: title ?? this.title,
        source: source ?? this.source,
        previewImage:
            previewImage.present ? previewImage.value : this.previewImage,
        publishedAt: publishedAt ?? this.publishedAt,
        fetchedAt: fetchedAt ?? this.fetchedAt,
      );
  IndustryBriefingData copyWithCompanion(IndustryBriefingCompanion data) {
    return IndustryBriefingData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      source: data.source.present ? data.source.value : this.source,
      previewImage: data.previewImage.present
          ? data.previewImage.value
          : this.previewImage,
      publishedAt:
          data.publishedAt.present ? data.publishedAt.value : this.publishedAt,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IndustryBriefingData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('source: $source, ')
          ..write('previewImage: $previewImage, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, source, previewImage, publishedAt, fetchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IndustryBriefingData &&
          other.id == this.id &&
          other.title == this.title &&
          other.source == this.source &&
          other.previewImage == this.previewImage &&
          other.publishedAt == this.publishedAt &&
          other.fetchedAt == this.fetchedAt);
}

class IndustryBriefingCompanion extends UpdateCompanion<IndustryBriefingData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> source;
  final Value<String?> previewImage;
  final Value<DateTime> publishedAt;
  final Value<DateTime> fetchedAt;
  const IndustryBriefingCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.source = const Value.absent(),
    this.previewImage = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.fetchedAt = const Value.absent(),
  });
  IndustryBriefingCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String source,
    this.previewImage = const Value.absent(),
    required DateTime publishedAt,
    required DateTime fetchedAt,
  })  : title = Value(title),
        source = Value(source),
        publishedAt = Value(publishedAt),
        fetchedAt = Value(fetchedAt);
  static Insertable<IndustryBriefingData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? source,
    Expression<String>? previewImage,
    Expression<DateTime>? publishedAt,
    Expression<DateTime>? fetchedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (source != null) 'source': source,
      if (previewImage != null) 'preview_image': previewImage,
      if (publishedAt != null) 'published_at': publishedAt,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
    });
  }

  IndustryBriefingCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? source,
      Value<String?>? previewImage,
      Value<DateTime>? publishedAt,
      Value<DateTime>? fetchedAt}) {
    return IndustryBriefingCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      source: source ?? this.source,
      previewImage: previewImage ?? this.previewImage,
      publishedAt: publishedAt ?? this.publishedAt,
      fetchedAt: fetchedAt ?? this.fetchedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (previewImage.present) {
      map['preview_image'] = Variable<String>(previewImage.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<DateTime>(publishedAt.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IndustryBriefingCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('source: $source, ')
          ..write('previewImage: $previewImage, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }
}

class $CompanyAnnouncementsTable extends CompanyAnnouncements
    with TableInfo<$CompanyAnnouncementsTable, CompanyAnnouncement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompanyAnnouncementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
      'body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _actionLabelMeta =
      const VerificationMeta('actionLabel');
  @override
  late final GeneratedColumn<String> actionLabel = GeneratedColumn<String>(
      'action_label', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
      'active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _publishedAtMeta =
      const VerificationMeta('publishedAt');
  @override
  late final GeneratedColumn<DateTime> publishedAt = GeneratedColumn<DateTime>(
      'published_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _acknowledgedMeta =
      const VerificationMeta('acknowledged');
  @override
  late final GeneratedColumn<bool> acknowledged = GeneratedColumn<bool>(
      'acknowledged', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("acknowledged" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _acknowledgedAtMeta =
      const VerificationMeta('acknowledgedAt');
  @override
  late final GeneratedColumn<DateTime> acknowledgedAt =
      GeneratedColumn<DateTime>('acknowledged_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        category,
        title,
        body,
        actionLabel,
        active,
        publishedAt,
        acknowledged,
        acknowledgedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'company_announcements';
  @override
  VerificationContext validateIntegrity(
      Insertable<CompanyAnnouncement> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('action_label')) {
      context.handle(
          _actionLabelMeta,
          actionLabel.isAcceptableOrUnknown(
              data['action_label']!, _actionLabelMeta));
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta,
          active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    if (data.containsKey('published_at')) {
      context.handle(
          _publishedAtMeta,
          publishedAt.isAcceptableOrUnknown(
              data['published_at']!, _publishedAtMeta));
    } else if (isInserting) {
      context.missing(_publishedAtMeta);
    }
    if (data.containsKey('acknowledged')) {
      context.handle(
          _acknowledgedMeta,
          acknowledged.isAcceptableOrUnknown(
              data['acknowledged']!, _acknowledgedMeta));
    }
    if (data.containsKey('acknowledged_at')) {
      context.handle(
          _acknowledgedAtMeta,
          acknowledgedAt.isAcceptableOrUnknown(
              data['acknowledged_at']!, _acknowledgedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CompanyAnnouncement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompanyAnnouncement(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      body: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body'])!,
      actionLabel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}action_label']),
      active: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
      publishedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}published_at'])!,
      acknowledged: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}acknowledged'])!,
      acknowledgedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}acknowledged_at']),
    );
  }

  @override
  $CompanyAnnouncementsTable createAlias(String alias) {
    return $CompanyAnnouncementsTable(attachedDatabase, alias);
  }
}

class CompanyAnnouncement extends DataClass
    implements Insertable<CompanyAnnouncement> {
  final int id;
  final String category;
  final String title;
  final String body;
  final String? actionLabel;
  final bool active;
  final DateTime publishedAt;
  final bool acknowledged;
  final DateTime? acknowledgedAt;
  const CompanyAnnouncement(
      {required this.id,
      required this.category,
      required this.title,
      required this.body,
      this.actionLabel,
      required this.active,
      required this.publishedAt,
      required this.acknowledged,
      this.acknowledgedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category'] = Variable<String>(category);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    if (!nullToAbsent || actionLabel != null) {
      map['action_label'] = Variable<String>(actionLabel);
    }
    map['active'] = Variable<bool>(active);
    map['published_at'] = Variable<DateTime>(publishedAt);
    map['acknowledged'] = Variable<bool>(acknowledged);
    if (!nullToAbsent || acknowledgedAt != null) {
      map['acknowledged_at'] = Variable<DateTime>(acknowledgedAt);
    }
    return map;
  }

  CompanyAnnouncementsCompanion toCompanion(bool nullToAbsent) {
    return CompanyAnnouncementsCompanion(
      id: Value(id),
      category: Value(category),
      title: Value(title),
      body: Value(body),
      actionLabel: actionLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(actionLabel),
      active: Value(active),
      publishedAt: Value(publishedAt),
      acknowledged: Value(acknowledged),
      acknowledgedAt: acknowledgedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(acknowledgedAt),
    );
  }

  factory CompanyAnnouncement.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompanyAnnouncement(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      actionLabel: serializer.fromJson<String?>(json['actionLabel']),
      active: serializer.fromJson<bool>(json['active']),
      publishedAt: serializer.fromJson<DateTime>(json['publishedAt']),
      acknowledged: serializer.fromJson<bool>(json['acknowledged']),
      acknowledgedAt: serializer.fromJson<DateTime?>(json['acknowledgedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<String>(category),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'actionLabel': serializer.toJson<String?>(actionLabel),
      'active': serializer.toJson<bool>(active),
      'publishedAt': serializer.toJson<DateTime>(publishedAt),
      'acknowledged': serializer.toJson<bool>(acknowledged),
      'acknowledgedAt': serializer.toJson<DateTime?>(acknowledgedAt),
    };
  }

  CompanyAnnouncement copyWith(
          {int? id,
          String? category,
          String? title,
          String? body,
          Value<String?> actionLabel = const Value.absent(),
          bool? active,
          DateTime? publishedAt,
          bool? acknowledged,
          Value<DateTime?> acknowledgedAt = const Value.absent()}) =>
      CompanyAnnouncement(
        id: id ?? this.id,
        category: category ?? this.category,
        title: title ?? this.title,
        body: body ?? this.body,
        actionLabel: actionLabel.present ? actionLabel.value : this.actionLabel,
        active: active ?? this.active,
        publishedAt: publishedAt ?? this.publishedAt,
        acknowledged: acknowledged ?? this.acknowledged,
        acknowledgedAt:
            acknowledgedAt.present ? acknowledgedAt.value : this.acknowledgedAt,
      );
  CompanyAnnouncement copyWithCompanion(CompanyAnnouncementsCompanion data) {
    return CompanyAnnouncement(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      actionLabel:
          data.actionLabel.present ? data.actionLabel.value : this.actionLabel,
      active: data.active.present ? data.active.value : this.active,
      publishedAt:
          data.publishedAt.present ? data.publishedAt.value : this.publishedAt,
      acknowledged: data.acknowledged.present
          ? data.acknowledged.value
          : this.acknowledged,
      acknowledgedAt: data.acknowledgedAt.present
          ? data.acknowledgedAt.value
          : this.acknowledgedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompanyAnnouncement(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('actionLabel: $actionLabel, ')
          ..write('active: $active, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('acknowledged: $acknowledged, ')
          ..write('acknowledgedAt: $acknowledgedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, category, title, body, actionLabel,
      active, publishedAt, acknowledged, acknowledgedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompanyAnnouncement &&
          other.id == this.id &&
          other.category == this.category &&
          other.title == this.title &&
          other.body == this.body &&
          other.actionLabel == this.actionLabel &&
          other.active == this.active &&
          other.publishedAt == this.publishedAt &&
          other.acknowledged == this.acknowledged &&
          other.acknowledgedAt == this.acknowledgedAt);
}

class CompanyAnnouncementsCompanion
    extends UpdateCompanion<CompanyAnnouncement> {
  final Value<int> id;
  final Value<String> category;
  final Value<String> title;
  final Value<String> body;
  final Value<String?> actionLabel;
  final Value<bool> active;
  final Value<DateTime> publishedAt;
  final Value<bool> acknowledged;
  final Value<DateTime?> acknowledgedAt;
  const CompanyAnnouncementsCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.actionLabel = const Value.absent(),
    this.active = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.acknowledged = const Value.absent(),
    this.acknowledgedAt = const Value.absent(),
  });
  CompanyAnnouncementsCompanion.insert({
    this.id = const Value.absent(),
    required String category,
    required String title,
    required String body,
    this.actionLabel = const Value.absent(),
    this.active = const Value.absent(),
    required DateTime publishedAt,
    this.acknowledged = const Value.absent(),
    this.acknowledgedAt = const Value.absent(),
  })  : category = Value(category),
        title = Value(title),
        body = Value(body),
        publishedAt = Value(publishedAt);
  static Insertable<CompanyAnnouncement> custom({
    Expression<int>? id,
    Expression<String>? category,
    Expression<String>? title,
    Expression<String>? body,
    Expression<String>? actionLabel,
    Expression<bool>? active,
    Expression<DateTime>? publishedAt,
    Expression<bool>? acknowledged,
    Expression<DateTime>? acknowledgedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (actionLabel != null) 'action_label': actionLabel,
      if (active != null) 'active': active,
      if (publishedAt != null) 'published_at': publishedAt,
      if (acknowledged != null) 'acknowledged': acknowledged,
      if (acknowledgedAt != null) 'acknowledged_at': acknowledgedAt,
    });
  }

  CompanyAnnouncementsCompanion copyWith(
      {Value<int>? id,
      Value<String>? category,
      Value<String>? title,
      Value<String>? body,
      Value<String?>? actionLabel,
      Value<bool>? active,
      Value<DateTime>? publishedAt,
      Value<bool>? acknowledged,
      Value<DateTime?>? acknowledgedAt}) {
    return CompanyAnnouncementsCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      title: title ?? this.title,
      body: body ?? this.body,
      actionLabel: actionLabel ?? this.actionLabel,
      active: active ?? this.active,
      publishedAt: publishedAt ?? this.publishedAt,
      acknowledged: acknowledged ?? this.acknowledged,
      acknowledgedAt: acknowledgedAt ?? this.acknowledgedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (actionLabel.present) {
      map['action_label'] = Variable<String>(actionLabel.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<DateTime>(publishedAt.value);
    }
    if (acknowledged.present) {
      map['acknowledged'] = Variable<bool>(acknowledged.value);
    }
    if (acknowledgedAt.present) {
      map['acknowledged_at'] = Variable<DateTime>(acknowledgedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompanyAnnouncementsCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('actionLabel: $actionLabel, ')
          ..write('active: $active, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('acknowledged: $acknowledged, ')
          ..write('acknowledgedAt: $acknowledgedAt')
          ..write(')'))
        .toString();
  }
}

class $WorkOrdersTable extends WorkOrders
    with TableInfo<$WorkOrdersTable, WorkOrder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkOrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _siteIdMeta = const VerificationMeta('siteId');
  @override
  late final GeneratedColumn<int> siteId = GeneratedColumn<int>(
      'site_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
      'priority', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionOfWorkMeta =
      const VerificationMeta('descriptionOfWork');
  @override
  late final GeneratedColumn<String> descriptionOfWork =
      GeneratedColumn<String>('description_of_work', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _internalNotesMeta =
      const VerificationMeta('internalNotes');
  @override
  late final GeneratedColumn<String> internalNotes = GeneratedColumn<String>(
      'internal_notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _closedAtMeta =
      const VerificationMeta('closedAt');
  @override
  late final GeneratedColumn<DateTime> closedAt = GeneratedColumn<DateTime>(
      'closed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdByMeta =
      const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
      'created_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _assignedTechnicianMeta =
      const VerificationMeta('assignedTechnician');
  @override
  late final GeneratedColumn<String> assignedTechnician =
      GeneratedColumn<String>('assigned_technician', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        siteId,
        status,
        priority,
        descriptionOfWork,
        internalNotes,
        createdAt,
        closedAt,
        createdBy,
        assignedTechnician
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'work_orders';
  @override
  VerificationContext validateIntegrity(Insertable<WorkOrder> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('site_id')) {
      context.handle(_siteIdMeta,
          siteId.isAcceptableOrUnknown(data['site_id']!, _siteIdMeta));
    } else if (isInserting) {
      context.missing(_siteIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    if (data.containsKey('description_of_work')) {
      context.handle(
          _descriptionOfWorkMeta,
          descriptionOfWork.isAcceptableOrUnknown(
              data['description_of_work']!, _descriptionOfWorkMeta));
    }
    if (data.containsKey('internal_notes')) {
      context.handle(
          _internalNotesMeta,
          internalNotes.isAcceptableOrUnknown(
              data['internal_notes']!, _internalNotesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('closed_at')) {
      context.handle(_closedAtMeta,
          closedAt.isAcceptableOrUnknown(data['closed_at']!, _closedAtMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta));
    }
    if (data.containsKey('assigned_technician')) {
      context.handle(
          _assignedTechnicianMeta,
          assignedTechnician.isAcceptableOrUnknown(
              data['assigned_technician']!, _assignedTechnicianMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkOrder(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      siteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}site_id'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}priority']),
      descriptionOfWork: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}description_of_work']),
      internalNotes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}internal_notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      closedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}closed_at']),
      createdBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_by']),
      assignedTechnician: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}assigned_technician']),
    );
  }

  @override
  $WorkOrdersTable createAlias(String alias) {
    return $WorkOrdersTable(attachedDatabase, alias);
  }
}

class WorkOrder extends DataClass implements Insertable<WorkOrder> {
  final int id;
  final int siteId;
  final String status;
  final String? priority;
  final String? descriptionOfWork;
  final String? internalNotes;
  final DateTime createdAt;
  final DateTime? closedAt;
  final String? createdBy;
  final String? assignedTechnician;
  const WorkOrder(
      {required this.id,
      required this.siteId,
      required this.status,
      this.priority,
      this.descriptionOfWork,
      this.internalNotes,
      required this.createdAt,
      this.closedAt,
      this.createdBy,
      this.assignedTechnician});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['site_id'] = Variable<int>(siteId);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || priority != null) {
      map['priority'] = Variable<String>(priority);
    }
    if (!nullToAbsent || descriptionOfWork != null) {
      map['description_of_work'] = Variable<String>(descriptionOfWork);
    }
    if (!nullToAbsent || internalNotes != null) {
      map['internal_notes'] = Variable<String>(internalNotes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || closedAt != null) {
      map['closed_at'] = Variable<DateTime>(closedAt);
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || assignedTechnician != null) {
      map['assigned_technician'] = Variable<String>(assignedTechnician);
    }
    return map;
  }

  WorkOrdersCompanion toCompanion(bool nullToAbsent) {
    return WorkOrdersCompanion(
      id: Value(id),
      siteId: Value(siteId),
      status: Value(status),
      priority: priority == null && nullToAbsent
          ? const Value.absent()
          : Value(priority),
      descriptionOfWork: descriptionOfWork == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionOfWork),
      internalNotes: internalNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(internalNotes),
      createdAt: Value(createdAt),
      closedAt: closedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(closedAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      assignedTechnician: assignedTechnician == null && nullToAbsent
          ? const Value.absent()
          : Value(assignedTechnician),
    );
  }

  factory WorkOrder.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkOrder(
      id: serializer.fromJson<int>(json['id']),
      siteId: serializer.fromJson<int>(json['siteId']),
      status: serializer.fromJson<String>(json['status']),
      priority: serializer.fromJson<String?>(json['priority']),
      descriptionOfWork:
          serializer.fromJson<String?>(json['descriptionOfWork']),
      internalNotes: serializer.fromJson<String?>(json['internalNotes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      closedAt: serializer.fromJson<DateTime?>(json['closedAt']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      assignedTechnician:
          serializer.fromJson<String?>(json['assignedTechnician']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'siteId': serializer.toJson<int>(siteId),
      'status': serializer.toJson<String>(status),
      'priority': serializer.toJson<String?>(priority),
      'descriptionOfWork': serializer.toJson<String?>(descriptionOfWork),
      'internalNotes': serializer.toJson<String?>(internalNotes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'closedAt': serializer.toJson<DateTime?>(closedAt),
      'createdBy': serializer.toJson<String?>(createdBy),
      'assignedTechnician': serializer.toJson<String?>(assignedTechnician),
    };
  }

  WorkOrder copyWith(
          {int? id,
          int? siteId,
          String? status,
          Value<String?> priority = const Value.absent(),
          Value<String?> descriptionOfWork = const Value.absent(),
          Value<String?> internalNotes = const Value.absent(),
          DateTime? createdAt,
          Value<DateTime?> closedAt = const Value.absent(),
          Value<String?> createdBy = const Value.absent(),
          Value<String?> assignedTechnician = const Value.absent()}) =>
      WorkOrder(
        id: id ?? this.id,
        siteId: siteId ?? this.siteId,
        status: status ?? this.status,
        priority: priority.present ? priority.value : this.priority,
        descriptionOfWork: descriptionOfWork.present
            ? descriptionOfWork.value
            : this.descriptionOfWork,
        internalNotes:
            internalNotes.present ? internalNotes.value : this.internalNotes,
        createdAt: createdAt ?? this.createdAt,
        closedAt: closedAt.present ? closedAt.value : this.closedAt,
        createdBy: createdBy.present ? createdBy.value : this.createdBy,
        assignedTechnician: assignedTechnician.present
            ? assignedTechnician.value
            : this.assignedTechnician,
      );
  WorkOrder copyWithCompanion(WorkOrdersCompanion data) {
    return WorkOrder(
      id: data.id.present ? data.id.value : this.id,
      siteId: data.siteId.present ? data.siteId.value : this.siteId,
      status: data.status.present ? data.status.value : this.status,
      priority: data.priority.present ? data.priority.value : this.priority,
      descriptionOfWork: data.descriptionOfWork.present
          ? data.descriptionOfWork.value
          : this.descriptionOfWork,
      internalNotes: data.internalNotes.present
          ? data.internalNotes.value
          : this.internalNotes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      closedAt: data.closedAt.present ? data.closedAt.value : this.closedAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      assignedTechnician: data.assignedTechnician.present
          ? data.assignedTechnician.value
          : this.assignedTechnician,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkOrder(')
          ..write('id: $id, ')
          ..write('siteId: $siteId, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('descriptionOfWork: $descriptionOfWork, ')
          ..write('internalNotes: $internalNotes, ')
          ..write('createdAt: $createdAt, ')
          ..write('closedAt: $closedAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('assignedTechnician: $assignedTechnician')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      siteId,
      status,
      priority,
      descriptionOfWork,
      internalNotes,
      createdAt,
      closedAt,
      createdBy,
      assignedTechnician);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkOrder &&
          other.id == this.id &&
          other.siteId == this.siteId &&
          other.status == this.status &&
          other.priority == this.priority &&
          other.descriptionOfWork == this.descriptionOfWork &&
          other.internalNotes == this.internalNotes &&
          other.createdAt == this.createdAt &&
          other.closedAt == this.closedAt &&
          other.createdBy == this.createdBy &&
          other.assignedTechnician == this.assignedTechnician);
}

class WorkOrdersCompanion extends UpdateCompanion<WorkOrder> {
  final Value<int> id;
  final Value<int> siteId;
  final Value<String> status;
  final Value<String?> priority;
  final Value<String?> descriptionOfWork;
  final Value<String?> internalNotes;
  final Value<DateTime> createdAt;
  final Value<DateTime?> closedAt;
  final Value<String?> createdBy;
  final Value<String?> assignedTechnician;
  const WorkOrdersCompanion({
    this.id = const Value.absent(),
    this.siteId = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.descriptionOfWork = const Value.absent(),
    this.internalNotes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.assignedTechnician = const Value.absent(),
  });
  WorkOrdersCompanion.insert({
    this.id = const Value.absent(),
    required int siteId,
    required String status,
    this.priority = const Value.absent(),
    this.descriptionOfWork = const Value.absent(),
    this.internalNotes = const Value.absent(),
    required DateTime createdAt,
    this.closedAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.assignedTechnician = const Value.absent(),
  })  : siteId = Value(siteId),
        status = Value(status),
        createdAt = Value(createdAt);
  static Insertable<WorkOrder> custom({
    Expression<int>? id,
    Expression<int>? siteId,
    Expression<String>? status,
    Expression<String>? priority,
    Expression<String>? descriptionOfWork,
    Expression<String>? internalNotes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? closedAt,
    Expression<String>? createdBy,
    Expression<String>? assignedTechnician,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (siteId != null) 'site_id': siteId,
      if (status != null) 'status': status,
      if (priority != null) 'priority': priority,
      if (descriptionOfWork != null) 'description_of_work': descriptionOfWork,
      if (internalNotes != null) 'internal_notes': internalNotes,
      if (createdAt != null) 'created_at': createdAt,
      if (closedAt != null) 'closed_at': closedAt,
      if (createdBy != null) 'created_by': createdBy,
      if (assignedTechnician != null) 'assigned_technician': assignedTechnician,
    });
  }

  WorkOrdersCompanion copyWith(
      {Value<int>? id,
      Value<int>? siteId,
      Value<String>? status,
      Value<String?>? priority,
      Value<String?>? descriptionOfWork,
      Value<String?>? internalNotes,
      Value<DateTime>? createdAt,
      Value<DateTime?>? closedAt,
      Value<String?>? createdBy,
      Value<String?>? assignedTechnician}) {
    return WorkOrdersCompanion(
      id: id ?? this.id,
      siteId: siteId ?? this.siteId,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      descriptionOfWork: descriptionOfWork ?? this.descriptionOfWork,
      internalNotes: internalNotes ?? this.internalNotes,
      createdAt: createdAt ?? this.createdAt,
      closedAt: closedAt ?? this.closedAt,
      createdBy: createdBy ?? this.createdBy,
      assignedTechnician: assignedTechnician ?? this.assignedTechnician,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (siteId.present) {
      map['site_id'] = Variable<int>(siteId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (descriptionOfWork.present) {
      map['description_of_work'] = Variable<String>(descriptionOfWork.value);
    }
    if (internalNotes.present) {
      map['internal_notes'] = Variable<String>(internalNotes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (closedAt.present) {
      map['closed_at'] = Variable<DateTime>(closedAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (assignedTechnician.present) {
      map['assigned_technician'] = Variable<String>(assignedTechnician.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkOrdersCompanion(')
          ..write('id: $id, ')
          ..write('siteId: $siteId, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('descriptionOfWork: $descriptionOfWork, ')
          ..write('internalNotes: $internalNotes, ')
          ..write('createdAt: $createdAt, ')
          ..write('closedAt: $closedAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('assignedTechnician: $assignedTechnician')
          ..write(')'))
        .toString();
  }
}

class $AppointmentsTable extends Appointments
    with TableInfo<$AppointmentsTable, Appointment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppointmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _workOrderIdMeta =
      const VerificationMeta('workOrderId');
  @override
  late final GeneratedColumn<int> workOrderId = GeneratedColumn<int>(
      'work_order_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _scheduledStartMeta =
      const VerificationMeta('scheduledStart');
  @override
  late final GeneratedColumn<DateTime> scheduledStart =
      GeneratedColumn<DateTime>('scheduled_start', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _expectedDurationMinutesMeta =
      const VerificationMeta('expectedDurationMinutes');
  @override
  late final GeneratedColumn<int> expectedDurationMinutes =
      GeneratedColumn<int>('expected_duration_minutes', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _technicianMeta =
      const VerificationMeta('technician');
  @override
  late final GeneratedColumn<String> technician = GeneratedColumn<String>(
      'technician', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, workOrderId, scheduledStart, expectedDurationMinutes, technician];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'appointments';
  @override
  VerificationContext validateIntegrity(Insertable<Appointment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('work_order_id')) {
      context.handle(
          _workOrderIdMeta,
          workOrderId.isAcceptableOrUnknown(
              data['work_order_id']!, _workOrderIdMeta));
    } else if (isInserting) {
      context.missing(_workOrderIdMeta);
    }
    if (data.containsKey('scheduled_start')) {
      context.handle(
          _scheduledStartMeta,
          scheduledStart.isAcceptableOrUnknown(
              data['scheduled_start']!, _scheduledStartMeta));
    } else if (isInserting) {
      context.missing(_scheduledStartMeta);
    }
    if (data.containsKey('expected_duration_minutes')) {
      context.handle(
          _expectedDurationMinutesMeta,
          expectedDurationMinutes.isAcceptableOrUnknown(
              data['expected_duration_minutes']!,
              _expectedDurationMinutesMeta));
    }
    if (data.containsKey('technician')) {
      context.handle(
          _technicianMeta,
          technician.isAcceptableOrUnknown(
              data['technician']!, _technicianMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Appointment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Appointment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      workOrderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}work_order_id'])!,
      scheduledStart: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}scheduled_start'])!,
      expectedDurationMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}expected_duration_minutes']),
      technician: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}technician']),
    );
  }

  @override
  $AppointmentsTable createAlias(String alias) {
    return $AppointmentsTable(attachedDatabase, alias);
  }
}

class Appointment extends DataClass implements Insertable<Appointment> {
  final int id;
  final int workOrderId;
  final DateTime scheduledStart;
  final int? expectedDurationMinutes;
  final String? technician;
  const Appointment(
      {required this.id,
      required this.workOrderId,
      required this.scheduledStart,
      this.expectedDurationMinutes,
      this.technician});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['work_order_id'] = Variable<int>(workOrderId);
    map['scheduled_start'] = Variable<DateTime>(scheduledStart);
    if (!nullToAbsent || expectedDurationMinutes != null) {
      map['expected_duration_minutes'] = Variable<int>(expectedDurationMinutes);
    }
    if (!nullToAbsent || technician != null) {
      map['technician'] = Variable<String>(technician);
    }
    return map;
  }

  AppointmentsCompanion toCompanion(bool nullToAbsent) {
    return AppointmentsCompanion(
      id: Value(id),
      workOrderId: Value(workOrderId),
      scheduledStart: Value(scheduledStart),
      expectedDurationMinutes: expectedDurationMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedDurationMinutes),
      technician: technician == null && nullToAbsent
          ? const Value.absent()
          : Value(technician),
    );
  }

  factory Appointment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Appointment(
      id: serializer.fromJson<int>(json['id']),
      workOrderId: serializer.fromJson<int>(json['workOrderId']),
      scheduledStart: serializer.fromJson<DateTime>(json['scheduledStart']),
      expectedDurationMinutes:
          serializer.fromJson<int?>(json['expectedDurationMinutes']),
      technician: serializer.fromJson<String?>(json['technician']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'workOrderId': serializer.toJson<int>(workOrderId),
      'scheduledStart': serializer.toJson<DateTime>(scheduledStart),
      'expectedDurationMinutes':
          serializer.toJson<int?>(expectedDurationMinutes),
      'technician': serializer.toJson<String?>(technician),
    };
  }

  Appointment copyWith(
          {int? id,
          int? workOrderId,
          DateTime? scheduledStart,
          Value<int?> expectedDurationMinutes = const Value.absent(),
          Value<String?> technician = const Value.absent()}) =>
      Appointment(
        id: id ?? this.id,
        workOrderId: workOrderId ?? this.workOrderId,
        scheduledStart: scheduledStart ?? this.scheduledStart,
        expectedDurationMinutes: expectedDurationMinutes.present
            ? expectedDurationMinutes.value
            : this.expectedDurationMinutes,
        technician: technician.present ? technician.value : this.technician,
      );
  Appointment copyWithCompanion(AppointmentsCompanion data) {
    return Appointment(
      id: data.id.present ? data.id.value : this.id,
      workOrderId:
          data.workOrderId.present ? data.workOrderId.value : this.workOrderId,
      scheduledStart: data.scheduledStart.present
          ? data.scheduledStart.value
          : this.scheduledStart,
      expectedDurationMinutes: data.expectedDurationMinutes.present
          ? data.expectedDurationMinutes.value
          : this.expectedDurationMinutes,
      technician:
          data.technician.present ? data.technician.value : this.technician,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Appointment(')
          ..write('id: $id, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('scheduledStart: $scheduledStart, ')
          ..write('expectedDurationMinutes: $expectedDurationMinutes, ')
          ..write('technician: $technician')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, workOrderId, scheduledStart, expectedDurationMinutes, technician);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Appointment &&
          other.id == this.id &&
          other.workOrderId == this.workOrderId &&
          other.scheduledStart == this.scheduledStart &&
          other.expectedDurationMinutes == this.expectedDurationMinutes &&
          other.technician == this.technician);
}

class AppointmentsCompanion extends UpdateCompanion<Appointment> {
  final Value<int> id;
  final Value<int> workOrderId;
  final Value<DateTime> scheduledStart;
  final Value<int?> expectedDurationMinutes;
  final Value<String?> technician;
  const AppointmentsCompanion({
    this.id = const Value.absent(),
    this.workOrderId = const Value.absent(),
    this.scheduledStart = const Value.absent(),
    this.expectedDurationMinutes = const Value.absent(),
    this.technician = const Value.absent(),
  });
  AppointmentsCompanion.insert({
    this.id = const Value.absent(),
    required int workOrderId,
    required DateTime scheduledStart,
    this.expectedDurationMinutes = const Value.absent(),
    this.technician = const Value.absent(),
  })  : workOrderId = Value(workOrderId),
        scheduledStart = Value(scheduledStart);
  static Insertable<Appointment> custom({
    Expression<int>? id,
    Expression<int>? workOrderId,
    Expression<DateTime>? scheduledStart,
    Expression<int>? expectedDurationMinutes,
    Expression<String>? technician,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workOrderId != null) 'work_order_id': workOrderId,
      if (scheduledStart != null) 'scheduled_start': scheduledStart,
      if (expectedDurationMinutes != null)
        'expected_duration_minutes': expectedDurationMinutes,
      if (technician != null) 'technician': technician,
    });
  }

  AppointmentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? workOrderId,
      Value<DateTime>? scheduledStart,
      Value<int?>? expectedDurationMinutes,
      Value<String?>? technician}) {
    return AppointmentsCompanion(
      id: id ?? this.id,
      workOrderId: workOrderId ?? this.workOrderId,
      scheduledStart: scheduledStart ?? this.scheduledStart,
      expectedDurationMinutes:
          expectedDurationMinutes ?? this.expectedDurationMinutes,
      technician: technician ?? this.technician,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (workOrderId.present) {
      map['work_order_id'] = Variable<int>(workOrderId.value);
    }
    if (scheduledStart.present) {
      map['scheduled_start'] = Variable<DateTime>(scheduledStart.value);
    }
    if (expectedDurationMinutes.present) {
      map['expected_duration_minutes'] =
          Variable<int>(expectedDurationMinutes.value);
    }
    if (technician.present) {
      map['technician'] = Variable<String>(technician.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppointmentsCompanion(')
          ..write('id: $id, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('scheduledStart: $scheduledStart, ')
          ..write('expectedDurationMinutes: $expectedDurationMinutes, ')
          ..write('technician: $technician')
          ..write(')'))
        .toString();
  }
}

class $EquipmentTable extends Equipment
    with TableInfo<$EquipmentTable, EquipmentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EquipmentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _siteIdMeta = const VerificationMeta('siteId');
  @override
  late final GeneratedColumn<int> siteId = GeneratedColumn<int>(
      'site_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _machineProfileIdMeta =
      const VerificationMeta('machineProfileId');
  @override
  late final GeneratedColumn<int> machineProfileId = GeneratedColumn<int>(
      'machine_profile_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _equipmentTypeMeta =
      const VerificationMeta('equipmentType');
  @override
  late final GeneratedColumn<String> equipmentType = GeneratedColumn<String>(
      'equipment_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _manufacturerMeta =
      const VerificationMeta('manufacturer');
  @override
  late final GeneratedColumn<String> manufacturer = GeneratedColumn<String>(
      'manufacturer', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
      'model', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _serialNumberMeta =
      const VerificationMeta('serialNumber');
  @override
  late final GeneratedColumn<String> serialNumber = GeneratedColumn<String>(
      'serial_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _underWarrantyMeta =
      const VerificationMeta('underWarranty');
  @override
  late final GeneratedColumn<bool> underWarranty = GeneratedColumn<bool>(
      'under_warranty', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("under_warranty" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _underServiceContractMeta =
      const VerificationMeta('underServiceContract');
  @override
  late final GeneratedColumn<bool> underServiceContract = GeneratedColumn<bool>(
      'under_service_contract', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("under_service_contract" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _contractReferenceMeta =
      const VerificationMeta('contractReference');
  @override
  late final GeneratedColumn<String> contractReference =
      GeneratedColumn<String>('contract_reference', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
      'active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        siteId,
        machineProfileId,
        equipmentType,
        manufacturer,
        model,
        serialNumber,
        underWarranty,
        underServiceContract,
        contractReference,
        active
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'equipment';
  @override
  VerificationContext validateIntegrity(Insertable<EquipmentData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('site_id')) {
      context.handle(_siteIdMeta,
          siteId.isAcceptableOrUnknown(data['site_id']!, _siteIdMeta));
    } else if (isInserting) {
      context.missing(_siteIdMeta);
    }
    if (data.containsKey('machine_profile_id')) {
      context.handle(
          _machineProfileIdMeta,
          machineProfileId.isAcceptableOrUnknown(
              data['machine_profile_id']!, _machineProfileIdMeta));
    }
    if (data.containsKey('equipment_type')) {
      context.handle(
          _equipmentTypeMeta,
          equipmentType.isAcceptableOrUnknown(
              data['equipment_type']!, _equipmentTypeMeta));
    } else if (isInserting) {
      context.missing(_equipmentTypeMeta);
    }
    if (data.containsKey('manufacturer')) {
      context.handle(
          _manufacturerMeta,
          manufacturer.isAcceptableOrUnknown(
              data['manufacturer']!, _manufacturerMeta));
    }
    if (data.containsKey('model')) {
      context.handle(
          _modelMeta, model.isAcceptableOrUnknown(data['model']!, _modelMeta));
    }
    if (data.containsKey('serial_number')) {
      context.handle(
          _serialNumberMeta,
          serialNumber.isAcceptableOrUnknown(
              data['serial_number']!, _serialNumberMeta));
    }
    if (data.containsKey('under_warranty')) {
      context.handle(
          _underWarrantyMeta,
          underWarranty.isAcceptableOrUnknown(
              data['under_warranty']!, _underWarrantyMeta));
    }
    if (data.containsKey('under_service_contract')) {
      context.handle(
          _underServiceContractMeta,
          underServiceContract.isAcceptableOrUnknown(
              data['under_service_contract']!, _underServiceContractMeta));
    }
    if (data.containsKey('contract_reference')) {
      context.handle(
          _contractReferenceMeta,
          contractReference.isAcceptableOrUnknown(
              data['contract_reference']!, _contractReferenceMeta));
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta,
          active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EquipmentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EquipmentData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      siteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}site_id'])!,
      machineProfileId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}machine_profile_id']),
      equipmentType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}equipment_type'])!,
      manufacturer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}manufacturer']),
      model: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}model']),
      serialNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}serial_number']),
      underWarranty: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}under_warranty'])!,
      underServiceContract: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}under_service_contract'])!,
      contractReference: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}contract_reference']),
      active: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
    );
  }

  @override
  $EquipmentTable createAlias(String alias) {
    return $EquipmentTable(attachedDatabase, alias);
  }
}

class EquipmentData extends DataClass implements Insertable<EquipmentData> {
  final int id;
  final int siteId;
  final int? machineProfileId;
  final String equipmentType;
  final String? manufacturer;
  final String? model;
  final String? serialNumber;
  final bool underWarranty;
  final bool underServiceContract;
  final String? contractReference;
  final bool active;
  const EquipmentData(
      {required this.id,
      required this.siteId,
      this.machineProfileId,
      required this.equipmentType,
      this.manufacturer,
      this.model,
      this.serialNumber,
      required this.underWarranty,
      required this.underServiceContract,
      this.contractReference,
      required this.active});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['site_id'] = Variable<int>(siteId);
    if (!nullToAbsent || machineProfileId != null) {
      map['machine_profile_id'] = Variable<int>(machineProfileId);
    }
    map['equipment_type'] = Variable<String>(equipmentType);
    if (!nullToAbsent || manufacturer != null) {
      map['manufacturer'] = Variable<String>(manufacturer);
    }
    if (!nullToAbsent || model != null) {
      map['model'] = Variable<String>(model);
    }
    if (!nullToAbsent || serialNumber != null) {
      map['serial_number'] = Variable<String>(serialNumber);
    }
    map['under_warranty'] = Variable<bool>(underWarranty);
    map['under_service_contract'] = Variable<bool>(underServiceContract);
    if (!nullToAbsent || contractReference != null) {
      map['contract_reference'] = Variable<String>(contractReference);
    }
    map['active'] = Variable<bool>(active);
    return map;
  }

  EquipmentCompanion toCompanion(bool nullToAbsent) {
    return EquipmentCompanion(
      id: Value(id),
      siteId: Value(siteId),
      machineProfileId: machineProfileId == null && nullToAbsent
          ? const Value.absent()
          : Value(machineProfileId),
      equipmentType: Value(equipmentType),
      manufacturer: manufacturer == null && nullToAbsent
          ? const Value.absent()
          : Value(manufacturer),
      model:
          model == null && nullToAbsent ? const Value.absent() : Value(model),
      serialNumber: serialNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(serialNumber),
      underWarranty: Value(underWarranty),
      underServiceContract: Value(underServiceContract),
      contractReference: contractReference == null && nullToAbsent
          ? const Value.absent()
          : Value(contractReference),
      active: Value(active),
    );
  }

  factory EquipmentData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EquipmentData(
      id: serializer.fromJson<int>(json['id']),
      siteId: serializer.fromJson<int>(json['siteId']),
      machineProfileId: serializer.fromJson<int?>(json['machineProfileId']),
      equipmentType: serializer.fromJson<String>(json['equipmentType']),
      manufacturer: serializer.fromJson<String?>(json['manufacturer']),
      model: serializer.fromJson<String?>(json['model']),
      serialNumber: serializer.fromJson<String?>(json['serialNumber']),
      underWarranty: serializer.fromJson<bool>(json['underWarranty']),
      underServiceContract:
          serializer.fromJson<bool>(json['underServiceContract']),
      contractReference:
          serializer.fromJson<String?>(json['contractReference']),
      active: serializer.fromJson<bool>(json['active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'siteId': serializer.toJson<int>(siteId),
      'machineProfileId': serializer.toJson<int?>(machineProfileId),
      'equipmentType': serializer.toJson<String>(equipmentType),
      'manufacturer': serializer.toJson<String?>(manufacturer),
      'model': serializer.toJson<String?>(model),
      'serialNumber': serializer.toJson<String?>(serialNumber),
      'underWarranty': serializer.toJson<bool>(underWarranty),
      'underServiceContract': serializer.toJson<bool>(underServiceContract),
      'contractReference': serializer.toJson<String?>(contractReference),
      'active': serializer.toJson<bool>(active),
    };
  }

  EquipmentData copyWith(
          {int? id,
          int? siteId,
          Value<int?> machineProfileId = const Value.absent(),
          String? equipmentType,
          Value<String?> manufacturer = const Value.absent(),
          Value<String?> model = const Value.absent(),
          Value<String?> serialNumber = const Value.absent(),
          bool? underWarranty,
          bool? underServiceContract,
          Value<String?> contractReference = const Value.absent(),
          bool? active}) =>
      EquipmentData(
        id: id ?? this.id,
        siteId: siteId ?? this.siteId,
        machineProfileId: machineProfileId.present
            ? machineProfileId.value
            : this.machineProfileId,
        equipmentType: equipmentType ?? this.equipmentType,
        manufacturer:
            manufacturer.present ? manufacturer.value : this.manufacturer,
        model: model.present ? model.value : this.model,
        serialNumber:
            serialNumber.present ? serialNumber.value : this.serialNumber,
        underWarranty: underWarranty ?? this.underWarranty,
        underServiceContract: underServiceContract ?? this.underServiceContract,
        contractReference: contractReference.present
            ? contractReference.value
            : this.contractReference,
        active: active ?? this.active,
      );
  EquipmentData copyWithCompanion(EquipmentCompanion data) {
    return EquipmentData(
      id: data.id.present ? data.id.value : this.id,
      siteId: data.siteId.present ? data.siteId.value : this.siteId,
      machineProfileId: data.machineProfileId.present
          ? data.machineProfileId.value
          : this.machineProfileId,
      equipmentType: data.equipmentType.present
          ? data.equipmentType.value
          : this.equipmentType,
      manufacturer: data.manufacturer.present
          ? data.manufacturer.value
          : this.manufacturer,
      model: data.model.present ? data.model.value : this.model,
      serialNumber: data.serialNumber.present
          ? data.serialNumber.value
          : this.serialNumber,
      underWarranty: data.underWarranty.present
          ? data.underWarranty.value
          : this.underWarranty,
      underServiceContract: data.underServiceContract.present
          ? data.underServiceContract.value
          : this.underServiceContract,
      contractReference: data.contractReference.present
          ? data.contractReference.value
          : this.contractReference,
      active: data.active.present ? data.active.value : this.active,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentData(')
          ..write('id: $id, ')
          ..write('siteId: $siteId, ')
          ..write('machineProfileId: $machineProfileId, ')
          ..write('equipmentType: $equipmentType, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('model: $model, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('underWarranty: $underWarranty, ')
          ..write('underServiceContract: $underServiceContract, ')
          ..write('contractReference: $contractReference, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      siteId,
      machineProfileId,
      equipmentType,
      manufacturer,
      model,
      serialNumber,
      underWarranty,
      underServiceContract,
      contractReference,
      active);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EquipmentData &&
          other.id == this.id &&
          other.siteId == this.siteId &&
          other.machineProfileId == this.machineProfileId &&
          other.equipmentType == this.equipmentType &&
          other.manufacturer == this.manufacturer &&
          other.model == this.model &&
          other.serialNumber == this.serialNumber &&
          other.underWarranty == this.underWarranty &&
          other.underServiceContract == this.underServiceContract &&
          other.contractReference == this.contractReference &&
          other.active == this.active);
}

class EquipmentCompanion extends UpdateCompanion<EquipmentData> {
  final Value<int> id;
  final Value<int> siteId;
  final Value<int?> machineProfileId;
  final Value<String> equipmentType;
  final Value<String?> manufacturer;
  final Value<String?> model;
  final Value<String?> serialNumber;
  final Value<bool> underWarranty;
  final Value<bool> underServiceContract;
  final Value<String?> contractReference;
  final Value<bool> active;
  const EquipmentCompanion({
    this.id = const Value.absent(),
    this.siteId = const Value.absent(),
    this.machineProfileId = const Value.absent(),
    this.equipmentType = const Value.absent(),
    this.manufacturer = const Value.absent(),
    this.model = const Value.absent(),
    this.serialNumber = const Value.absent(),
    this.underWarranty = const Value.absent(),
    this.underServiceContract = const Value.absent(),
    this.contractReference = const Value.absent(),
    this.active = const Value.absent(),
  });
  EquipmentCompanion.insert({
    this.id = const Value.absent(),
    required int siteId,
    this.machineProfileId = const Value.absent(),
    required String equipmentType,
    this.manufacturer = const Value.absent(),
    this.model = const Value.absent(),
    this.serialNumber = const Value.absent(),
    this.underWarranty = const Value.absent(),
    this.underServiceContract = const Value.absent(),
    this.contractReference = const Value.absent(),
    this.active = const Value.absent(),
  })  : siteId = Value(siteId),
        equipmentType = Value(equipmentType);
  static Insertable<EquipmentData> custom({
    Expression<int>? id,
    Expression<int>? siteId,
    Expression<int>? machineProfileId,
    Expression<String>? equipmentType,
    Expression<String>? manufacturer,
    Expression<String>? model,
    Expression<String>? serialNumber,
    Expression<bool>? underWarranty,
    Expression<bool>? underServiceContract,
    Expression<String>? contractReference,
    Expression<bool>? active,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (siteId != null) 'site_id': siteId,
      if (machineProfileId != null) 'machine_profile_id': machineProfileId,
      if (equipmentType != null) 'equipment_type': equipmentType,
      if (manufacturer != null) 'manufacturer': manufacturer,
      if (model != null) 'model': model,
      if (serialNumber != null) 'serial_number': serialNumber,
      if (underWarranty != null) 'under_warranty': underWarranty,
      if (underServiceContract != null)
        'under_service_contract': underServiceContract,
      if (contractReference != null) 'contract_reference': contractReference,
      if (active != null) 'active': active,
    });
  }

  EquipmentCompanion copyWith(
      {Value<int>? id,
      Value<int>? siteId,
      Value<int?>? machineProfileId,
      Value<String>? equipmentType,
      Value<String?>? manufacturer,
      Value<String?>? model,
      Value<String?>? serialNumber,
      Value<bool>? underWarranty,
      Value<bool>? underServiceContract,
      Value<String?>? contractReference,
      Value<bool>? active}) {
    return EquipmentCompanion(
      id: id ?? this.id,
      siteId: siteId ?? this.siteId,
      machineProfileId: machineProfileId ?? this.machineProfileId,
      equipmentType: equipmentType ?? this.equipmentType,
      manufacturer: manufacturer ?? this.manufacturer,
      model: model ?? this.model,
      serialNumber: serialNumber ?? this.serialNumber,
      underWarranty: underWarranty ?? this.underWarranty,
      underServiceContract: underServiceContract ?? this.underServiceContract,
      contractReference: contractReference ?? this.contractReference,
      active: active ?? this.active,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (siteId.present) {
      map['site_id'] = Variable<int>(siteId.value);
    }
    if (machineProfileId.present) {
      map['machine_profile_id'] = Variable<int>(machineProfileId.value);
    }
    if (equipmentType.present) {
      map['equipment_type'] = Variable<String>(equipmentType.value);
    }
    if (manufacturer.present) {
      map['manufacturer'] = Variable<String>(manufacturer.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (serialNumber.present) {
      map['serial_number'] = Variable<String>(serialNumber.value);
    }
    if (underWarranty.present) {
      map['under_warranty'] = Variable<bool>(underWarranty.value);
    }
    if (underServiceContract.present) {
      map['under_service_contract'] =
          Variable<bool>(underServiceContract.value);
    }
    if (contractReference.present) {
      map['contract_reference'] = Variable<String>(contractReference.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentCompanion(')
          ..write('id: $id, ')
          ..write('siteId: $siteId, ')
          ..write('machineProfileId: $machineProfileId, ')
          ..write('equipmentType: $equipmentType, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('model: $model, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('underWarranty: $underWarranty, ')
          ..write('underServiceContract: $underServiceContract, ')
          ..write('contractReference: $contractReference, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }
}

class $WorkOrderEquipmentTable extends WorkOrderEquipment
    with TableInfo<$WorkOrderEquipmentTable, WorkOrderEquipmentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkOrderEquipmentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _workOrderIdMeta =
      const VerificationMeta('workOrderId');
  @override
  late final GeneratedColumn<int> workOrderId = GeneratedColumn<int>(
      'work_order_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _equipmentIdMeta =
      const VerificationMeta('equipmentId');
  @override
  late final GeneratedColumn<int> equipmentId = GeneratedColumn<int>(
      'equipment_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [workOrderId, equipmentId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'work_order_equipment';
  @override
  VerificationContext validateIntegrity(
      Insertable<WorkOrderEquipmentData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('work_order_id')) {
      context.handle(
          _workOrderIdMeta,
          workOrderId.isAcceptableOrUnknown(
              data['work_order_id']!, _workOrderIdMeta));
    } else if (isInserting) {
      context.missing(_workOrderIdMeta);
    }
    if (data.containsKey('equipment_id')) {
      context.handle(
          _equipmentIdMeta,
          equipmentId.isAcceptableOrUnknown(
              data['equipment_id']!, _equipmentIdMeta));
    } else if (isInserting) {
      context.missing(_equipmentIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {workOrderId, equipmentId};
  @override
  WorkOrderEquipmentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkOrderEquipmentData(
      workOrderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}work_order_id'])!,
      equipmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}equipment_id'])!,
    );
  }

  @override
  $WorkOrderEquipmentTable createAlias(String alias) {
    return $WorkOrderEquipmentTable(attachedDatabase, alias);
  }
}

class WorkOrderEquipmentData extends DataClass
    implements Insertable<WorkOrderEquipmentData> {
  final int workOrderId;
  final int equipmentId;
  const WorkOrderEquipmentData(
      {required this.workOrderId, required this.equipmentId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['work_order_id'] = Variable<int>(workOrderId);
    map['equipment_id'] = Variable<int>(equipmentId);
    return map;
  }

  WorkOrderEquipmentCompanion toCompanion(bool nullToAbsent) {
    return WorkOrderEquipmentCompanion(
      workOrderId: Value(workOrderId),
      equipmentId: Value(equipmentId),
    );
  }

  factory WorkOrderEquipmentData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkOrderEquipmentData(
      workOrderId: serializer.fromJson<int>(json['workOrderId']),
      equipmentId: serializer.fromJson<int>(json['equipmentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'workOrderId': serializer.toJson<int>(workOrderId),
      'equipmentId': serializer.toJson<int>(equipmentId),
    };
  }

  WorkOrderEquipmentData copyWith({int? workOrderId, int? equipmentId}) =>
      WorkOrderEquipmentData(
        workOrderId: workOrderId ?? this.workOrderId,
        equipmentId: equipmentId ?? this.equipmentId,
      );
  WorkOrderEquipmentData copyWithCompanion(WorkOrderEquipmentCompanion data) {
    return WorkOrderEquipmentData(
      workOrderId:
          data.workOrderId.present ? data.workOrderId.value : this.workOrderId,
      equipmentId:
          data.equipmentId.present ? data.equipmentId.value : this.equipmentId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkOrderEquipmentData(')
          ..write('workOrderId: $workOrderId, ')
          ..write('equipmentId: $equipmentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(workOrderId, equipmentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkOrderEquipmentData &&
          other.workOrderId == this.workOrderId &&
          other.equipmentId == this.equipmentId);
}

class WorkOrderEquipmentCompanion
    extends UpdateCompanion<WorkOrderEquipmentData> {
  final Value<int> workOrderId;
  final Value<int> equipmentId;
  final Value<int> rowid;
  const WorkOrderEquipmentCompanion({
    this.workOrderId = const Value.absent(),
    this.equipmentId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkOrderEquipmentCompanion.insert({
    required int workOrderId,
    required int equipmentId,
    this.rowid = const Value.absent(),
  })  : workOrderId = Value(workOrderId),
        equipmentId = Value(equipmentId);
  static Insertable<WorkOrderEquipmentData> custom({
    Expression<int>? workOrderId,
    Expression<int>? equipmentId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (workOrderId != null) 'work_order_id': workOrderId,
      if (equipmentId != null) 'equipment_id': equipmentId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkOrderEquipmentCompanion copyWith(
      {Value<int>? workOrderId, Value<int>? equipmentId, Value<int>? rowid}) {
    return WorkOrderEquipmentCompanion(
      workOrderId: workOrderId ?? this.workOrderId,
      equipmentId: equipmentId ?? this.equipmentId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (workOrderId.present) {
      map['work_order_id'] = Variable<int>(workOrderId.value);
    }
    if (equipmentId.present) {
      map['equipment_id'] = Variable<int>(equipmentId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkOrderEquipmentCompanion(')
          ..write('workOrderId: $workOrderId, ')
          ..write('equipmentId: $equipmentId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkPerformedTable extends WorkPerformed
    with TableInfo<$WorkPerformedTable, WorkPerformedData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkPerformedTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _workOrderIdMeta =
      const VerificationMeta('workOrderId');
  @override
  late final GeneratedColumn<int> workOrderId = GeneratedColumn<int>(
      'work_order_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _equipmentIdMeta =
      const VerificationMeta('equipmentId');
  @override
  late final GeneratedColumn<int> equipmentId = GeneratedColumn<int>(
      'equipment_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _technicianMeta =
      const VerificationMeta('technician');
  @override
  late final GeneratedColumn<String> technician = GeneratedColumn<String>(
      'technician', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
      'started_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _durationMinutesMeta =
      const VerificationMeta('durationMinutes');
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
      'duration_minutes', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _workDescriptionMeta =
      const VerificationMeta('workDescription');
  @override
  late final GeneratedColumn<String> workDescription = GeneratedColumn<String>(
      'work_description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _resolutionMeta =
      const VerificationMeta('resolution');
  @override
  late final GeneratedColumn<String> resolution = GeneratedColumn<String>(
      'resolution', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _repeatIssueMeta =
      const VerificationMeta('repeatIssue');
  @override
  late final GeneratedColumn<bool> repeatIssue = GeneratedColumn<bool>(
      'repeat_issue', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("repeat_issue" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        workOrderId,
        equipmentId,
        technician,
        startedAt,
        durationMinutes,
        workDescription,
        resolution,
        repeatIssue
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'work_performed';
  @override
  VerificationContext validateIntegrity(Insertable<WorkPerformedData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('work_order_id')) {
      context.handle(
          _workOrderIdMeta,
          workOrderId.isAcceptableOrUnknown(
              data['work_order_id']!, _workOrderIdMeta));
    } else if (isInserting) {
      context.missing(_workOrderIdMeta);
    }
    if (data.containsKey('equipment_id')) {
      context.handle(
          _equipmentIdMeta,
          equipmentId.isAcceptableOrUnknown(
              data['equipment_id']!, _equipmentIdMeta));
    }
    if (data.containsKey('technician')) {
      context.handle(
          _technicianMeta,
          technician.isAcceptableOrUnknown(
              data['technician']!, _technicianMeta));
    } else if (isInserting) {
      context.missing(_technicianMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
          _durationMinutesMeta,
          durationMinutes.isAcceptableOrUnknown(
              data['duration_minutes']!, _durationMinutesMeta));
    }
    if (data.containsKey('work_description')) {
      context.handle(
          _workDescriptionMeta,
          workDescription.isAcceptableOrUnknown(
              data['work_description']!, _workDescriptionMeta));
    }
    if (data.containsKey('resolution')) {
      context.handle(
          _resolutionMeta,
          resolution.isAcceptableOrUnknown(
              data['resolution']!, _resolutionMeta));
    }
    if (data.containsKey('repeat_issue')) {
      context.handle(
          _repeatIssueMeta,
          repeatIssue.isAcceptableOrUnknown(
              data['repeat_issue']!, _repeatIssueMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkPerformedData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkPerformedData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      workOrderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}work_order_id'])!,
      equipmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}equipment_id']),
      technician: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}technician'])!,
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}started_at'])!,
      durationMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_minutes']),
      workDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}work_description']),
      resolution: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}resolution']),
      repeatIssue: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}repeat_issue'])!,
    );
  }

  @override
  $WorkPerformedTable createAlias(String alias) {
    return $WorkPerformedTable(attachedDatabase, alias);
  }
}

class WorkPerformedData extends DataClass
    implements Insertable<WorkPerformedData> {
  final int id;
  final int workOrderId;
  final int? equipmentId;
  final String technician;
  final DateTime startedAt;
  final int? durationMinutes;
  final String? workDescription;
  final String? resolution;
  final bool repeatIssue;
  const WorkPerformedData(
      {required this.id,
      required this.workOrderId,
      this.equipmentId,
      required this.technician,
      required this.startedAt,
      this.durationMinutes,
      this.workDescription,
      this.resolution,
      required this.repeatIssue});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['work_order_id'] = Variable<int>(workOrderId);
    if (!nullToAbsent || equipmentId != null) {
      map['equipment_id'] = Variable<int>(equipmentId);
    }
    map['technician'] = Variable<String>(technician);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || durationMinutes != null) {
      map['duration_minutes'] = Variable<int>(durationMinutes);
    }
    if (!nullToAbsent || workDescription != null) {
      map['work_description'] = Variable<String>(workDescription);
    }
    if (!nullToAbsent || resolution != null) {
      map['resolution'] = Variable<String>(resolution);
    }
    map['repeat_issue'] = Variable<bool>(repeatIssue);
    return map;
  }

  WorkPerformedCompanion toCompanion(bool nullToAbsent) {
    return WorkPerformedCompanion(
      id: Value(id),
      workOrderId: Value(workOrderId),
      equipmentId: equipmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(equipmentId),
      technician: Value(technician),
      startedAt: Value(startedAt),
      durationMinutes: durationMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMinutes),
      workDescription: workDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(workDescription),
      resolution: resolution == null && nullToAbsent
          ? const Value.absent()
          : Value(resolution),
      repeatIssue: Value(repeatIssue),
    );
  }

  factory WorkPerformedData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkPerformedData(
      id: serializer.fromJson<int>(json['id']),
      workOrderId: serializer.fromJson<int>(json['workOrderId']),
      equipmentId: serializer.fromJson<int?>(json['equipmentId']),
      technician: serializer.fromJson<String>(json['technician']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      durationMinutes: serializer.fromJson<int?>(json['durationMinutes']),
      workDescription: serializer.fromJson<String?>(json['workDescription']),
      resolution: serializer.fromJson<String?>(json['resolution']),
      repeatIssue: serializer.fromJson<bool>(json['repeatIssue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'workOrderId': serializer.toJson<int>(workOrderId),
      'equipmentId': serializer.toJson<int?>(equipmentId),
      'technician': serializer.toJson<String>(technician),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'durationMinutes': serializer.toJson<int?>(durationMinutes),
      'workDescription': serializer.toJson<String?>(workDescription),
      'resolution': serializer.toJson<String?>(resolution),
      'repeatIssue': serializer.toJson<bool>(repeatIssue),
    };
  }

  WorkPerformedData copyWith(
          {int? id,
          int? workOrderId,
          Value<int?> equipmentId = const Value.absent(),
          String? technician,
          DateTime? startedAt,
          Value<int?> durationMinutes = const Value.absent(),
          Value<String?> workDescription = const Value.absent(),
          Value<String?> resolution = const Value.absent(),
          bool? repeatIssue}) =>
      WorkPerformedData(
        id: id ?? this.id,
        workOrderId: workOrderId ?? this.workOrderId,
        equipmentId: equipmentId.present ? equipmentId.value : this.equipmentId,
        technician: technician ?? this.technician,
        startedAt: startedAt ?? this.startedAt,
        durationMinutes: durationMinutes.present
            ? durationMinutes.value
            : this.durationMinutes,
        workDescription: workDescription.present
            ? workDescription.value
            : this.workDescription,
        resolution: resolution.present ? resolution.value : this.resolution,
        repeatIssue: repeatIssue ?? this.repeatIssue,
      );
  WorkPerformedData copyWithCompanion(WorkPerformedCompanion data) {
    return WorkPerformedData(
      id: data.id.present ? data.id.value : this.id,
      workOrderId:
          data.workOrderId.present ? data.workOrderId.value : this.workOrderId,
      equipmentId:
          data.equipmentId.present ? data.equipmentId.value : this.equipmentId,
      technician:
          data.technician.present ? data.technician.value : this.technician,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      workDescription: data.workDescription.present
          ? data.workDescription.value
          : this.workDescription,
      resolution:
          data.resolution.present ? data.resolution.value : this.resolution,
      repeatIssue:
          data.repeatIssue.present ? data.repeatIssue.value : this.repeatIssue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkPerformedData(')
          ..write('id: $id, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('equipmentId: $equipmentId, ')
          ..write('technician: $technician, ')
          ..write('startedAt: $startedAt, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('workDescription: $workDescription, ')
          ..write('resolution: $resolution, ')
          ..write('repeatIssue: $repeatIssue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, workOrderId, equipmentId, technician,
      startedAt, durationMinutes, workDescription, resolution, repeatIssue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkPerformedData &&
          other.id == this.id &&
          other.workOrderId == this.workOrderId &&
          other.equipmentId == this.equipmentId &&
          other.technician == this.technician &&
          other.startedAt == this.startedAt &&
          other.durationMinutes == this.durationMinutes &&
          other.workDescription == this.workDescription &&
          other.resolution == this.resolution &&
          other.repeatIssue == this.repeatIssue);
}

class WorkPerformedCompanion extends UpdateCompanion<WorkPerformedData> {
  final Value<int> id;
  final Value<int> workOrderId;
  final Value<int?> equipmentId;
  final Value<String> technician;
  final Value<DateTime> startedAt;
  final Value<int?> durationMinutes;
  final Value<String?> workDescription;
  final Value<String?> resolution;
  final Value<bool> repeatIssue;
  const WorkPerformedCompanion({
    this.id = const Value.absent(),
    this.workOrderId = const Value.absent(),
    this.equipmentId = const Value.absent(),
    this.technician = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.workDescription = const Value.absent(),
    this.resolution = const Value.absent(),
    this.repeatIssue = const Value.absent(),
  });
  WorkPerformedCompanion.insert({
    this.id = const Value.absent(),
    required int workOrderId,
    this.equipmentId = const Value.absent(),
    required String technician,
    required DateTime startedAt,
    this.durationMinutes = const Value.absent(),
    this.workDescription = const Value.absent(),
    this.resolution = const Value.absent(),
    this.repeatIssue = const Value.absent(),
  })  : workOrderId = Value(workOrderId),
        technician = Value(technician),
        startedAt = Value(startedAt);
  static Insertable<WorkPerformedData> custom({
    Expression<int>? id,
    Expression<int>? workOrderId,
    Expression<int>? equipmentId,
    Expression<String>? technician,
    Expression<DateTime>? startedAt,
    Expression<int>? durationMinutes,
    Expression<String>? workDescription,
    Expression<String>? resolution,
    Expression<bool>? repeatIssue,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workOrderId != null) 'work_order_id': workOrderId,
      if (equipmentId != null) 'equipment_id': equipmentId,
      if (technician != null) 'technician': technician,
      if (startedAt != null) 'started_at': startedAt,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (workDescription != null) 'work_description': workDescription,
      if (resolution != null) 'resolution': resolution,
      if (repeatIssue != null) 'repeat_issue': repeatIssue,
    });
  }

  WorkPerformedCompanion copyWith(
      {Value<int>? id,
      Value<int>? workOrderId,
      Value<int?>? equipmentId,
      Value<String>? technician,
      Value<DateTime>? startedAt,
      Value<int?>? durationMinutes,
      Value<String?>? workDescription,
      Value<String?>? resolution,
      Value<bool>? repeatIssue}) {
    return WorkPerformedCompanion(
      id: id ?? this.id,
      workOrderId: workOrderId ?? this.workOrderId,
      equipmentId: equipmentId ?? this.equipmentId,
      technician: technician ?? this.technician,
      startedAt: startedAt ?? this.startedAt,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      workDescription: workDescription ?? this.workDescription,
      resolution: resolution ?? this.resolution,
      repeatIssue: repeatIssue ?? this.repeatIssue,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (workOrderId.present) {
      map['work_order_id'] = Variable<int>(workOrderId.value);
    }
    if (equipmentId.present) {
      map['equipment_id'] = Variable<int>(equipmentId.value);
    }
    if (technician.present) {
      map['technician'] = Variable<String>(technician.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (workDescription.present) {
      map['work_description'] = Variable<String>(workDescription.value);
    }
    if (resolution.present) {
      map['resolution'] = Variable<String>(resolution.value);
    }
    if (repeatIssue.present) {
      map['repeat_issue'] = Variable<bool>(repeatIssue.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkPerformedCompanion(')
          ..write('id: $id, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('equipmentId: $equipmentId, ')
          ..write('technician: $technician, ')
          ..write('startedAt: $startedAt, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('workDescription: $workDescription, ')
          ..write('resolution: $resolution, ')
          ..write('repeatIssue: $repeatIssue')
          ..write(')'))
        .toString();
  }
}

class $PartsUsedTable extends PartsUsed
    with TableInfo<$PartsUsedTable, PartsUsedData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartsUsedTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _workPerformedIdMeta =
      const VerificationMeta('workPerformedId');
  @override
  late final GeneratedColumn<int> workPerformedId = GeneratedColumn<int>(
      'work_performed_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _partNumberMeta =
      const VerificationMeta('partNumber');
  @override
  late final GeneratedColumn<String> partNumber = GeneratedColumn<String>(
      'part_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  @override
  List<GeneratedColumn> get $columns =>
      [id, workPerformedId, partNumber, description, quantity];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'parts_used';
  @override
  VerificationContext validateIntegrity(Insertable<PartsUsedData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('work_performed_id')) {
      context.handle(
          _workPerformedIdMeta,
          workPerformedId.isAcceptableOrUnknown(
              data['work_performed_id']!, _workPerformedIdMeta));
    } else if (isInserting) {
      context.missing(_workPerformedIdMeta);
    }
    if (data.containsKey('part_number')) {
      context.handle(
          _partNumberMeta,
          partNumber.isAcceptableOrUnknown(
              data['part_number']!, _partNumberMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PartsUsedData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PartsUsedData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      workPerformedId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}work_performed_id'])!,
      partNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}part_number']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
    );
  }

  @override
  $PartsUsedTable createAlias(String alias) {
    return $PartsUsedTable(attachedDatabase, alias);
  }
}

class PartsUsedData extends DataClass implements Insertable<PartsUsedData> {
  final int id;
  final int workPerformedId;
  final String? partNumber;
  final String? description;
  final int quantity;
  const PartsUsedData(
      {required this.id,
      required this.workPerformedId,
      this.partNumber,
      this.description,
      required this.quantity});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['work_performed_id'] = Variable<int>(workPerformedId);
    if (!nullToAbsent || partNumber != null) {
      map['part_number'] = Variable<String>(partNumber);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['quantity'] = Variable<int>(quantity);
    return map;
  }

  PartsUsedCompanion toCompanion(bool nullToAbsent) {
    return PartsUsedCompanion(
      id: Value(id),
      workPerformedId: Value(workPerformedId),
      partNumber: partNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(partNumber),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      quantity: Value(quantity),
    );
  }

  factory PartsUsedData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PartsUsedData(
      id: serializer.fromJson<int>(json['id']),
      workPerformedId: serializer.fromJson<int>(json['workPerformedId']),
      partNumber: serializer.fromJson<String?>(json['partNumber']),
      description: serializer.fromJson<String?>(json['description']),
      quantity: serializer.fromJson<int>(json['quantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'workPerformedId': serializer.toJson<int>(workPerformedId),
      'partNumber': serializer.toJson<String?>(partNumber),
      'description': serializer.toJson<String?>(description),
      'quantity': serializer.toJson<int>(quantity),
    };
  }

  PartsUsedData copyWith(
          {int? id,
          int? workPerformedId,
          Value<String?> partNumber = const Value.absent(),
          Value<String?> description = const Value.absent(),
          int? quantity}) =>
      PartsUsedData(
        id: id ?? this.id,
        workPerformedId: workPerformedId ?? this.workPerformedId,
        partNumber: partNumber.present ? partNumber.value : this.partNumber,
        description: description.present ? description.value : this.description,
        quantity: quantity ?? this.quantity,
      );
  PartsUsedData copyWithCompanion(PartsUsedCompanion data) {
    return PartsUsedData(
      id: data.id.present ? data.id.value : this.id,
      workPerformedId: data.workPerformedId.present
          ? data.workPerformedId.value
          : this.workPerformedId,
      partNumber:
          data.partNumber.present ? data.partNumber.value : this.partNumber,
      description:
          data.description.present ? data.description.value : this.description,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PartsUsedData(')
          ..write('id: $id, ')
          ..write('workPerformedId: $workPerformedId, ')
          ..write('partNumber: $partNumber, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, workPerformedId, partNumber, description, quantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PartsUsedData &&
          other.id == this.id &&
          other.workPerformedId == this.workPerformedId &&
          other.partNumber == this.partNumber &&
          other.description == this.description &&
          other.quantity == this.quantity);
}

class PartsUsedCompanion extends UpdateCompanion<PartsUsedData> {
  final Value<int> id;
  final Value<int> workPerformedId;
  final Value<String?> partNumber;
  final Value<String?> description;
  final Value<int> quantity;
  const PartsUsedCompanion({
    this.id = const Value.absent(),
    this.workPerformedId = const Value.absent(),
    this.partNumber = const Value.absent(),
    this.description = const Value.absent(),
    this.quantity = const Value.absent(),
  });
  PartsUsedCompanion.insert({
    this.id = const Value.absent(),
    required int workPerformedId,
    this.partNumber = const Value.absent(),
    this.description = const Value.absent(),
    this.quantity = const Value.absent(),
  }) : workPerformedId = Value(workPerformedId);
  static Insertable<PartsUsedData> custom({
    Expression<int>? id,
    Expression<int>? workPerformedId,
    Expression<String>? partNumber,
    Expression<String>? description,
    Expression<int>? quantity,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workPerformedId != null) 'work_performed_id': workPerformedId,
      if (partNumber != null) 'part_number': partNumber,
      if (description != null) 'description': description,
      if (quantity != null) 'quantity': quantity,
    });
  }

  PartsUsedCompanion copyWith(
      {Value<int>? id,
      Value<int>? workPerformedId,
      Value<String?>? partNumber,
      Value<String?>? description,
      Value<int>? quantity}) {
    return PartsUsedCompanion(
      id: id ?? this.id,
      workPerformedId: workPerformedId ?? this.workPerformedId,
      partNumber: partNumber ?? this.partNumber,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (workPerformedId.present) {
      map['work_performed_id'] = Variable<int>(workPerformedId.value);
    }
    if (partNumber.present) {
      map['part_number'] = Variable<String>(partNumber.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartsUsedCompanion(')
          ..write('id: $id, ')
          ..write('workPerformedId: $workPerformedId, ')
          ..write('partNumber: $partNumber, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _siteIdMeta = const VerificationMeta('siteId');
  @override
  late final GeneratedColumn<int> siteId = GeneratedColumn<int>(
      'site_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _workOrderIdMeta =
      const VerificationMeta('workOrderId');
  @override
  late final GeneratedColumn<int> workOrderId = GeneratedColumn<int>(
      'work_order_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _noteTypeMeta =
      const VerificationMeta('noteType');
  @override
  late final GeneratedColumn<String> noteType = GeneratedColumn<String>(
      'note_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _noteTextMeta =
      const VerificationMeta('noteText');
  @override
  late final GeneratedColumn<String> noteText = GeneratedColumn<String>(
      'note_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdByMeta =
      const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
      'created_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, siteId, workOrderId, noteType, noteText, createdAt, createdBy];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(Insertable<Note> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('site_id')) {
      context.handle(_siteIdMeta,
          siteId.isAcceptableOrUnknown(data['site_id']!, _siteIdMeta));
    } else if (isInserting) {
      context.missing(_siteIdMeta);
    }
    if (data.containsKey('work_order_id')) {
      context.handle(
          _workOrderIdMeta,
          workOrderId.isAcceptableOrUnknown(
              data['work_order_id']!, _workOrderIdMeta));
    }
    if (data.containsKey('note_type')) {
      context.handle(_noteTypeMeta,
          noteType.isAcceptableOrUnknown(data['note_type']!, _noteTypeMeta));
    } else if (isInserting) {
      context.missing(_noteTypeMeta);
    }
    if (data.containsKey('note_text')) {
      context.handle(_noteTextMeta,
          noteText.isAcceptableOrUnknown(data['note_text']!, _noteTextMeta));
    } else if (isInserting) {
      context.missing(_noteTextMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Note(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      siteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}site_id'])!,
      workOrderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}work_order_id']),
      noteType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note_type'])!,
      noteText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note_text'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      createdBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_by']),
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class Note extends DataClass implements Insertable<Note> {
  final int id;
  final int siteId;
  final int? workOrderId;
  final String noteType;
  final String noteText;
  final DateTime createdAt;
  final String? createdBy;
  const Note(
      {required this.id,
      required this.siteId,
      this.workOrderId,
      required this.noteType,
      required this.noteText,
      required this.createdAt,
      this.createdBy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['site_id'] = Variable<int>(siteId);
    if (!nullToAbsent || workOrderId != null) {
      map['work_order_id'] = Variable<int>(workOrderId);
    }
    map['note_type'] = Variable<String>(noteType);
    map['note_text'] = Variable<String>(noteText);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      siteId: Value(siteId),
      workOrderId: workOrderId == null && nullToAbsent
          ? const Value.absent()
          : Value(workOrderId),
      noteType: Value(noteType),
      noteText: Value(noteText),
      createdAt: Value(createdAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
    );
  }

  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<int>(json['id']),
      siteId: serializer.fromJson<int>(json['siteId']),
      workOrderId: serializer.fromJson<int?>(json['workOrderId']),
      noteType: serializer.fromJson<String>(json['noteType']),
      noteText: serializer.fromJson<String>(json['noteText']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'siteId': serializer.toJson<int>(siteId),
      'workOrderId': serializer.toJson<int?>(workOrderId),
      'noteType': serializer.toJson<String>(noteType),
      'noteText': serializer.toJson<String>(noteText),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String?>(createdBy),
    };
  }

  Note copyWith(
          {int? id,
          int? siteId,
          Value<int?> workOrderId = const Value.absent(),
          String? noteType,
          String? noteText,
          DateTime? createdAt,
          Value<String?> createdBy = const Value.absent()}) =>
      Note(
        id: id ?? this.id,
        siteId: siteId ?? this.siteId,
        workOrderId: workOrderId.present ? workOrderId.value : this.workOrderId,
        noteType: noteType ?? this.noteType,
        noteText: noteText ?? this.noteText,
        createdAt: createdAt ?? this.createdAt,
        createdBy: createdBy.present ? createdBy.value : this.createdBy,
      );
  Note copyWithCompanion(NotesCompanion data) {
    return Note(
      id: data.id.present ? data.id.value : this.id,
      siteId: data.siteId.present ? data.siteId.value : this.siteId,
      workOrderId:
          data.workOrderId.present ? data.workOrderId.value : this.workOrderId,
      noteType: data.noteType.present ? data.noteType.value : this.noteType,
      noteText: data.noteText.present ? data.noteText.value : this.noteText,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('siteId: $siteId, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('noteType: $noteType, ')
          ..write('noteText: $noteText, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, siteId, workOrderId, noteType, noteText, createdAt, createdBy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.siteId == this.siteId &&
          other.workOrderId == this.workOrderId &&
          other.noteType == this.noteType &&
          other.noteText == this.noteText &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<int> id;
  final Value<int> siteId;
  final Value<int?> workOrderId;
  final Value<String> noteType;
  final Value<String> noteText;
  final Value<DateTime> createdAt;
  final Value<String?> createdBy;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.siteId = const Value.absent(),
    this.workOrderId = const Value.absent(),
    this.noteType = const Value.absent(),
    this.noteText = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    required int siteId,
    this.workOrderId = const Value.absent(),
    required String noteType,
    required String noteText,
    required DateTime createdAt,
    this.createdBy = const Value.absent(),
  })  : siteId = Value(siteId),
        noteType = Value(noteType),
        noteText = Value(noteText),
        createdAt = Value(createdAt);
  static Insertable<Note> custom({
    Expression<int>? id,
    Expression<int>? siteId,
    Expression<int>? workOrderId,
    Expression<String>? noteType,
    Expression<String>? noteText,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (siteId != null) 'site_id': siteId,
      if (workOrderId != null) 'work_order_id': workOrderId,
      if (noteType != null) 'note_type': noteType,
      if (noteText != null) 'note_text': noteText,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
    });
  }

  NotesCompanion copyWith(
      {Value<int>? id,
      Value<int>? siteId,
      Value<int?>? workOrderId,
      Value<String>? noteType,
      Value<String>? noteText,
      Value<DateTime>? createdAt,
      Value<String?>? createdBy}) {
    return NotesCompanion(
      id: id ?? this.id,
      siteId: siteId ?? this.siteId,
      workOrderId: workOrderId ?? this.workOrderId,
      noteType: noteType ?? this.noteType,
      noteText: noteText ?? this.noteText,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (siteId.present) {
      map['site_id'] = Variable<int>(siteId.value);
    }
    if (workOrderId.present) {
      map['work_order_id'] = Variable<int>(workOrderId.value);
    }
    if (noteType.present) {
      map['note_type'] = Variable<String>(noteType.value);
    }
    if (noteText.present) {
      map['note_text'] = Variable<String>(noteText.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('siteId: $siteId, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('noteType: $noteType, ')
          ..write('noteText: $noteText, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy')
          ..write(')'))
        .toString();
  }
}

class $DocumentsTable extends Documents
    with TableInfo<$DocumentsTable, Document> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _workOrderIdMeta =
      const VerificationMeta('workOrderId');
  @override
  late final GeneratedColumn<int> workOrderId = GeneratedColumn<int>(
      'work_order_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _siteIdMeta = const VerificationMeta('siteId');
  @override
  late final GeneratedColumn<int> siteId = GeneratedColumn<int>(
      'site_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _fileNameMeta =
      const VerificationMeta('fileName');
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
      'file_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _filePathMeta =
      const VerificationMeta('filePath');
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
      'file_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _uploadedAtMeta =
      const VerificationMeta('uploadedAt');
  @override
  late final GeneratedColumn<DateTime> uploadedAt = GeneratedColumn<DateTime>(
      'uploaded_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _uploadedByMeta =
      const VerificationMeta('uploadedBy');
  @override
  late final GeneratedColumn<String> uploadedBy = GeneratedColumn<String>(
      'uploaded_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, workOrderId, siteId, fileName, filePath, uploadedAt, uploadedBy];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents';
  @override
  VerificationContext validateIntegrity(Insertable<Document> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('work_order_id')) {
      context.handle(
          _workOrderIdMeta,
          workOrderId.isAcceptableOrUnknown(
              data['work_order_id']!, _workOrderIdMeta));
    }
    if (data.containsKey('site_id')) {
      context.handle(_siteIdMeta,
          siteId.isAcceptableOrUnknown(data['site_id']!, _siteIdMeta));
    }
    if (data.containsKey('file_name')) {
      context.handle(_fileNameMeta,
          fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta));
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(_filePathMeta,
          filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta));
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('uploaded_at')) {
      context.handle(
          _uploadedAtMeta,
          uploadedAt.isAcceptableOrUnknown(
              data['uploaded_at']!, _uploadedAtMeta));
    } else if (isInserting) {
      context.missing(_uploadedAtMeta);
    }
    if (data.containsKey('uploaded_by')) {
      context.handle(
          _uploadedByMeta,
          uploadedBy.isAcceptableOrUnknown(
              data['uploaded_by']!, _uploadedByMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Document map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Document(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      workOrderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}work_order_id']),
      siteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}site_id']),
      fileName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_name'])!,
      filePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_path'])!,
      uploadedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}uploaded_at'])!,
      uploadedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uploaded_by']),
    );
  }

  @override
  $DocumentsTable createAlias(String alias) {
    return $DocumentsTable(attachedDatabase, alias);
  }
}

class Document extends DataClass implements Insertable<Document> {
  final int id;
  final int? workOrderId;
  final int? siteId;
  final String fileName;
  final String filePath;
  final DateTime uploadedAt;
  final String? uploadedBy;
  const Document(
      {required this.id,
      this.workOrderId,
      this.siteId,
      required this.fileName,
      required this.filePath,
      required this.uploadedAt,
      this.uploadedBy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || workOrderId != null) {
      map['work_order_id'] = Variable<int>(workOrderId);
    }
    if (!nullToAbsent || siteId != null) {
      map['site_id'] = Variable<int>(siteId);
    }
    map['file_name'] = Variable<String>(fileName);
    map['file_path'] = Variable<String>(filePath);
    map['uploaded_at'] = Variable<DateTime>(uploadedAt);
    if (!nullToAbsent || uploadedBy != null) {
      map['uploaded_by'] = Variable<String>(uploadedBy);
    }
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      id: Value(id),
      workOrderId: workOrderId == null && nullToAbsent
          ? const Value.absent()
          : Value(workOrderId),
      siteId:
          siteId == null && nullToAbsent ? const Value.absent() : Value(siteId),
      fileName: Value(fileName),
      filePath: Value(filePath),
      uploadedAt: Value(uploadedAt),
      uploadedBy: uploadedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(uploadedBy),
    );
  }

  factory Document.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Document(
      id: serializer.fromJson<int>(json['id']),
      workOrderId: serializer.fromJson<int?>(json['workOrderId']),
      siteId: serializer.fromJson<int?>(json['siteId']),
      fileName: serializer.fromJson<String>(json['fileName']),
      filePath: serializer.fromJson<String>(json['filePath']),
      uploadedAt: serializer.fromJson<DateTime>(json['uploadedAt']),
      uploadedBy: serializer.fromJson<String?>(json['uploadedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'workOrderId': serializer.toJson<int?>(workOrderId),
      'siteId': serializer.toJson<int?>(siteId),
      'fileName': serializer.toJson<String>(fileName),
      'filePath': serializer.toJson<String>(filePath),
      'uploadedAt': serializer.toJson<DateTime>(uploadedAt),
      'uploadedBy': serializer.toJson<String?>(uploadedBy),
    };
  }

  Document copyWith(
          {int? id,
          Value<int?> workOrderId = const Value.absent(),
          Value<int?> siteId = const Value.absent(),
          String? fileName,
          String? filePath,
          DateTime? uploadedAt,
          Value<String?> uploadedBy = const Value.absent()}) =>
      Document(
        id: id ?? this.id,
        workOrderId: workOrderId.present ? workOrderId.value : this.workOrderId,
        siteId: siteId.present ? siteId.value : this.siteId,
        fileName: fileName ?? this.fileName,
        filePath: filePath ?? this.filePath,
        uploadedAt: uploadedAt ?? this.uploadedAt,
        uploadedBy: uploadedBy.present ? uploadedBy.value : this.uploadedBy,
      );
  Document copyWithCompanion(DocumentsCompanion data) {
    return Document(
      id: data.id.present ? data.id.value : this.id,
      workOrderId:
          data.workOrderId.present ? data.workOrderId.value : this.workOrderId,
      siteId: data.siteId.present ? data.siteId.value : this.siteId,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      uploadedAt:
          data.uploadedAt.present ? data.uploadedAt.value : this.uploadedAt,
      uploadedBy:
          data.uploadedBy.present ? data.uploadedBy.value : this.uploadedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Document(')
          ..write('id: $id, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('siteId: $siteId, ')
          ..write('fileName: $fileName, ')
          ..write('filePath: $filePath, ')
          ..write('uploadedAt: $uploadedAt, ')
          ..write('uploadedBy: $uploadedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, workOrderId, siteId, fileName, filePath, uploadedAt, uploadedBy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Document &&
          other.id == this.id &&
          other.workOrderId == this.workOrderId &&
          other.siteId == this.siteId &&
          other.fileName == this.fileName &&
          other.filePath == this.filePath &&
          other.uploadedAt == this.uploadedAt &&
          other.uploadedBy == this.uploadedBy);
}

class DocumentsCompanion extends UpdateCompanion<Document> {
  final Value<int> id;
  final Value<int?> workOrderId;
  final Value<int?> siteId;
  final Value<String> fileName;
  final Value<String> filePath;
  final Value<DateTime> uploadedAt;
  final Value<String?> uploadedBy;
  const DocumentsCompanion({
    this.id = const Value.absent(),
    this.workOrderId = const Value.absent(),
    this.siteId = const Value.absent(),
    this.fileName = const Value.absent(),
    this.filePath = const Value.absent(),
    this.uploadedAt = const Value.absent(),
    this.uploadedBy = const Value.absent(),
  });
  DocumentsCompanion.insert({
    this.id = const Value.absent(),
    this.workOrderId = const Value.absent(),
    this.siteId = const Value.absent(),
    required String fileName,
    required String filePath,
    required DateTime uploadedAt,
    this.uploadedBy = const Value.absent(),
  })  : fileName = Value(fileName),
        filePath = Value(filePath),
        uploadedAt = Value(uploadedAt);
  static Insertable<Document> custom({
    Expression<int>? id,
    Expression<int>? workOrderId,
    Expression<int>? siteId,
    Expression<String>? fileName,
    Expression<String>? filePath,
    Expression<DateTime>? uploadedAt,
    Expression<String>? uploadedBy,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workOrderId != null) 'work_order_id': workOrderId,
      if (siteId != null) 'site_id': siteId,
      if (fileName != null) 'file_name': fileName,
      if (filePath != null) 'file_path': filePath,
      if (uploadedAt != null) 'uploaded_at': uploadedAt,
      if (uploadedBy != null) 'uploaded_by': uploadedBy,
    });
  }

  DocumentsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? workOrderId,
      Value<int?>? siteId,
      Value<String>? fileName,
      Value<String>? filePath,
      Value<DateTime>? uploadedAt,
      Value<String?>? uploadedBy}) {
    return DocumentsCompanion(
      id: id ?? this.id,
      workOrderId: workOrderId ?? this.workOrderId,
      siteId: siteId ?? this.siteId,
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      uploadedBy: uploadedBy ?? this.uploadedBy,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (workOrderId.present) {
      map['work_order_id'] = Variable<int>(workOrderId.value);
    }
    if (siteId.present) {
      map['site_id'] = Variable<int>(siteId.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (uploadedAt.present) {
      map['uploaded_at'] = Variable<DateTime>(uploadedAt.value);
    }
    if (uploadedBy.present) {
      map['uploaded_by'] = Variable<String>(uploadedBy.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('id: $id, ')
          ..write('workOrderId: $workOrderId, ')
          ..write('siteId: $siteId, ')
          ..write('fileName: $fileName, ')
          ..write('filePath: $filePath, ')
          ..write('uploadedAt: $uploadedAt, ')
          ..write('uploadedBy: $uploadedBy')
          ..write(')'))
        .toString();
  }
}

class $KnowledgeEntriesTable extends KnowledgeEntries
    with TableInfo<$KnowledgeEntriesTable, KnowledgeEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KnowledgeEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _summaryMeta =
      const VerificationMeta('summary');
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
      'summary', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _machineProfileIdMeta =
      const VerificationMeta('machineProfileId');
  @override
  late final GeneratedColumn<int> machineProfileId = GeneratedColumn<int>(
      'machine_profile_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _equipmentTypeMeta =
      const VerificationMeta('equipmentType');
  @override
  late final GeneratedColumn<String> equipmentType = GeneratedColumn<String>(
      'equipment_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _equipmentModelMeta =
      const VerificationMeta('equipmentModel');
  @override
  late final GeneratedColumn<String> equipmentModel = GeneratedColumn<String>(
      'equipment_model', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _manufacturerMeta =
      const VerificationMeta('manufacturer');
  @override
  late final GeneratedColumn<String> manufacturer = GeneratedColumn<String>(
      'manufacturer', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _applicableModelsMeta =
      const VerificationMeta('applicableModels');
  @override
  late final GeneratedColumn<String> applicableModels = GeneratedColumn<String>(
      'applicable_models', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _serviceTypeMeta =
      const VerificationMeta('serviceType');
  @override
  late final GeneratedColumn<String> serviceType = GeneratedColumn<String>(
      'service_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('reference'));
  static const VerificationMeta _difficultyLevelMeta =
      const VerificationMeta('difficultyLevel');
  @override
  late final GeneratedColumn<String> difficultyLevel = GeneratedColumn<String>(
      'difficulty_level', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('intermediate'));
  static const VerificationMeta _priorityLevelMeta =
      const VerificationMeta('priorityLevel');
  @override
  late final GeneratedColumn<String> priorityLevel = GeneratedColumn<String>(
      'priority_level', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('standard'));
  static const VerificationMeta _safetyLevelMeta =
      const VerificationMeta('safetyLevel');
  @override
  late final GeneratedColumn<String> safetyLevel = GeneratedColumn<String>(
      'safety_level', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('none'));
  static const VerificationMeta _complianceTagsMeta =
      const VerificationMeta('complianceTags');
  @override
  late final GeneratedColumn<String> complianceTags = GeneratedColumn<String>(
      'compliance_tags', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _estimatedTimeMinutesMeta =
      const VerificationMeta('estimatedTimeMinutes');
  @override
  late final GeneratedColumn<int> estimatedTimeMinutes = GeneratedColumn<int>(
      'estimated_time_minutes', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _requiredToolsMeta =
      const VerificationMeta('requiredTools');
  @override
  late final GeneratedColumn<String> requiredTools = GeneratedColumn<String>(
      'required_tools', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _requiredPartsMeta =
      const VerificationMeta('requiredParts');
  @override
  late final GeneratedColumn<String> requiredParts = GeneratedColumn<String>(
      'required_parts', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _prerequisitesMeta =
      const VerificationMeta('prerequisites');
  @override
  late final GeneratedColumn<String> prerequisites = GeneratedColumn<String>(
      'prerequisites', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _specialRequirementsMeta =
      const VerificationMeta('specialRequirements');
  @override
  late final GeneratedColumn<String> specialRequirements =
      GeneratedColumn<String>('special_requirements', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _symptomsMeta =
      const VerificationMeta('symptoms');
  @override
  late final GeneratedColumn<String> symptoms = GeneratedColumn<String>(
      'symptoms', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _solutionsCountMeta =
      const VerificationMeta('solutionsCount');
  @override
  late final GeneratedColumn<int> solutionsCount = GeneratedColumn<int>(
      'solutions_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _hasImagesMeta =
      const VerificationMeta('hasImages');
  @override
  late final GeneratedColumn<bool> hasImages = GeneratedColumn<bool>(
      'has_images', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("has_images" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _hasAttachmentsMeta =
      const VerificationMeta('hasAttachments');
  @override
  late final GeneratedColumn<bool> hasAttachments = GeneratedColumn<bool>(
      'has_attachments', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("has_attachments" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
      'author', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _authorRoleMeta =
      const VerificationMeta('authorRole');
  @override
  late final GeneratedColumn<String> authorRole = GeneratedColumn<String>(
      'author_role', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _reviewerMeta =
      const VerificationMeta('reviewer');
  @override
  late final GeneratedColumn<String> reviewer = GeneratedColumn<String>(
      'reviewer', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _reviewedAtMeta =
      const VerificationMeta('reviewedAt');
  @override
  late final GeneratedColumn<DateTime> reviewedAt = GeneratedColumn<DateTime>(
      'reviewed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _reviewStatusMeta =
      const VerificationMeta('reviewStatus');
  @override
  late final GeneratedColumn<String> reviewStatus = GeneratedColumn<String>(
      'review_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('draft'));
  static const VerificationMeta _approvalRequiredMeta =
      const VerificationMeta('approvalRequired');
  @override
  late final GeneratedColumn<bool> approvalRequired = GeneratedColumn<bool>(
      'approval_required', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("approval_required" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _changeNotesMeta =
      const VerificationMeta('changeNotes');
  @override
  late final GeneratedColumn<String> changeNotes = GeneratedColumn<String>(
      'change_notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceTypeMeta =
      const VerificationMeta('sourceType');
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
      'source_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceFileMeta =
      const VerificationMeta('sourceFile');
  @override
  late final GeneratedColumn<String> sourceFile = GeneratedColumn<String>(
      'source_file', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _externalIdMeta =
      const VerificationMeta('externalId');
  @override
  late final GeneratedColumn<String> externalId = GeneratedColumn<String>(
      'external_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncSourceMeta =
      const VerificationMeta('syncSource');
  @override
  late final GeneratedColumn<String> syncSource = GeneratedColumn<String>(
      'sync_source', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
      'version', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _publishedAtMeta =
      const VerificationMeta('publishedAt');
  @override
  late final GeneratedColumn<DateTime> publishedAt = GeneratedColumn<DateTime>(
      'published_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _archivedAtMeta =
      const VerificationMeta('archivedAt');
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
      'archived_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        content,
        summary,
        categoryId,
        machineProfileId,
        category,
        equipmentType,
        equipmentModel,
        manufacturer,
        applicableModels,
        serviceType,
        difficultyLevel,
        priorityLevel,
        safetyLevel,
        complianceTags,
        estimatedTimeMinutes,
        requiredTools,
        requiredParts,
        prerequisites,
        specialRequirements,
        symptoms,
        solutionsCount,
        hasImages,
        hasAttachments,
        author,
        authorRole,
        reviewer,
        reviewedAt,
        reviewStatus,
        approvalRequired,
        changeNotes,
        sourceType,
        sourceFile,
        externalId,
        lastSyncedAt,
        syncSource,
        version,
        status,
        createdAt,
        updatedAt,
        publishedAt,
        archivedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'knowledge_entries';
  @override
  VerificationContext validateIntegrity(Insertable<KnowledgeEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(_summaryMeta,
          summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('machine_profile_id')) {
      context.handle(
          _machineProfileIdMeta,
          machineProfileId.isAcceptableOrUnknown(
              data['machine_profile_id']!, _machineProfileIdMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('equipment_type')) {
      context.handle(
          _equipmentTypeMeta,
          equipmentType.isAcceptableOrUnknown(
              data['equipment_type']!, _equipmentTypeMeta));
    } else if (isInserting) {
      context.missing(_equipmentTypeMeta);
    }
    if (data.containsKey('equipment_model')) {
      context.handle(
          _equipmentModelMeta,
          equipmentModel.isAcceptableOrUnknown(
              data['equipment_model']!, _equipmentModelMeta));
    }
    if (data.containsKey('manufacturer')) {
      context.handle(
          _manufacturerMeta,
          manufacturer.isAcceptableOrUnknown(
              data['manufacturer']!, _manufacturerMeta));
    }
    if (data.containsKey('applicable_models')) {
      context.handle(
          _applicableModelsMeta,
          applicableModels.isAcceptableOrUnknown(
              data['applicable_models']!, _applicableModelsMeta));
    }
    if (data.containsKey('service_type')) {
      context.handle(
          _serviceTypeMeta,
          serviceType.isAcceptableOrUnknown(
              data['service_type']!, _serviceTypeMeta));
    }
    if (data.containsKey('difficulty_level')) {
      context.handle(
          _difficultyLevelMeta,
          difficultyLevel.isAcceptableOrUnknown(
              data['difficulty_level']!, _difficultyLevelMeta));
    }
    if (data.containsKey('priority_level')) {
      context.handle(
          _priorityLevelMeta,
          priorityLevel.isAcceptableOrUnknown(
              data['priority_level']!, _priorityLevelMeta));
    }
    if (data.containsKey('safety_level')) {
      context.handle(
          _safetyLevelMeta,
          safetyLevel.isAcceptableOrUnknown(
              data['safety_level']!, _safetyLevelMeta));
    }
    if (data.containsKey('compliance_tags')) {
      context.handle(
          _complianceTagsMeta,
          complianceTags.isAcceptableOrUnknown(
              data['compliance_tags']!, _complianceTagsMeta));
    }
    if (data.containsKey('estimated_time_minutes')) {
      context.handle(
          _estimatedTimeMinutesMeta,
          estimatedTimeMinutes.isAcceptableOrUnknown(
              data['estimated_time_minutes']!, _estimatedTimeMinutesMeta));
    }
    if (data.containsKey('required_tools')) {
      context.handle(
          _requiredToolsMeta,
          requiredTools.isAcceptableOrUnknown(
              data['required_tools']!, _requiredToolsMeta));
    }
    if (data.containsKey('required_parts')) {
      context.handle(
          _requiredPartsMeta,
          requiredParts.isAcceptableOrUnknown(
              data['required_parts']!, _requiredPartsMeta));
    }
    if (data.containsKey('prerequisites')) {
      context.handle(
          _prerequisitesMeta,
          prerequisites.isAcceptableOrUnknown(
              data['prerequisites']!, _prerequisitesMeta));
    }
    if (data.containsKey('special_requirements')) {
      context.handle(
          _specialRequirementsMeta,
          specialRequirements.isAcceptableOrUnknown(
              data['special_requirements']!, _specialRequirementsMeta));
    }
    if (data.containsKey('symptoms')) {
      context.handle(_symptomsMeta,
          symptoms.isAcceptableOrUnknown(data['symptoms']!, _symptomsMeta));
    }
    if (data.containsKey('solutions_count')) {
      context.handle(
          _solutionsCountMeta,
          solutionsCount.isAcceptableOrUnknown(
              data['solutions_count']!, _solutionsCountMeta));
    }
    if (data.containsKey('has_images')) {
      context.handle(_hasImagesMeta,
          hasImages.isAcceptableOrUnknown(data['has_images']!, _hasImagesMeta));
    }
    if (data.containsKey('has_attachments')) {
      context.handle(
          _hasAttachmentsMeta,
          hasAttachments.isAcceptableOrUnknown(
              data['has_attachments']!, _hasAttachmentsMeta));
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    }
    if (data.containsKey('author_role')) {
      context.handle(
          _authorRoleMeta,
          authorRole.isAcceptableOrUnknown(
              data['author_role']!, _authorRoleMeta));
    }
    if (data.containsKey('reviewer')) {
      context.handle(_reviewerMeta,
          reviewer.isAcceptableOrUnknown(data['reviewer']!, _reviewerMeta));
    }
    if (data.containsKey('reviewed_at')) {
      context.handle(
          _reviewedAtMeta,
          reviewedAt.isAcceptableOrUnknown(
              data['reviewed_at']!, _reviewedAtMeta));
    }
    if (data.containsKey('review_status')) {
      context.handle(
          _reviewStatusMeta,
          reviewStatus.isAcceptableOrUnknown(
              data['review_status']!, _reviewStatusMeta));
    }
    if (data.containsKey('approval_required')) {
      context.handle(
          _approvalRequiredMeta,
          approvalRequired.isAcceptableOrUnknown(
              data['approval_required']!, _approvalRequiredMeta));
    }
    if (data.containsKey('change_notes')) {
      context.handle(
          _changeNotesMeta,
          changeNotes.isAcceptableOrUnknown(
              data['change_notes']!, _changeNotesMeta));
    }
    if (data.containsKey('source_type')) {
      context.handle(
          _sourceTypeMeta,
          sourceType.isAcceptableOrUnknown(
              data['source_type']!, _sourceTypeMeta));
    } else if (isInserting) {
      context.missing(_sourceTypeMeta);
    }
    if (data.containsKey('source_file')) {
      context.handle(
          _sourceFileMeta,
          sourceFile.isAcceptableOrUnknown(
              data['source_file']!, _sourceFileMeta));
    } else if (isInserting) {
      context.missing(_sourceFileMeta);
    }
    if (data.containsKey('external_id')) {
      context.handle(
          _externalIdMeta,
          externalId.isAcceptableOrUnknown(
              data['external_id']!, _externalIdMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    if (data.containsKey('sync_source')) {
      context.handle(
          _syncSourceMeta,
          syncSource.isAcceptableOrUnknown(
              data['sync_source']!, _syncSourceMeta));
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('published_at')) {
      context.handle(
          _publishedAtMeta,
          publishedAt.isAcceptableOrUnknown(
              data['published_at']!, _publishedAtMeta));
    }
    if (data.containsKey('archived_at')) {
      context.handle(
          _archivedAtMeta,
          archivedAt.isAcceptableOrUnknown(
              data['archived_at']!, _archivedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KnowledgeEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KnowledgeEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      summary: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}summary'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id']),
      machineProfileId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}machine_profile_id']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      equipmentType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}equipment_type'])!,
      equipmentModel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}equipment_model']),
      manufacturer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}manufacturer']),
      applicableModels: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}applicable_models']),
      serviceType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}service_type'])!,
      difficultyLevel: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}difficulty_level'])!,
      priorityLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}priority_level'])!,
      safetyLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}safety_level'])!,
      complianceTags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}compliance_tags']),
      estimatedTimeMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}estimated_time_minutes']),
      requiredTools: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}required_tools']),
      requiredParts: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}required_parts']),
      prerequisites: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}prerequisites']),
      specialRequirements: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}special_requirements']),
      symptoms: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}symptoms']),
      solutionsCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}solutions_count'])!,
      hasImages: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}has_images'])!,
      hasAttachments: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}has_attachments'])!,
      author: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author']),
      authorRole: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author_role']),
      reviewer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reviewer']),
      reviewedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}reviewed_at']),
      reviewStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}review_status'])!,
      approvalRequired: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}approval_required'])!,
      changeNotes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}change_notes']),
      sourceType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_type'])!,
      sourceFile: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_file'])!,
      externalId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}external_id']),
      lastSyncedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_synced_at']),
      syncSource: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_source']),
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}version'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      publishedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}published_at']),
      archivedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}archived_at']),
    );
  }

  @override
  $KnowledgeEntriesTable createAlias(String alias) {
    return $KnowledgeEntriesTable(attachedDatabase, alias);
  }
}

class KnowledgeEntry extends DataClass implements Insertable<KnowledgeEntry> {
  final String id;
  final String title;
  final String content;
  final String summary;
  final int? categoryId;
  final int? machineProfileId;
  final String category;
  final String equipmentType;
  final String? equipmentModel;
  final String? manufacturer;
  final String? applicableModels;
  final String serviceType;
  final String difficultyLevel;
  final String priorityLevel;
  final String safetyLevel;
  final String? complianceTags;
  final int? estimatedTimeMinutes;
  final String? requiredTools;
  final String? requiredParts;
  final String? prerequisites;
  final String? specialRequirements;
  final String? symptoms;
  final int solutionsCount;
  final bool hasImages;
  final bool hasAttachments;
  final String? author;
  final String? authorRole;
  final String? reviewer;
  final DateTime? reviewedAt;
  final String reviewStatus;
  final bool approvalRequired;
  final String? changeNotes;
  final String sourceType;
  final String sourceFile;
  final String? externalId;
  final DateTime? lastSyncedAt;
  final String? syncSource;
  final String version;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? publishedAt;
  final DateTime? archivedAt;
  const KnowledgeEntry(
      {required this.id,
      required this.title,
      required this.content,
      required this.summary,
      this.categoryId,
      this.machineProfileId,
      required this.category,
      required this.equipmentType,
      this.equipmentModel,
      this.manufacturer,
      this.applicableModels,
      required this.serviceType,
      required this.difficultyLevel,
      required this.priorityLevel,
      required this.safetyLevel,
      this.complianceTags,
      this.estimatedTimeMinutes,
      this.requiredTools,
      this.requiredParts,
      this.prerequisites,
      this.specialRequirements,
      this.symptoms,
      required this.solutionsCount,
      required this.hasImages,
      required this.hasAttachments,
      this.author,
      this.authorRole,
      this.reviewer,
      this.reviewedAt,
      required this.reviewStatus,
      required this.approvalRequired,
      this.changeNotes,
      required this.sourceType,
      required this.sourceFile,
      this.externalId,
      this.lastSyncedAt,
      this.syncSource,
      required this.version,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      this.publishedAt,
      this.archivedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['summary'] = Variable<String>(summary);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    if (!nullToAbsent || machineProfileId != null) {
      map['machine_profile_id'] = Variable<int>(machineProfileId);
    }
    map['category'] = Variable<String>(category);
    map['equipment_type'] = Variable<String>(equipmentType);
    if (!nullToAbsent || equipmentModel != null) {
      map['equipment_model'] = Variable<String>(equipmentModel);
    }
    if (!nullToAbsent || manufacturer != null) {
      map['manufacturer'] = Variable<String>(manufacturer);
    }
    if (!nullToAbsent || applicableModels != null) {
      map['applicable_models'] = Variable<String>(applicableModels);
    }
    map['service_type'] = Variable<String>(serviceType);
    map['difficulty_level'] = Variable<String>(difficultyLevel);
    map['priority_level'] = Variable<String>(priorityLevel);
    map['safety_level'] = Variable<String>(safetyLevel);
    if (!nullToAbsent || complianceTags != null) {
      map['compliance_tags'] = Variable<String>(complianceTags);
    }
    if (!nullToAbsent || estimatedTimeMinutes != null) {
      map['estimated_time_minutes'] = Variable<int>(estimatedTimeMinutes);
    }
    if (!nullToAbsent || requiredTools != null) {
      map['required_tools'] = Variable<String>(requiredTools);
    }
    if (!nullToAbsent || requiredParts != null) {
      map['required_parts'] = Variable<String>(requiredParts);
    }
    if (!nullToAbsent || prerequisites != null) {
      map['prerequisites'] = Variable<String>(prerequisites);
    }
    if (!nullToAbsent || specialRequirements != null) {
      map['special_requirements'] = Variable<String>(specialRequirements);
    }
    if (!nullToAbsent || symptoms != null) {
      map['symptoms'] = Variable<String>(symptoms);
    }
    map['solutions_count'] = Variable<int>(solutionsCount);
    map['has_images'] = Variable<bool>(hasImages);
    map['has_attachments'] = Variable<bool>(hasAttachments);
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || authorRole != null) {
      map['author_role'] = Variable<String>(authorRole);
    }
    if (!nullToAbsent || reviewer != null) {
      map['reviewer'] = Variable<String>(reviewer);
    }
    if (!nullToAbsent || reviewedAt != null) {
      map['reviewed_at'] = Variable<DateTime>(reviewedAt);
    }
    map['review_status'] = Variable<String>(reviewStatus);
    map['approval_required'] = Variable<bool>(approvalRequired);
    if (!nullToAbsent || changeNotes != null) {
      map['change_notes'] = Variable<String>(changeNotes);
    }
    map['source_type'] = Variable<String>(sourceType);
    map['source_file'] = Variable<String>(sourceFile);
    if (!nullToAbsent || externalId != null) {
      map['external_id'] = Variable<String>(externalId);
    }
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    if (!nullToAbsent || syncSource != null) {
      map['sync_source'] = Variable<String>(syncSource);
    }
    map['version'] = Variable<String>(version);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || publishedAt != null) {
      map['published_at'] = Variable<DateTime>(publishedAt);
    }
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    return map;
  }

  KnowledgeEntriesCompanion toCompanion(bool nullToAbsent) {
    return KnowledgeEntriesCompanion(
      id: Value(id),
      title: Value(title),
      content: Value(content),
      summary: Value(summary),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      machineProfileId: machineProfileId == null && nullToAbsent
          ? const Value.absent()
          : Value(machineProfileId),
      category: Value(category),
      equipmentType: Value(equipmentType),
      equipmentModel: equipmentModel == null && nullToAbsent
          ? const Value.absent()
          : Value(equipmentModel),
      manufacturer: manufacturer == null && nullToAbsent
          ? const Value.absent()
          : Value(manufacturer),
      applicableModels: applicableModels == null && nullToAbsent
          ? const Value.absent()
          : Value(applicableModels),
      serviceType: Value(serviceType),
      difficultyLevel: Value(difficultyLevel),
      priorityLevel: Value(priorityLevel),
      safetyLevel: Value(safetyLevel),
      complianceTags: complianceTags == null && nullToAbsent
          ? const Value.absent()
          : Value(complianceTags),
      estimatedTimeMinutes: estimatedTimeMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedTimeMinutes),
      requiredTools: requiredTools == null && nullToAbsent
          ? const Value.absent()
          : Value(requiredTools),
      requiredParts: requiredParts == null && nullToAbsent
          ? const Value.absent()
          : Value(requiredParts),
      prerequisites: prerequisites == null && nullToAbsent
          ? const Value.absent()
          : Value(prerequisites),
      specialRequirements: specialRequirements == null && nullToAbsent
          ? const Value.absent()
          : Value(specialRequirements),
      symptoms: symptoms == null && nullToAbsent
          ? const Value.absent()
          : Value(symptoms),
      solutionsCount: Value(solutionsCount),
      hasImages: Value(hasImages),
      hasAttachments: Value(hasAttachments),
      author:
          author == null && nullToAbsent ? const Value.absent() : Value(author),
      authorRole: authorRole == null && nullToAbsent
          ? const Value.absent()
          : Value(authorRole),
      reviewer: reviewer == null && nullToAbsent
          ? const Value.absent()
          : Value(reviewer),
      reviewedAt: reviewedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(reviewedAt),
      reviewStatus: Value(reviewStatus),
      approvalRequired: Value(approvalRequired),
      changeNotes: changeNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(changeNotes),
      sourceType: Value(sourceType),
      sourceFile: Value(sourceFile),
      externalId: externalId == null && nullToAbsent
          ? const Value.absent()
          : Value(externalId),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      syncSource: syncSource == null && nullToAbsent
          ? const Value.absent()
          : Value(syncSource),
      version: Value(version),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      publishedAt: publishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedAt),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
    );
  }

  factory KnowledgeEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KnowledgeEntry(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      summary: serializer.fromJson<String>(json['summary']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      machineProfileId: serializer.fromJson<int?>(json['machineProfileId']),
      category: serializer.fromJson<String>(json['category']),
      equipmentType: serializer.fromJson<String>(json['equipmentType']),
      equipmentModel: serializer.fromJson<String?>(json['equipmentModel']),
      manufacturer: serializer.fromJson<String?>(json['manufacturer']),
      applicableModels: serializer.fromJson<String?>(json['applicableModels']),
      serviceType: serializer.fromJson<String>(json['serviceType']),
      difficultyLevel: serializer.fromJson<String>(json['difficultyLevel']),
      priorityLevel: serializer.fromJson<String>(json['priorityLevel']),
      safetyLevel: serializer.fromJson<String>(json['safetyLevel']),
      complianceTags: serializer.fromJson<String?>(json['complianceTags']),
      estimatedTimeMinutes:
          serializer.fromJson<int?>(json['estimatedTimeMinutes']),
      requiredTools: serializer.fromJson<String?>(json['requiredTools']),
      requiredParts: serializer.fromJson<String?>(json['requiredParts']),
      prerequisites: serializer.fromJson<String?>(json['prerequisites']),
      specialRequirements:
          serializer.fromJson<String?>(json['specialRequirements']),
      symptoms: serializer.fromJson<String?>(json['symptoms']),
      solutionsCount: serializer.fromJson<int>(json['solutionsCount']),
      hasImages: serializer.fromJson<bool>(json['hasImages']),
      hasAttachments: serializer.fromJson<bool>(json['hasAttachments']),
      author: serializer.fromJson<String?>(json['author']),
      authorRole: serializer.fromJson<String?>(json['authorRole']),
      reviewer: serializer.fromJson<String?>(json['reviewer']),
      reviewedAt: serializer.fromJson<DateTime?>(json['reviewedAt']),
      reviewStatus: serializer.fromJson<String>(json['reviewStatus']),
      approvalRequired: serializer.fromJson<bool>(json['approvalRequired']),
      changeNotes: serializer.fromJson<String?>(json['changeNotes']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      sourceFile: serializer.fromJson<String>(json['sourceFile']),
      externalId: serializer.fromJson<String?>(json['externalId']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
      syncSource: serializer.fromJson<String?>(json['syncSource']),
      version: serializer.fromJson<String>(json['version']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      publishedAt: serializer.fromJson<DateTime?>(json['publishedAt']),
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'summary': serializer.toJson<String>(summary),
      'categoryId': serializer.toJson<int?>(categoryId),
      'machineProfileId': serializer.toJson<int?>(machineProfileId),
      'category': serializer.toJson<String>(category),
      'equipmentType': serializer.toJson<String>(equipmentType),
      'equipmentModel': serializer.toJson<String?>(equipmentModel),
      'manufacturer': serializer.toJson<String?>(manufacturer),
      'applicableModels': serializer.toJson<String?>(applicableModels),
      'serviceType': serializer.toJson<String>(serviceType),
      'difficultyLevel': serializer.toJson<String>(difficultyLevel),
      'priorityLevel': serializer.toJson<String>(priorityLevel),
      'safetyLevel': serializer.toJson<String>(safetyLevel),
      'complianceTags': serializer.toJson<String?>(complianceTags),
      'estimatedTimeMinutes': serializer.toJson<int?>(estimatedTimeMinutes),
      'requiredTools': serializer.toJson<String?>(requiredTools),
      'requiredParts': serializer.toJson<String?>(requiredParts),
      'prerequisites': serializer.toJson<String?>(prerequisites),
      'specialRequirements': serializer.toJson<String?>(specialRequirements),
      'symptoms': serializer.toJson<String?>(symptoms),
      'solutionsCount': serializer.toJson<int>(solutionsCount),
      'hasImages': serializer.toJson<bool>(hasImages),
      'hasAttachments': serializer.toJson<bool>(hasAttachments),
      'author': serializer.toJson<String?>(author),
      'authorRole': serializer.toJson<String?>(authorRole),
      'reviewer': serializer.toJson<String?>(reviewer),
      'reviewedAt': serializer.toJson<DateTime?>(reviewedAt),
      'reviewStatus': serializer.toJson<String>(reviewStatus),
      'approvalRequired': serializer.toJson<bool>(approvalRequired),
      'changeNotes': serializer.toJson<String?>(changeNotes),
      'sourceType': serializer.toJson<String>(sourceType),
      'sourceFile': serializer.toJson<String>(sourceFile),
      'externalId': serializer.toJson<String?>(externalId),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
      'syncSource': serializer.toJson<String?>(syncSource),
      'version': serializer.toJson<String>(version),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'publishedAt': serializer.toJson<DateTime?>(publishedAt),
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
    };
  }

  KnowledgeEntry copyWith(
          {String? id,
          String? title,
          String? content,
          String? summary,
          Value<int?> categoryId = const Value.absent(),
          Value<int?> machineProfileId = const Value.absent(),
          String? category,
          String? equipmentType,
          Value<String?> equipmentModel = const Value.absent(),
          Value<String?> manufacturer = const Value.absent(),
          Value<String?> applicableModels = const Value.absent(),
          String? serviceType,
          String? difficultyLevel,
          String? priorityLevel,
          String? safetyLevel,
          Value<String?> complianceTags = const Value.absent(),
          Value<int?> estimatedTimeMinutes = const Value.absent(),
          Value<String?> requiredTools = const Value.absent(),
          Value<String?> requiredParts = const Value.absent(),
          Value<String?> prerequisites = const Value.absent(),
          Value<String?> specialRequirements = const Value.absent(),
          Value<String?> symptoms = const Value.absent(),
          int? solutionsCount,
          bool? hasImages,
          bool? hasAttachments,
          Value<String?> author = const Value.absent(),
          Value<String?> authorRole = const Value.absent(),
          Value<String?> reviewer = const Value.absent(),
          Value<DateTime?> reviewedAt = const Value.absent(),
          String? reviewStatus,
          bool? approvalRequired,
          Value<String?> changeNotes = const Value.absent(),
          String? sourceType,
          String? sourceFile,
          Value<String?> externalId = const Value.absent(),
          Value<DateTime?> lastSyncedAt = const Value.absent(),
          Value<String?> syncSource = const Value.absent(),
          String? version,
          String? status,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> publishedAt = const Value.absent(),
          Value<DateTime?> archivedAt = const Value.absent()}) =>
      KnowledgeEntry(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        summary: summary ?? this.summary,
        categoryId: categoryId.present ? categoryId.value : this.categoryId,
        machineProfileId: machineProfileId.present
            ? machineProfileId.value
            : this.machineProfileId,
        category: category ?? this.category,
        equipmentType: equipmentType ?? this.equipmentType,
        equipmentModel:
            equipmentModel.present ? equipmentModel.value : this.equipmentModel,
        manufacturer:
            manufacturer.present ? manufacturer.value : this.manufacturer,
        applicableModels: applicableModels.present
            ? applicableModels.value
            : this.applicableModels,
        serviceType: serviceType ?? this.serviceType,
        difficultyLevel: difficultyLevel ?? this.difficultyLevel,
        priorityLevel: priorityLevel ?? this.priorityLevel,
        safetyLevel: safetyLevel ?? this.safetyLevel,
        complianceTags:
            complianceTags.present ? complianceTags.value : this.complianceTags,
        estimatedTimeMinutes: estimatedTimeMinutes.present
            ? estimatedTimeMinutes.value
            : this.estimatedTimeMinutes,
        requiredTools:
            requiredTools.present ? requiredTools.value : this.requiredTools,
        requiredParts:
            requiredParts.present ? requiredParts.value : this.requiredParts,
        prerequisites:
            prerequisites.present ? prerequisites.value : this.prerequisites,
        specialRequirements: specialRequirements.present
            ? specialRequirements.value
            : this.specialRequirements,
        symptoms: symptoms.present ? symptoms.value : this.symptoms,
        solutionsCount: solutionsCount ?? this.solutionsCount,
        hasImages: hasImages ?? this.hasImages,
        hasAttachments: hasAttachments ?? this.hasAttachments,
        author: author.present ? author.value : this.author,
        authorRole: authorRole.present ? authorRole.value : this.authorRole,
        reviewer: reviewer.present ? reviewer.value : this.reviewer,
        reviewedAt: reviewedAt.present ? reviewedAt.value : this.reviewedAt,
        reviewStatus: reviewStatus ?? this.reviewStatus,
        approvalRequired: approvalRequired ?? this.approvalRequired,
        changeNotes: changeNotes.present ? changeNotes.value : this.changeNotes,
        sourceType: sourceType ?? this.sourceType,
        sourceFile: sourceFile ?? this.sourceFile,
        externalId: externalId.present ? externalId.value : this.externalId,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
        syncSource: syncSource.present ? syncSource.value : this.syncSource,
        version: version ?? this.version,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        publishedAt: publishedAt.present ? publishedAt.value : this.publishedAt,
        archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
      );
  KnowledgeEntry copyWithCompanion(KnowledgeEntriesCompanion data) {
    return KnowledgeEntry(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      summary: data.summary.present ? data.summary.value : this.summary,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      machineProfileId: data.machineProfileId.present
          ? data.machineProfileId.value
          : this.machineProfileId,
      category: data.category.present ? data.category.value : this.category,
      equipmentType: data.equipmentType.present
          ? data.equipmentType.value
          : this.equipmentType,
      equipmentModel: data.equipmentModel.present
          ? data.equipmentModel.value
          : this.equipmentModel,
      manufacturer: data.manufacturer.present
          ? data.manufacturer.value
          : this.manufacturer,
      applicableModels: data.applicableModels.present
          ? data.applicableModels.value
          : this.applicableModels,
      serviceType:
          data.serviceType.present ? data.serviceType.value : this.serviceType,
      difficultyLevel: data.difficultyLevel.present
          ? data.difficultyLevel.value
          : this.difficultyLevel,
      priorityLevel: data.priorityLevel.present
          ? data.priorityLevel.value
          : this.priorityLevel,
      safetyLevel:
          data.safetyLevel.present ? data.safetyLevel.value : this.safetyLevel,
      complianceTags: data.complianceTags.present
          ? data.complianceTags.value
          : this.complianceTags,
      estimatedTimeMinutes: data.estimatedTimeMinutes.present
          ? data.estimatedTimeMinutes.value
          : this.estimatedTimeMinutes,
      requiredTools: data.requiredTools.present
          ? data.requiredTools.value
          : this.requiredTools,
      requiredParts: data.requiredParts.present
          ? data.requiredParts.value
          : this.requiredParts,
      prerequisites: data.prerequisites.present
          ? data.prerequisites.value
          : this.prerequisites,
      specialRequirements: data.specialRequirements.present
          ? data.specialRequirements.value
          : this.specialRequirements,
      symptoms: data.symptoms.present ? data.symptoms.value : this.symptoms,
      solutionsCount: data.solutionsCount.present
          ? data.solutionsCount.value
          : this.solutionsCount,
      hasImages: data.hasImages.present ? data.hasImages.value : this.hasImages,
      hasAttachments: data.hasAttachments.present
          ? data.hasAttachments.value
          : this.hasAttachments,
      author: data.author.present ? data.author.value : this.author,
      authorRole:
          data.authorRole.present ? data.authorRole.value : this.authorRole,
      reviewer: data.reviewer.present ? data.reviewer.value : this.reviewer,
      reviewedAt:
          data.reviewedAt.present ? data.reviewedAt.value : this.reviewedAt,
      reviewStatus: data.reviewStatus.present
          ? data.reviewStatus.value
          : this.reviewStatus,
      approvalRequired: data.approvalRequired.present
          ? data.approvalRequired.value
          : this.approvalRequired,
      changeNotes:
          data.changeNotes.present ? data.changeNotes.value : this.changeNotes,
      sourceType:
          data.sourceType.present ? data.sourceType.value : this.sourceType,
      sourceFile:
          data.sourceFile.present ? data.sourceFile.value : this.sourceFile,
      externalId:
          data.externalId.present ? data.externalId.value : this.externalId,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      syncSource:
          data.syncSource.present ? data.syncSource.value : this.syncSource,
      version: data.version.present ? data.version.value : this.version,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      publishedAt:
          data.publishedAt.present ? data.publishedAt.value : this.publishedAt,
      archivedAt:
          data.archivedAt.present ? data.archivedAt.value : this.archivedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeEntry(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('summary: $summary, ')
          ..write('categoryId: $categoryId, ')
          ..write('machineProfileId: $machineProfileId, ')
          ..write('category: $category, ')
          ..write('equipmentType: $equipmentType, ')
          ..write('equipmentModel: $equipmentModel, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('applicableModels: $applicableModels, ')
          ..write('serviceType: $serviceType, ')
          ..write('difficultyLevel: $difficultyLevel, ')
          ..write('priorityLevel: $priorityLevel, ')
          ..write('safetyLevel: $safetyLevel, ')
          ..write('complianceTags: $complianceTags, ')
          ..write('estimatedTimeMinutes: $estimatedTimeMinutes, ')
          ..write('requiredTools: $requiredTools, ')
          ..write('requiredParts: $requiredParts, ')
          ..write('prerequisites: $prerequisites, ')
          ..write('specialRequirements: $specialRequirements, ')
          ..write('symptoms: $symptoms, ')
          ..write('solutionsCount: $solutionsCount, ')
          ..write('hasImages: $hasImages, ')
          ..write('hasAttachments: $hasAttachments, ')
          ..write('author: $author, ')
          ..write('authorRole: $authorRole, ')
          ..write('reviewer: $reviewer, ')
          ..write('reviewedAt: $reviewedAt, ')
          ..write('reviewStatus: $reviewStatus, ')
          ..write('approvalRequired: $approvalRequired, ')
          ..write('changeNotes: $changeNotes, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceFile: $sourceFile, ')
          ..write('externalId: $externalId, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('syncSource: $syncSource, ')
          ..write('version: $version, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('archivedAt: $archivedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        title,
        content,
        summary,
        categoryId,
        machineProfileId,
        category,
        equipmentType,
        equipmentModel,
        manufacturer,
        applicableModels,
        serviceType,
        difficultyLevel,
        priorityLevel,
        safetyLevel,
        complianceTags,
        estimatedTimeMinutes,
        requiredTools,
        requiredParts,
        prerequisites,
        specialRequirements,
        symptoms,
        solutionsCount,
        hasImages,
        hasAttachments,
        author,
        authorRole,
        reviewer,
        reviewedAt,
        reviewStatus,
        approvalRequired,
        changeNotes,
        sourceType,
        sourceFile,
        externalId,
        lastSyncedAt,
        syncSource,
        version,
        status,
        createdAt,
        updatedAt,
        publishedAt,
        archivedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KnowledgeEntry &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.summary == this.summary &&
          other.categoryId == this.categoryId &&
          other.machineProfileId == this.machineProfileId &&
          other.category == this.category &&
          other.equipmentType == this.equipmentType &&
          other.equipmentModel == this.equipmentModel &&
          other.manufacturer == this.manufacturer &&
          other.applicableModels == this.applicableModels &&
          other.serviceType == this.serviceType &&
          other.difficultyLevel == this.difficultyLevel &&
          other.priorityLevel == this.priorityLevel &&
          other.safetyLevel == this.safetyLevel &&
          other.complianceTags == this.complianceTags &&
          other.estimatedTimeMinutes == this.estimatedTimeMinutes &&
          other.requiredTools == this.requiredTools &&
          other.requiredParts == this.requiredParts &&
          other.prerequisites == this.prerequisites &&
          other.specialRequirements == this.specialRequirements &&
          other.symptoms == this.symptoms &&
          other.solutionsCount == this.solutionsCount &&
          other.hasImages == this.hasImages &&
          other.hasAttachments == this.hasAttachments &&
          other.author == this.author &&
          other.authorRole == this.authorRole &&
          other.reviewer == this.reviewer &&
          other.reviewedAt == this.reviewedAt &&
          other.reviewStatus == this.reviewStatus &&
          other.approvalRequired == this.approvalRequired &&
          other.changeNotes == this.changeNotes &&
          other.sourceType == this.sourceType &&
          other.sourceFile == this.sourceFile &&
          other.externalId == this.externalId &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.syncSource == this.syncSource &&
          other.version == this.version &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.publishedAt == this.publishedAt &&
          other.archivedAt == this.archivedAt);
}

class KnowledgeEntriesCompanion extends UpdateCompanion<KnowledgeEntry> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> content;
  final Value<String> summary;
  final Value<int?> categoryId;
  final Value<int?> machineProfileId;
  final Value<String> category;
  final Value<String> equipmentType;
  final Value<String?> equipmentModel;
  final Value<String?> manufacturer;
  final Value<String?> applicableModels;
  final Value<String> serviceType;
  final Value<String> difficultyLevel;
  final Value<String> priorityLevel;
  final Value<String> safetyLevel;
  final Value<String?> complianceTags;
  final Value<int?> estimatedTimeMinutes;
  final Value<String?> requiredTools;
  final Value<String?> requiredParts;
  final Value<String?> prerequisites;
  final Value<String?> specialRequirements;
  final Value<String?> symptoms;
  final Value<int> solutionsCount;
  final Value<bool> hasImages;
  final Value<bool> hasAttachments;
  final Value<String?> author;
  final Value<String?> authorRole;
  final Value<String?> reviewer;
  final Value<DateTime?> reviewedAt;
  final Value<String> reviewStatus;
  final Value<bool> approvalRequired;
  final Value<String?> changeNotes;
  final Value<String> sourceType;
  final Value<String> sourceFile;
  final Value<String?> externalId;
  final Value<DateTime?> lastSyncedAt;
  final Value<String?> syncSource;
  final Value<String> version;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> publishedAt;
  final Value<DateTime?> archivedAt;
  final Value<int> rowid;
  const KnowledgeEntriesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.summary = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.machineProfileId = const Value.absent(),
    this.category = const Value.absent(),
    this.equipmentType = const Value.absent(),
    this.equipmentModel = const Value.absent(),
    this.manufacturer = const Value.absent(),
    this.applicableModels = const Value.absent(),
    this.serviceType = const Value.absent(),
    this.difficultyLevel = const Value.absent(),
    this.priorityLevel = const Value.absent(),
    this.safetyLevel = const Value.absent(),
    this.complianceTags = const Value.absent(),
    this.estimatedTimeMinutes = const Value.absent(),
    this.requiredTools = const Value.absent(),
    this.requiredParts = const Value.absent(),
    this.prerequisites = const Value.absent(),
    this.specialRequirements = const Value.absent(),
    this.symptoms = const Value.absent(),
    this.solutionsCount = const Value.absent(),
    this.hasImages = const Value.absent(),
    this.hasAttachments = const Value.absent(),
    this.author = const Value.absent(),
    this.authorRole = const Value.absent(),
    this.reviewer = const Value.absent(),
    this.reviewedAt = const Value.absent(),
    this.reviewStatus = const Value.absent(),
    this.approvalRequired = const Value.absent(),
    this.changeNotes = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceFile = const Value.absent(),
    this.externalId = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.syncSource = const Value.absent(),
    this.version = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KnowledgeEntriesCompanion.insert({
    required String id,
    required String title,
    required String content,
    this.summary = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.machineProfileId = const Value.absent(),
    required String category,
    required String equipmentType,
    this.equipmentModel = const Value.absent(),
    this.manufacturer = const Value.absent(),
    this.applicableModels = const Value.absent(),
    this.serviceType = const Value.absent(),
    this.difficultyLevel = const Value.absent(),
    this.priorityLevel = const Value.absent(),
    this.safetyLevel = const Value.absent(),
    this.complianceTags = const Value.absent(),
    this.estimatedTimeMinutes = const Value.absent(),
    this.requiredTools = const Value.absent(),
    this.requiredParts = const Value.absent(),
    this.prerequisites = const Value.absent(),
    this.specialRequirements = const Value.absent(),
    this.symptoms = const Value.absent(),
    this.solutionsCount = const Value.absent(),
    this.hasImages = const Value.absent(),
    this.hasAttachments = const Value.absent(),
    this.author = const Value.absent(),
    this.authorRole = const Value.absent(),
    this.reviewer = const Value.absent(),
    this.reviewedAt = const Value.absent(),
    this.reviewStatus = const Value.absent(),
    this.approvalRequired = const Value.absent(),
    this.changeNotes = const Value.absent(),
    required String sourceType,
    required String sourceFile,
    this.externalId = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.syncSource = const Value.absent(),
    required String version,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.publishedAt = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        content = Value(content),
        category = Value(category),
        equipmentType = Value(equipmentType),
        sourceType = Value(sourceType),
        sourceFile = Value(sourceFile),
        version = Value(version),
        status = Value(status),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<KnowledgeEntry> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? summary,
    Expression<int>? categoryId,
    Expression<int>? machineProfileId,
    Expression<String>? category,
    Expression<String>? equipmentType,
    Expression<String>? equipmentModel,
    Expression<String>? manufacturer,
    Expression<String>? applicableModels,
    Expression<String>? serviceType,
    Expression<String>? difficultyLevel,
    Expression<String>? priorityLevel,
    Expression<String>? safetyLevel,
    Expression<String>? complianceTags,
    Expression<int>? estimatedTimeMinutes,
    Expression<String>? requiredTools,
    Expression<String>? requiredParts,
    Expression<String>? prerequisites,
    Expression<String>? specialRequirements,
    Expression<String>? symptoms,
    Expression<int>? solutionsCount,
    Expression<bool>? hasImages,
    Expression<bool>? hasAttachments,
    Expression<String>? author,
    Expression<String>? authorRole,
    Expression<String>? reviewer,
    Expression<DateTime>? reviewedAt,
    Expression<String>? reviewStatus,
    Expression<bool>? approvalRequired,
    Expression<String>? changeNotes,
    Expression<String>? sourceType,
    Expression<String>? sourceFile,
    Expression<String>? externalId,
    Expression<DateTime>? lastSyncedAt,
    Expression<String>? syncSource,
    Expression<String>? version,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? publishedAt,
    Expression<DateTime>? archivedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (summary != null) 'summary': summary,
      if (categoryId != null) 'category_id': categoryId,
      if (machineProfileId != null) 'machine_profile_id': machineProfileId,
      if (category != null) 'category': category,
      if (equipmentType != null) 'equipment_type': equipmentType,
      if (equipmentModel != null) 'equipment_model': equipmentModel,
      if (manufacturer != null) 'manufacturer': manufacturer,
      if (applicableModels != null) 'applicable_models': applicableModels,
      if (serviceType != null) 'service_type': serviceType,
      if (difficultyLevel != null) 'difficulty_level': difficultyLevel,
      if (priorityLevel != null) 'priority_level': priorityLevel,
      if (safetyLevel != null) 'safety_level': safetyLevel,
      if (complianceTags != null) 'compliance_tags': complianceTags,
      if (estimatedTimeMinutes != null)
        'estimated_time_minutes': estimatedTimeMinutes,
      if (requiredTools != null) 'required_tools': requiredTools,
      if (requiredParts != null) 'required_parts': requiredParts,
      if (prerequisites != null) 'prerequisites': prerequisites,
      if (specialRequirements != null)
        'special_requirements': specialRequirements,
      if (symptoms != null) 'symptoms': symptoms,
      if (solutionsCount != null) 'solutions_count': solutionsCount,
      if (hasImages != null) 'has_images': hasImages,
      if (hasAttachments != null) 'has_attachments': hasAttachments,
      if (author != null) 'author': author,
      if (authorRole != null) 'author_role': authorRole,
      if (reviewer != null) 'reviewer': reviewer,
      if (reviewedAt != null) 'reviewed_at': reviewedAt,
      if (reviewStatus != null) 'review_status': reviewStatus,
      if (approvalRequired != null) 'approval_required': approvalRequired,
      if (changeNotes != null) 'change_notes': changeNotes,
      if (sourceType != null) 'source_type': sourceType,
      if (sourceFile != null) 'source_file': sourceFile,
      if (externalId != null) 'external_id': externalId,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (syncSource != null) 'sync_source': syncSource,
      if (version != null) 'version': version,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (publishedAt != null) 'published_at': publishedAt,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KnowledgeEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? content,
      Value<String>? summary,
      Value<int?>? categoryId,
      Value<int?>? machineProfileId,
      Value<String>? category,
      Value<String>? equipmentType,
      Value<String?>? equipmentModel,
      Value<String?>? manufacturer,
      Value<String?>? applicableModels,
      Value<String>? serviceType,
      Value<String>? difficultyLevel,
      Value<String>? priorityLevel,
      Value<String>? safetyLevel,
      Value<String?>? complianceTags,
      Value<int?>? estimatedTimeMinutes,
      Value<String?>? requiredTools,
      Value<String?>? requiredParts,
      Value<String?>? prerequisites,
      Value<String?>? specialRequirements,
      Value<String?>? symptoms,
      Value<int>? solutionsCount,
      Value<bool>? hasImages,
      Value<bool>? hasAttachments,
      Value<String?>? author,
      Value<String?>? authorRole,
      Value<String?>? reviewer,
      Value<DateTime?>? reviewedAt,
      Value<String>? reviewStatus,
      Value<bool>? approvalRequired,
      Value<String?>? changeNotes,
      Value<String>? sourceType,
      Value<String>? sourceFile,
      Value<String?>? externalId,
      Value<DateTime?>? lastSyncedAt,
      Value<String?>? syncSource,
      Value<String>? version,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? publishedAt,
      Value<DateTime?>? archivedAt,
      Value<int>? rowid}) {
    return KnowledgeEntriesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      summary: summary ?? this.summary,
      categoryId: categoryId ?? this.categoryId,
      machineProfileId: machineProfileId ?? this.machineProfileId,
      category: category ?? this.category,
      equipmentType: equipmentType ?? this.equipmentType,
      equipmentModel: equipmentModel ?? this.equipmentModel,
      manufacturer: manufacturer ?? this.manufacturer,
      applicableModels: applicableModels ?? this.applicableModels,
      serviceType: serviceType ?? this.serviceType,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      priorityLevel: priorityLevel ?? this.priorityLevel,
      safetyLevel: safetyLevel ?? this.safetyLevel,
      complianceTags: complianceTags ?? this.complianceTags,
      estimatedTimeMinutes: estimatedTimeMinutes ?? this.estimatedTimeMinutes,
      requiredTools: requiredTools ?? this.requiredTools,
      requiredParts: requiredParts ?? this.requiredParts,
      prerequisites: prerequisites ?? this.prerequisites,
      specialRequirements: specialRequirements ?? this.specialRequirements,
      symptoms: symptoms ?? this.symptoms,
      solutionsCount: solutionsCount ?? this.solutionsCount,
      hasImages: hasImages ?? this.hasImages,
      hasAttachments: hasAttachments ?? this.hasAttachments,
      author: author ?? this.author,
      authorRole: authorRole ?? this.authorRole,
      reviewer: reviewer ?? this.reviewer,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      reviewStatus: reviewStatus ?? this.reviewStatus,
      approvalRequired: approvalRequired ?? this.approvalRequired,
      changeNotes: changeNotes ?? this.changeNotes,
      sourceType: sourceType ?? this.sourceType,
      sourceFile: sourceFile ?? this.sourceFile,
      externalId: externalId ?? this.externalId,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      syncSource: syncSource ?? this.syncSource,
      version: version ?? this.version,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      publishedAt: publishedAt ?? this.publishedAt,
      archivedAt: archivedAt ?? this.archivedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (machineProfileId.present) {
      map['machine_profile_id'] = Variable<int>(machineProfileId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (equipmentType.present) {
      map['equipment_type'] = Variable<String>(equipmentType.value);
    }
    if (equipmentModel.present) {
      map['equipment_model'] = Variable<String>(equipmentModel.value);
    }
    if (manufacturer.present) {
      map['manufacturer'] = Variable<String>(manufacturer.value);
    }
    if (applicableModels.present) {
      map['applicable_models'] = Variable<String>(applicableModels.value);
    }
    if (serviceType.present) {
      map['service_type'] = Variable<String>(serviceType.value);
    }
    if (difficultyLevel.present) {
      map['difficulty_level'] = Variable<String>(difficultyLevel.value);
    }
    if (priorityLevel.present) {
      map['priority_level'] = Variable<String>(priorityLevel.value);
    }
    if (safetyLevel.present) {
      map['safety_level'] = Variable<String>(safetyLevel.value);
    }
    if (complianceTags.present) {
      map['compliance_tags'] = Variable<String>(complianceTags.value);
    }
    if (estimatedTimeMinutes.present) {
      map['estimated_time_minutes'] = Variable<int>(estimatedTimeMinutes.value);
    }
    if (requiredTools.present) {
      map['required_tools'] = Variable<String>(requiredTools.value);
    }
    if (requiredParts.present) {
      map['required_parts'] = Variable<String>(requiredParts.value);
    }
    if (prerequisites.present) {
      map['prerequisites'] = Variable<String>(prerequisites.value);
    }
    if (specialRequirements.present) {
      map['special_requirements'] = Variable<String>(specialRequirements.value);
    }
    if (symptoms.present) {
      map['symptoms'] = Variable<String>(symptoms.value);
    }
    if (solutionsCount.present) {
      map['solutions_count'] = Variable<int>(solutionsCount.value);
    }
    if (hasImages.present) {
      map['has_images'] = Variable<bool>(hasImages.value);
    }
    if (hasAttachments.present) {
      map['has_attachments'] = Variable<bool>(hasAttachments.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (authorRole.present) {
      map['author_role'] = Variable<String>(authorRole.value);
    }
    if (reviewer.present) {
      map['reviewer'] = Variable<String>(reviewer.value);
    }
    if (reviewedAt.present) {
      map['reviewed_at'] = Variable<DateTime>(reviewedAt.value);
    }
    if (reviewStatus.present) {
      map['review_status'] = Variable<String>(reviewStatus.value);
    }
    if (approvalRequired.present) {
      map['approval_required'] = Variable<bool>(approvalRequired.value);
    }
    if (changeNotes.present) {
      map['change_notes'] = Variable<String>(changeNotes.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (sourceFile.present) {
      map['source_file'] = Variable<String>(sourceFile.value);
    }
    if (externalId.present) {
      map['external_id'] = Variable<String>(externalId.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (syncSource.present) {
      map['sync_source'] = Variable<String>(syncSource.value);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<DateTime>(publishedAt.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeEntriesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('summary: $summary, ')
          ..write('categoryId: $categoryId, ')
          ..write('machineProfileId: $machineProfileId, ')
          ..write('category: $category, ')
          ..write('equipmentType: $equipmentType, ')
          ..write('equipmentModel: $equipmentModel, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('applicableModels: $applicableModels, ')
          ..write('serviceType: $serviceType, ')
          ..write('difficultyLevel: $difficultyLevel, ')
          ..write('priorityLevel: $priorityLevel, ')
          ..write('safetyLevel: $safetyLevel, ')
          ..write('complianceTags: $complianceTags, ')
          ..write('estimatedTimeMinutes: $estimatedTimeMinutes, ')
          ..write('requiredTools: $requiredTools, ')
          ..write('requiredParts: $requiredParts, ')
          ..write('prerequisites: $prerequisites, ')
          ..write('specialRequirements: $specialRequirements, ')
          ..write('symptoms: $symptoms, ')
          ..write('solutionsCount: $solutionsCount, ')
          ..write('hasImages: $hasImages, ')
          ..write('hasAttachments: $hasAttachments, ')
          ..write('author: $author, ')
          ..write('authorRole: $authorRole, ')
          ..write('reviewer: $reviewer, ')
          ..write('reviewedAt: $reviewedAt, ')
          ..write('reviewStatus: $reviewStatus, ')
          ..write('approvalRequired: $approvalRequired, ')
          ..write('changeNotes: $changeNotes, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceFile: $sourceFile, ')
          ..write('externalId: $externalId, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('syncSource: $syncSource, ')
          ..write('version: $version, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KnowledgeCategoriesTable extends KnowledgeCategories
    with TableInfo<$KnowledgeCategoriesTable, KnowledgeCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KnowledgeCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
      'slug', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<int> parentId = GeneratedColumn<int>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES knowledge_categories (id)'));
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
      'active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _articleCountMeta =
      const VerificationMeta('articleCount');
  @override
  late final GeneratedColumn<int> articleCount = GeneratedColumn<int>(
      'article_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        slug,
        parentId,
        level,
        path,
        icon,
        description,
        color,
        sortOrder,
        active,
        articleCount,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'knowledge_categories';
  @override
  VerificationContext validateIntegrity(Insertable<KnowledgeCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
          _slugMeta, slug.isAcceptableOrUnknown(data['slug']!, _slugMeta));
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta,
          active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    if (data.containsKey('article_count')) {
      context.handle(
          _articleCountMeta,
          articleCount.isAcceptableOrUnknown(
              data['article_count']!, _articleCountMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KnowledgeCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KnowledgeCategory(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      slug: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}slug'])!,
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}parent_id']),
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color']),
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      active: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
      articleCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}article_count'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $KnowledgeCategoriesTable createAlias(String alias) {
    return $KnowledgeCategoriesTable(attachedDatabase, alias);
  }
}

class KnowledgeCategory extends DataClass
    implements Insertable<KnowledgeCategory> {
  final int id;
  final String name;
  final String slug;
  final int? parentId;
  final int level;
  final String path;
  final String? icon;
  final String? description;
  final String? color;
  final int sortOrder;
  final bool active;
  final int articleCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  const KnowledgeCategory(
      {required this.id,
      required this.name,
      required this.slug,
      this.parentId,
      required this.level,
      required this.path,
      this.icon,
      this.description,
      this.color,
      required this.sortOrder,
      required this.active,
      required this.articleCount,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['slug'] = Variable<String>(slug);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    map['level'] = Variable<int>(level);
    map['path'] = Variable<String>(path);
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['active'] = Variable<bool>(active);
    map['article_count'] = Variable<int>(articleCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  KnowledgeCategoriesCompanion toCompanion(bool nullToAbsent) {
    return KnowledgeCategoriesCompanion(
      id: Value(id),
      name: Value(name),
      slug: Value(slug),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      level: Value(level),
      path: Value(path),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      sortOrder: Value(sortOrder),
      active: Value(active),
      articleCount: Value(articleCount),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory KnowledgeCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KnowledgeCategory(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      slug: serializer.fromJson<String>(json['slug']),
      parentId: serializer.fromJson<int?>(json['parentId']),
      level: serializer.fromJson<int>(json['level']),
      path: serializer.fromJson<String>(json['path']),
      icon: serializer.fromJson<String?>(json['icon']),
      description: serializer.fromJson<String?>(json['description']),
      color: serializer.fromJson<String?>(json['color']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      active: serializer.fromJson<bool>(json['active']),
      articleCount: serializer.fromJson<int>(json['articleCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'slug': serializer.toJson<String>(slug),
      'parentId': serializer.toJson<int?>(parentId),
      'level': serializer.toJson<int>(level),
      'path': serializer.toJson<String>(path),
      'icon': serializer.toJson<String?>(icon),
      'description': serializer.toJson<String?>(description),
      'color': serializer.toJson<String?>(color),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'active': serializer.toJson<bool>(active),
      'articleCount': serializer.toJson<int>(articleCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  KnowledgeCategory copyWith(
          {int? id,
          String? name,
          String? slug,
          Value<int?> parentId = const Value.absent(),
          int? level,
          String? path,
          Value<String?> icon = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> color = const Value.absent(),
          int? sortOrder,
          bool? active,
          int? articleCount,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      KnowledgeCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        parentId: parentId.present ? parentId.value : this.parentId,
        level: level ?? this.level,
        path: path ?? this.path,
        icon: icon.present ? icon.value : this.icon,
        description: description.present ? description.value : this.description,
        color: color.present ? color.value : this.color,
        sortOrder: sortOrder ?? this.sortOrder,
        active: active ?? this.active,
        articleCount: articleCount ?? this.articleCount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  KnowledgeCategory copyWithCompanion(KnowledgeCategoriesCompanion data) {
    return KnowledgeCategory(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      slug: data.slug.present ? data.slug.value : this.slug,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      level: data.level.present ? data.level.value : this.level,
      path: data.path.present ? data.path.value : this.path,
      icon: data.icon.present ? data.icon.value : this.icon,
      description:
          data.description.present ? data.description.value : this.description,
      color: data.color.present ? data.color.value : this.color,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      active: data.active.present ? data.active.value : this.active,
      articleCount: data.articleCount.present
          ? data.articleCount.value
          : this.articleCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeCategory(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('parentId: $parentId, ')
          ..write('level: $level, ')
          ..write('path: $path, ')
          ..write('icon: $icon, ')
          ..write('description: $description, ')
          ..write('color: $color, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('active: $active, ')
          ..write('articleCount: $articleCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      slug,
      parentId,
      level,
      path,
      icon,
      description,
      color,
      sortOrder,
      active,
      articleCount,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KnowledgeCategory &&
          other.id == this.id &&
          other.name == this.name &&
          other.slug == this.slug &&
          other.parentId == this.parentId &&
          other.level == this.level &&
          other.path == this.path &&
          other.icon == this.icon &&
          other.description == this.description &&
          other.color == this.color &&
          other.sortOrder == this.sortOrder &&
          other.active == this.active &&
          other.articleCount == this.articleCount &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class KnowledgeCategoriesCompanion extends UpdateCompanion<KnowledgeCategory> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> slug;
  final Value<int?> parentId;
  final Value<int> level;
  final Value<String> path;
  final Value<String?> icon;
  final Value<String?> description;
  final Value<String?> color;
  final Value<int> sortOrder;
  final Value<bool> active;
  final Value<int> articleCount;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const KnowledgeCategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.slug = const Value.absent(),
    this.parentId = const Value.absent(),
    this.level = const Value.absent(),
    this.path = const Value.absent(),
    this.icon = const Value.absent(),
    this.description = const Value.absent(),
    this.color = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.active = const Value.absent(),
    this.articleCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  KnowledgeCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String slug,
    this.parentId = const Value.absent(),
    required int level,
    required String path,
    this.icon = const Value.absent(),
    this.description = const Value.absent(),
    this.color = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.active = const Value.absent(),
    this.articleCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : name = Value(name),
        slug = Value(slug),
        level = Value(level),
        path = Value(path);
  static Insertable<KnowledgeCategory> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? slug,
    Expression<int>? parentId,
    Expression<int>? level,
    Expression<String>? path,
    Expression<String>? icon,
    Expression<String>? description,
    Expression<String>? color,
    Expression<int>? sortOrder,
    Expression<bool>? active,
    Expression<int>? articleCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (slug != null) 'slug': slug,
      if (parentId != null) 'parent_id': parentId,
      if (level != null) 'level': level,
      if (path != null) 'path': path,
      if (icon != null) 'icon': icon,
      if (description != null) 'description': description,
      if (color != null) 'color': color,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (active != null) 'active': active,
      if (articleCount != null) 'article_count': articleCount,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  KnowledgeCategoriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? slug,
      Value<int?>? parentId,
      Value<int>? level,
      Value<String>? path,
      Value<String?>? icon,
      Value<String?>? description,
      Value<String?>? color,
      Value<int>? sortOrder,
      Value<bool>? active,
      Value<int>? articleCount,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return KnowledgeCategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      parentId: parentId ?? this.parentId,
      level: level ?? this.level,
      path: path ?? this.path,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      color: color ?? this.color,
      sortOrder: sortOrder ?? this.sortOrder,
      active: active ?? this.active,
      articleCount: articleCount ?? this.articleCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (articleCount.present) {
      map['article_count'] = Variable<int>(articleCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('parentId: $parentId, ')
          ..write('level: $level, ')
          ..write('path: $path, ')
          ..write('icon: $icon, ')
          ..write('description: $description, ')
          ..write('color: $color, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('active: $active, ')
          ..write('articleCount: $articleCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $KnowledgeTagsTable extends KnowledgeTags
    with TableInfo<$KnowledgeTagsTable, KnowledgeTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KnowledgeTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
      'slug', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _usageCountMeta =
      const VerificationMeta('usageCount');
  @override
  late final GeneratedColumn<int> usageCount = GeneratedColumn<int>(
      'usage_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
      'active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, slug, color, description, usageCount, active, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'knowledge_tags';
  @override
  VerificationContext validateIntegrity(Insertable<KnowledgeTag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
          _slugMeta, slug.isAcceptableOrUnknown(data['slug']!, _slugMeta));
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('usage_count')) {
      context.handle(
          _usageCountMeta,
          usageCount.isAcceptableOrUnknown(
              data['usage_count']!, _usageCountMeta));
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta,
          active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KnowledgeTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KnowledgeTag(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      slug: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}slug'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      usageCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}usage_count'])!,
      active: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $KnowledgeTagsTable createAlias(String alias) {
    return $KnowledgeTagsTable(attachedDatabase, alias);
  }
}

class KnowledgeTag extends DataClass implements Insertable<KnowledgeTag> {
  final int id;
  final String name;
  final String slug;
  final String? color;
  final String? description;
  final int usageCount;
  final bool active;
  final DateTime createdAt;
  const KnowledgeTag(
      {required this.id,
      required this.name,
      required this.slug,
      this.color,
      this.description,
      required this.usageCount,
      required this.active,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['slug'] = Variable<String>(slug);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['usage_count'] = Variable<int>(usageCount);
    map['active'] = Variable<bool>(active);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  KnowledgeTagsCompanion toCompanion(bool nullToAbsent) {
    return KnowledgeTagsCompanion(
      id: Value(id),
      name: Value(name),
      slug: Value(slug),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      usageCount: Value(usageCount),
      active: Value(active),
      createdAt: Value(createdAt),
    );
  }

  factory KnowledgeTag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KnowledgeTag(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      slug: serializer.fromJson<String>(json['slug']),
      color: serializer.fromJson<String?>(json['color']),
      description: serializer.fromJson<String?>(json['description']),
      usageCount: serializer.fromJson<int>(json['usageCount']),
      active: serializer.fromJson<bool>(json['active']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'slug': serializer.toJson<String>(slug),
      'color': serializer.toJson<String?>(color),
      'description': serializer.toJson<String?>(description),
      'usageCount': serializer.toJson<int>(usageCount),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  KnowledgeTag copyWith(
          {int? id,
          String? name,
          String? slug,
          Value<String?> color = const Value.absent(),
          Value<String?> description = const Value.absent(),
          int? usageCount,
          bool? active,
          DateTime? createdAt}) =>
      KnowledgeTag(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        color: color.present ? color.value : this.color,
        description: description.present ? description.value : this.description,
        usageCount: usageCount ?? this.usageCount,
        active: active ?? this.active,
        createdAt: createdAt ?? this.createdAt,
      );
  KnowledgeTag copyWithCompanion(KnowledgeTagsCompanion data) {
    return KnowledgeTag(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      slug: data.slug.present ? data.slug.value : this.slug,
      color: data.color.present ? data.color.value : this.color,
      description:
          data.description.present ? data.description.value : this.description,
      usageCount:
          data.usageCount.present ? data.usageCount.value : this.usageCount,
      active: data.active.present ? data.active.value : this.active,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeTag(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('color: $color, ')
          ..write('description: $description, ')
          ..write('usageCount: $usageCount, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, slug, color, description, usageCount, active, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KnowledgeTag &&
          other.id == this.id &&
          other.name == this.name &&
          other.slug == this.slug &&
          other.color == this.color &&
          other.description == this.description &&
          other.usageCount == this.usageCount &&
          other.active == this.active &&
          other.createdAt == this.createdAt);
}

class KnowledgeTagsCompanion extends UpdateCompanion<KnowledgeTag> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> slug;
  final Value<String?> color;
  final Value<String?> description;
  final Value<int> usageCount;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  const KnowledgeTagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.slug = const Value.absent(),
    this.color = const Value.absent(),
    this.description = const Value.absent(),
    this.usageCount = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  KnowledgeTagsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String slug,
    this.color = const Value.absent(),
    this.description = const Value.absent(),
    this.usageCount = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : name = Value(name),
        slug = Value(slug);
  static Insertable<KnowledgeTag> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? slug,
    Expression<String>? color,
    Expression<String>? description,
    Expression<int>? usageCount,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (slug != null) 'slug': slug,
      if (color != null) 'color': color,
      if (description != null) 'description': description,
      if (usageCount != null) 'usage_count': usageCount,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  KnowledgeTagsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? slug,
      Value<String?>? color,
      Value<String?>? description,
      Value<int>? usageCount,
      Value<bool>? active,
      Value<DateTime>? createdAt}) {
    return KnowledgeTagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      color: color ?? this.color,
      description: description ?? this.description,
      usageCount: usageCount ?? this.usageCount,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (usageCount.present) {
      map['usage_count'] = Variable<int>(usageCount.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeTagsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('color: $color, ')
          ..write('description: $description, ')
          ..write('usageCount: $usageCount, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $EntryTagsTable extends EntryTags
    with TableInfo<$EntryTagsTable, EntryTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntryTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _entryIdMeta =
      const VerificationMeta('entryId');
  @override
  late final GeneratedColumn<String> entryId = GeneratedColumn<String>(
      'entry_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES knowledge_entries (id)'));
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
      'tag_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES knowledge_tags (id)'));
  static const VerificationMeta _taggedAtMeta =
      const VerificationMeta('taggedAt');
  @override
  late final GeneratedColumn<DateTime> taggedAt = GeneratedColumn<DateTime>(
      'tagged_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [entryId, tagId, taggedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entry_tags';
  @override
  VerificationContext validateIntegrity(Insertable<EntryTag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('entry_id')) {
      context.handle(_entryIdMeta,
          entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta));
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    if (data.containsKey('tagged_at')) {
      context.handle(_taggedAtMeta,
          taggedAt.isAcceptableOrUnknown(data['tagged_at']!, _taggedAtMeta));
    } else if (isInserting) {
      context.missing(_taggedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {entryId, tagId};
  @override
  EntryTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntryTag(
      entryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entry_id'])!,
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tag_id'])!,
      taggedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}tagged_at'])!,
    );
  }

  @override
  $EntryTagsTable createAlias(String alias) {
    return $EntryTagsTable(attachedDatabase, alias);
  }
}

class EntryTag extends DataClass implements Insertable<EntryTag> {
  final String entryId;
  final int tagId;
  final DateTime taggedAt;
  const EntryTag(
      {required this.entryId, required this.tagId, required this.taggedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['entry_id'] = Variable<String>(entryId);
    map['tag_id'] = Variable<int>(tagId);
    map['tagged_at'] = Variable<DateTime>(taggedAt);
    return map;
  }

  EntryTagsCompanion toCompanion(bool nullToAbsent) {
    return EntryTagsCompanion(
      entryId: Value(entryId),
      tagId: Value(tagId),
      taggedAt: Value(taggedAt),
    );
  }

  factory EntryTag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntryTag(
      entryId: serializer.fromJson<String>(json['entryId']),
      tagId: serializer.fromJson<int>(json['tagId']),
      taggedAt: serializer.fromJson<DateTime>(json['taggedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'entryId': serializer.toJson<String>(entryId),
      'tagId': serializer.toJson<int>(tagId),
      'taggedAt': serializer.toJson<DateTime>(taggedAt),
    };
  }

  EntryTag copyWith({String? entryId, int? tagId, DateTime? taggedAt}) =>
      EntryTag(
        entryId: entryId ?? this.entryId,
        tagId: tagId ?? this.tagId,
        taggedAt: taggedAt ?? this.taggedAt,
      );
  EntryTag copyWithCompanion(EntryTagsCompanion data) {
    return EntryTag(
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
      taggedAt: data.taggedAt.present ? data.taggedAt.value : this.taggedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EntryTag(')
          ..write('entryId: $entryId, ')
          ..write('tagId: $tagId, ')
          ..write('taggedAt: $taggedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(entryId, tagId, taggedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntryTag &&
          other.entryId == this.entryId &&
          other.tagId == this.tagId &&
          other.taggedAt == this.taggedAt);
}

class EntryTagsCompanion extends UpdateCompanion<EntryTag> {
  final Value<String> entryId;
  final Value<int> tagId;
  final Value<DateTime> taggedAt;
  final Value<int> rowid;
  const EntryTagsCompanion({
    this.entryId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.taggedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntryTagsCompanion.insert({
    required String entryId,
    required int tagId,
    required DateTime taggedAt,
    this.rowid = const Value.absent(),
  })  : entryId = Value(entryId),
        tagId = Value(tagId),
        taggedAt = Value(taggedAt);
  static Insertable<EntryTag> custom({
    Expression<String>? entryId,
    Expression<int>? tagId,
    Expression<DateTime>? taggedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (entryId != null) 'entry_id': entryId,
      if (tagId != null) 'tag_id': tagId,
      if (taggedAt != null) 'tagged_at': taggedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntryTagsCompanion copyWith(
      {Value<String>? entryId,
      Value<int>? tagId,
      Value<DateTime>? taggedAt,
      Value<int>? rowid}) {
    return EntryTagsCompanion(
      entryId: entryId ?? this.entryId,
      tagId: tagId ?? this.tagId,
      taggedAt: taggedAt ?? this.taggedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (entryId.present) {
      map['entry_id'] = Variable<String>(entryId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (taggedAt.present) {
      map['tagged_at'] = Variable<DateTime>(taggedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntryTagsCompanion(')
          ..write('entryId: $entryId, ')
          ..write('tagId: $tagId, ')
          ..write('taggedAt: $taggedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EntryMetadataTable extends EntryMetadata
    with TableInfo<$EntryMetadataTable, EntryMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntryMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _entryIdMeta =
      const VerificationMeta('entryId');
  @override
  late final GeneratedColumn<String> entryId = GeneratedColumn<String>(
      'entry_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES knowledge_entries (id)'));
  static const VerificationMeta _viewCountMeta =
      const VerificationMeta('viewCount');
  @override
  late final GeneratedColumn<int> viewCount = GeneratedColumn<int>(
      'view_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _helpfulCountMeta =
      const VerificationMeta('helpfulCount');
  @override
  late final GeneratedColumn<int> helpfulCount = GeneratedColumn<int>(
      'helpful_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _notHelpfulCountMeta =
      const VerificationMeta('notHelpfulCount');
  @override
  late final GeneratedColumn<int> notHelpfulCount = GeneratedColumn<int>(
      'not_helpful_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _averageTimeSecondsMeta =
      const VerificationMeta('averageTimeSeconds');
  @override
  late final GeneratedColumn<int> averageTimeSeconds = GeneratedColumn<int>(
      'average_time_seconds', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _lastViewedAtMeta =
      const VerificationMeta('lastViewedAt');
  @override
  late final GeneratedColumn<DateTime> lastViewedAt = GeneratedColumn<DateTime>(
      'last_viewed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _searchTermsFoundMeta =
      const VerificationMeta('searchTermsFound');
  @override
  late final GeneratedColumn<String> searchTermsFound = GeneratedColumn<String>(
      'search_terms_found', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _searchResultClicksMeta =
      const VerificationMeta('searchResultClicks');
  @override
  late final GeneratedColumn<int> searchResultClicks = GeneratedColumn<int>(
      'search_result_clicks', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _completenessScoreMeta =
      const VerificationMeta('completenessScore');
  @override
  late final GeneratedColumn<double> completenessScore =
      GeneratedColumn<double>('completeness_score', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _needsReviewMeta =
      const VerificationMeta('needsReview');
  @override
  late final GeneratedColumn<bool> needsReview = GeneratedColumn<bool>(
      'needs_review', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("needs_review" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _nextReviewDueMeta =
      const VerificationMeta('nextReviewDue');
  @override
  late final GeneratedColumn<DateTime> nextReviewDue =
      GeneratedColumn<DateTime>('next_review_due', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _uniqueViewersMeta =
      const VerificationMeta('uniqueViewers');
  @override
  late final GeneratedColumn<int> uniqueViewers = GeneratedColumn<int>(
      'unique_viewers', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _returnVisitorsMeta =
      const VerificationMeta('returnVisitors');
  @override
  late final GeneratedColumn<int> returnVisitors = GeneratedColumn<int>(
      'return_visitors', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        entryId,
        viewCount,
        helpfulCount,
        notHelpfulCount,
        averageTimeSeconds,
        lastViewedAt,
        searchTermsFound,
        searchResultClicks,
        completenessScore,
        needsReview,
        nextReviewDue,
        uniqueViewers,
        returnVisitors
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entry_metadata';
  @override
  VerificationContext validateIntegrity(Insertable<EntryMetadataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('entry_id')) {
      context.handle(_entryIdMeta,
          entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta));
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('view_count')) {
      context.handle(_viewCountMeta,
          viewCount.isAcceptableOrUnknown(data['view_count']!, _viewCountMeta));
    }
    if (data.containsKey('helpful_count')) {
      context.handle(
          _helpfulCountMeta,
          helpfulCount.isAcceptableOrUnknown(
              data['helpful_count']!, _helpfulCountMeta));
    }
    if (data.containsKey('not_helpful_count')) {
      context.handle(
          _notHelpfulCountMeta,
          notHelpfulCount.isAcceptableOrUnknown(
              data['not_helpful_count']!, _notHelpfulCountMeta));
    }
    if (data.containsKey('average_time_seconds')) {
      context.handle(
          _averageTimeSecondsMeta,
          averageTimeSeconds.isAcceptableOrUnknown(
              data['average_time_seconds']!, _averageTimeSecondsMeta));
    }
    if (data.containsKey('last_viewed_at')) {
      context.handle(
          _lastViewedAtMeta,
          lastViewedAt.isAcceptableOrUnknown(
              data['last_viewed_at']!, _lastViewedAtMeta));
    }
    if (data.containsKey('search_terms_found')) {
      context.handle(
          _searchTermsFoundMeta,
          searchTermsFound.isAcceptableOrUnknown(
              data['search_terms_found']!, _searchTermsFoundMeta));
    }
    if (data.containsKey('search_result_clicks')) {
      context.handle(
          _searchResultClicksMeta,
          searchResultClicks.isAcceptableOrUnknown(
              data['search_result_clicks']!, _searchResultClicksMeta));
    }
    if (data.containsKey('completeness_score')) {
      context.handle(
          _completenessScoreMeta,
          completenessScore.isAcceptableOrUnknown(
              data['completeness_score']!, _completenessScoreMeta));
    }
    if (data.containsKey('needs_review')) {
      context.handle(
          _needsReviewMeta,
          needsReview.isAcceptableOrUnknown(
              data['needs_review']!, _needsReviewMeta));
    }
    if (data.containsKey('next_review_due')) {
      context.handle(
          _nextReviewDueMeta,
          nextReviewDue.isAcceptableOrUnknown(
              data['next_review_due']!, _nextReviewDueMeta));
    }
    if (data.containsKey('unique_viewers')) {
      context.handle(
          _uniqueViewersMeta,
          uniqueViewers.isAcceptableOrUnknown(
              data['unique_viewers']!, _uniqueViewersMeta));
    }
    if (data.containsKey('return_visitors')) {
      context.handle(
          _returnVisitorsMeta,
          returnVisitors.isAcceptableOrUnknown(
              data['return_visitors']!, _returnVisitorsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {entryId};
  @override
  EntryMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntryMetadataData(
      entryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entry_id'])!,
      viewCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}view_count'])!,
      helpfulCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}helpful_count'])!,
      notHelpfulCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}not_helpful_count'])!,
      averageTimeSeconds: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}average_time_seconds']),
      lastViewedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_viewed_at']),
      searchTermsFound: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}search_terms_found'])!,
      searchResultClicks: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}search_result_clicks'])!,
      completenessScore: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}completeness_score']),
      needsReview: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}needs_review'])!,
      nextReviewDue: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}next_review_due']),
      uniqueViewers: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unique_viewers'])!,
      returnVisitors: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}return_visitors'])!,
    );
  }

  @override
  $EntryMetadataTable createAlias(String alias) {
    return $EntryMetadataTable(attachedDatabase, alias);
  }
}

class EntryMetadataData extends DataClass
    implements Insertable<EntryMetadataData> {
  final String entryId;
  final int viewCount;
  final int helpfulCount;
  final int notHelpfulCount;
  final int? averageTimeSeconds;
  final DateTime? lastViewedAt;
  final String searchTermsFound;
  final int searchResultClicks;
  final double? completenessScore;
  final bool needsReview;
  final DateTime? nextReviewDue;
  final int uniqueViewers;
  final int returnVisitors;
  const EntryMetadataData(
      {required this.entryId,
      required this.viewCount,
      required this.helpfulCount,
      required this.notHelpfulCount,
      this.averageTimeSeconds,
      this.lastViewedAt,
      required this.searchTermsFound,
      required this.searchResultClicks,
      this.completenessScore,
      required this.needsReview,
      this.nextReviewDue,
      required this.uniqueViewers,
      required this.returnVisitors});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['entry_id'] = Variable<String>(entryId);
    map['view_count'] = Variable<int>(viewCount);
    map['helpful_count'] = Variable<int>(helpfulCount);
    map['not_helpful_count'] = Variable<int>(notHelpfulCount);
    if (!nullToAbsent || averageTimeSeconds != null) {
      map['average_time_seconds'] = Variable<int>(averageTimeSeconds);
    }
    if (!nullToAbsent || lastViewedAt != null) {
      map['last_viewed_at'] = Variable<DateTime>(lastViewedAt);
    }
    map['search_terms_found'] = Variable<String>(searchTermsFound);
    map['search_result_clicks'] = Variable<int>(searchResultClicks);
    if (!nullToAbsent || completenessScore != null) {
      map['completeness_score'] = Variable<double>(completenessScore);
    }
    map['needs_review'] = Variable<bool>(needsReview);
    if (!nullToAbsent || nextReviewDue != null) {
      map['next_review_due'] = Variable<DateTime>(nextReviewDue);
    }
    map['unique_viewers'] = Variable<int>(uniqueViewers);
    map['return_visitors'] = Variable<int>(returnVisitors);
    return map;
  }

  EntryMetadataCompanion toCompanion(bool nullToAbsent) {
    return EntryMetadataCompanion(
      entryId: Value(entryId),
      viewCount: Value(viewCount),
      helpfulCount: Value(helpfulCount),
      notHelpfulCount: Value(notHelpfulCount),
      averageTimeSeconds: averageTimeSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(averageTimeSeconds),
      lastViewedAt: lastViewedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastViewedAt),
      searchTermsFound: Value(searchTermsFound),
      searchResultClicks: Value(searchResultClicks),
      completenessScore: completenessScore == null && nullToAbsent
          ? const Value.absent()
          : Value(completenessScore),
      needsReview: Value(needsReview),
      nextReviewDue: nextReviewDue == null && nullToAbsent
          ? const Value.absent()
          : Value(nextReviewDue),
      uniqueViewers: Value(uniqueViewers),
      returnVisitors: Value(returnVisitors),
    );
  }

  factory EntryMetadataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntryMetadataData(
      entryId: serializer.fromJson<String>(json['entryId']),
      viewCount: serializer.fromJson<int>(json['viewCount']),
      helpfulCount: serializer.fromJson<int>(json['helpfulCount']),
      notHelpfulCount: serializer.fromJson<int>(json['notHelpfulCount']),
      averageTimeSeconds: serializer.fromJson<int?>(json['averageTimeSeconds']),
      lastViewedAt: serializer.fromJson<DateTime?>(json['lastViewedAt']),
      searchTermsFound: serializer.fromJson<String>(json['searchTermsFound']),
      searchResultClicks: serializer.fromJson<int>(json['searchResultClicks']),
      completenessScore:
          serializer.fromJson<double?>(json['completenessScore']),
      needsReview: serializer.fromJson<bool>(json['needsReview']),
      nextReviewDue: serializer.fromJson<DateTime?>(json['nextReviewDue']),
      uniqueViewers: serializer.fromJson<int>(json['uniqueViewers']),
      returnVisitors: serializer.fromJson<int>(json['returnVisitors']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'entryId': serializer.toJson<String>(entryId),
      'viewCount': serializer.toJson<int>(viewCount),
      'helpfulCount': serializer.toJson<int>(helpfulCount),
      'notHelpfulCount': serializer.toJson<int>(notHelpfulCount),
      'averageTimeSeconds': serializer.toJson<int?>(averageTimeSeconds),
      'lastViewedAt': serializer.toJson<DateTime?>(lastViewedAt),
      'searchTermsFound': serializer.toJson<String>(searchTermsFound),
      'searchResultClicks': serializer.toJson<int>(searchResultClicks),
      'completenessScore': serializer.toJson<double?>(completenessScore),
      'needsReview': serializer.toJson<bool>(needsReview),
      'nextReviewDue': serializer.toJson<DateTime?>(nextReviewDue),
      'uniqueViewers': serializer.toJson<int>(uniqueViewers),
      'returnVisitors': serializer.toJson<int>(returnVisitors),
    };
  }

  EntryMetadataData copyWith(
          {String? entryId,
          int? viewCount,
          int? helpfulCount,
          int? notHelpfulCount,
          Value<int?> averageTimeSeconds = const Value.absent(),
          Value<DateTime?> lastViewedAt = const Value.absent(),
          String? searchTermsFound,
          int? searchResultClicks,
          Value<double?> completenessScore = const Value.absent(),
          bool? needsReview,
          Value<DateTime?> nextReviewDue = const Value.absent(),
          int? uniqueViewers,
          int? returnVisitors}) =>
      EntryMetadataData(
        entryId: entryId ?? this.entryId,
        viewCount: viewCount ?? this.viewCount,
        helpfulCount: helpfulCount ?? this.helpfulCount,
        notHelpfulCount: notHelpfulCount ?? this.notHelpfulCount,
        averageTimeSeconds: averageTimeSeconds.present
            ? averageTimeSeconds.value
            : this.averageTimeSeconds,
        lastViewedAt:
            lastViewedAt.present ? lastViewedAt.value : this.lastViewedAt,
        searchTermsFound: searchTermsFound ?? this.searchTermsFound,
        searchResultClicks: searchResultClicks ?? this.searchResultClicks,
        completenessScore: completenessScore.present
            ? completenessScore.value
            : this.completenessScore,
        needsReview: needsReview ?? this.needsReview,
        nextReviewDue:
            nextReviewDue.present ? nextReviewDue.value : this.nextReviewDue,
        uniqueViewers: uniqueViewers ?? this.uniqueViewers,
        returnVisitors: returnVisitors ?? this.returnVisitors,
      );
  EntryMetadataData copyWithCompanion(EntryMetadataCompanion data) {
    return EntryMetadataData(
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      viewCount: data.viewCount.present ? data.viewCount.value : this.viewCount,
      helpfulCount: data.helpfulCount.present
          ? data.helpfulCount.value
          : this.helpfulCount,
      notHelpfulCount: data.notHelpfulCount.present
          ? data.notHelpfulCount.value
          : this.notHelpfulCount,
      averageTimeSeconds: data.averageTimeSeconds.present
          ? data.averageTimeSeconds.value
          : this.averageTimeSeconds,
      lastViewedAt: data.lastViewedAt.present
          ? data.lastViewedAt.value
          : this.lastViewedAt,
      searchTermsFound: data.searchTermsFound.present
          ? data.searchTermsFound.value
          : this.searchTermsFound,
      searchResultClicks: data.searchResultClicks.present
          ? data.searchResultClicks.value
          : this.searchResultClicks,
      completenessScore: data.completenessScore.present
          ? data.completenessScore.value
          : this.completenessScore,
      needsReview:
          data.needsReview.present ? data.needsReview.value : this.needsReview,
      nextReviewDue: data.nextReviewDue.present
          ? data.nextReviewDue.value
          : this.nextReviewDue,
      uniqueViewers: data.uniqueViewers.present
          ? data.uniqueViewers.value
          : this.uniqueViewers,
      returnVisitors: data.returnVisitors.present
          ? data.returnVisitors.value
          : this.returnVisitors,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EntryMetadataData(')
          ..write('entryId: $entryId, ')
          ..write('viewCount: $viewCount, ')
          ..write('helpfulCount: $helpfulCount, ')
          ..write('notHelpfulCount: $notHelpfulCount, ')
          ..write('averageTimeSeconds: $averageTimeSeconds, ')
          ..write('lastViewedAt: $lastViewedAt, ')
          ..write('searchTermsFound: $searchTermsFound, ')
          ..write('searchResultClicks: $searchResultClicks, ')
          ..write('completenessScore: $completenessScore, ')
          ..write('needsReview: $needsReview, ')
          ..write('nextReviewDue: $nextReviewDue, ')
          ..write('uniqueViewers: $uniqueViewers, ')
          ..write('returnVisitors: $returnVisitors')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      entryId,
      viewCount,
      helpfulCount,
      notHelpfulCount,
      averageTimeSeconds,
      lastViewedAt,
      searchTermsFound,
      searchResultClicks,
      completenessScore,
      needsReview,
      nextReviewDue,
      uniqueViewers,
      returnVisitors);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntryMetadataData &&
          other.entryId == this.entryId &&
          other.viewCount == this.viewCount &&
          other.helpfulCount == this.helpfulCount &&
          other.notHelpfulCount == this.notHelpfulCount &&
          other.averageTimeSeconds == this.averageTimeSeconds &&
          other.lastViewedAt == this.lastViewedAt &&
          other.searchTermsFound == this.searchTermsFound &&
          other.searchResultClicks == this.searchResultClicks &&
          other.completenessScore == this.completenessScore &&
          other.needsReview == this.needsReview &&
          other.nextReviewDue == this.nextReviewDue &&
          other.uniqueViewers == this.uniqueViewers &&
          other.returnVisitors == this.returnVisitors);
}

class EntryMetadataCompanion extends UpdateCompanion<EntryMetadataData> {
  final Value<String> entryId;
  final Value<int> viewCount;
  final Value<int> helpfulCount;
  final Value<int> notHelpfulCount;
  final Value<int?> averageTimeSeconds;
  final Value<DateTime?> lastViewedAt;
  final Value<String> searchTermsFound;
  final Value<int> searchResultClicks;
  final Value<double?> completenessScore;
  final Value<bool> needsReview;
  final Value<DateTime?> nextReviewDue;
  final Value<int> uniqueViewers;
  final Value<int> returnVisitors;
  final Value<int> rowid;
  const EntryMetadataCompanion({
    this.entryId = const Value.absent(),
    this.viewCount = const Value.absent(),
    this.helpfulCount = const Value.absent(),
    this.notHelpfulCount = const Value.absent(),
    this.averageTimeSeconds = const Value.absent(),
    this.lastViewedAt = const Value.absent(),
    this.searchTermsFound = const Value.absent(),
    this.searchResultClicks = const Value.absent(),
    this.completenessScore = const Value.absent(),
    this.needsReview = const Value.absent(),
    this.nextReviewDue = const Value.absent(),
    this.uniqueViewers = const Value.absent(),
    this.returnVisitors = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntryMetadataCompanion.insert({
    required String entryId,
    this.viewCount = const Value.absent(),
    this.helpfulCount = const Value.absent(),
    this.notHelpfulCount = const Value.absent(),
    this.averageTimeSeconds = const Value.absent(),
    this.lastViewedAt = const Value.absent(),
    this.searchTermsFound = const Value.absent(),
    this.searchResultClicks = const Value.absent(),
    this.completenessScore = const Value.absent(),
    this.needsReview = const Value.absent(),
    this.nextReviewDue = const Value.absent(),
    this.uniqueViewers = const Value.absent(),
    this.returnVisitors = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : entryId = Value(entryId);
  static Insertable<EntryMetadataData> custom({
    Expression<String>? entryId,
    Expression<int>? viewCount,
    Expression<int>? helpfulCount,
    Expression<int>? notHelpfulCount,
    Expression<int>? averageTimeSeconds,
    Expression<DateTime>? lastViewedAt,
    Expression<String>? searchTermsFound,
    Expression<int>? searchResultClicks,
    Expression<double>? completenessScore,
    Expression<bool>? needsReview,
    Expression<DateTime>? nextReviewDue,
    Expression<int>? uniqueViewers,
    Expression<int>? returnVisitors,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (entryId != null) 'entry_id': entryId,
      if (viewCount != null) 'view_count': viewCount,
      if (helpfulCount != null) 'helpful_count': helpfulCount,
      if (notHelpfulCount != null) 'not_helpful_count': notHelpfulCount,
      if (averageTimeSeconds != null)
        'average_time_seconds': averageTimeSeconds,
      if (lastViewedAt != null) 'last_viewed_at': lastViewedAt,
      if (searchTermsFound != null) 'search_terms_found': searchTermsFound,
      if (searchResultClicks != null)
        'search_result_clicks': searchResultClicks,
      if (completenessScore != null) 'completeness_score': completenessScore,
      if (needsReview != null) 'needs_review': needsReview,
      if (nextReviewDue != null) 'next_review_due': nextReviewDue,
      if (uniqueViewers != null) 'unique_viewers': uniqueViewers,
      if (returnVisitors != null) 'return_visitors': returnVisitors,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntryMetadataCompanion copyWith(
      {Value<String>? entryId,
      Value<int>? viewCount,
      Value<int>? helpfulCount,
      Value<int>? notHelpfulCount,
      Value<int?>? averageTimeSeconds,
      Value<DateTime?>? lastViewedAt,
      Value<String>? searchTermsFound,
      Value<int>? searchResultClicks,
      Value<double?>? completenessScore,
      Value<bool>? needsReview,
      Value<DateTime?>? nextReviewDue,
      Value<int>? uniqueViewers,
      Value<int>? returnVisitors,
      Value<int>? rowid}) {
    return EntryMetadataCompanion(
      entryId: entryId ?? this.entryId,
      viewCount: viewCount ?? this.viewCount,
      helpfulCount: helpfulCount ?? this.helpfulCount,
      notHelpfulCount: notHelpfulCount ?? this.notHelpfulCount,
      averageTimeSeconds: averageTimeSeconds ?? this.averageTimeSeconds,
      lastViewedAt: lastViewedAt ?? this.lastViewedAt,
      searchTermsFound: searchTermsFound ?? this.searchTermsFound,
      searchResultClicks: searchResultClicks ?? this.searchResultClicks,
      completenessScore: completenessScore ?? this.completenessScore,
      needsReview: needsReview ?? this.needsReview,
      nextReviewDue: nextReviewDue ?? this.nextReviewDue,
      uniqueViewers: uniqueViewers ?? this.uniqueViewers,
      returnVisitors: returnVisitors ?? this.returnVisitors,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (entryId.present) {
      map['entry_id'] = Variable<String>(entryId.value);
    }
    if (viewCount.present) {
      map['view_count'] = Variable<int>(viewCount.value);
    }
    if (helpfulCount.present) {
      map['helpful_count'] = Variable<int>(helpfulCount.value);
    }
    if (notHelpfulCount.present) {
      map['not_helpful_count'] = Variable<int>(notHelpfulCount.value);
    }
    if (averageTimeSeconds.present) {
      map['average_time_seconds'] = Variable<int>(averageTimeSeconds.value);
    }
    if (lastViewedAt.present) {
      map['last_viewed_at'] = Variable<DateTime>(lastViewedAt.value);
    }
    if (searchTermsFound.present) {
      map['search_terms_found'] = Variable<String>(searchTermsFound.value);
    }
    if (searchResultClicks.present) {
      map['search_result_clicks'] = Variable<int>(searchResultClicks.value);
    }
    if (completenessScore.present) {
      map['completeness_score'] = Variable<double>(completenessScore.value);
    }
    if (needsReview.present) {
      map['needs_review'] = Variable<bool>(needsReview.value);
    }
    if (nextReviewDue.present) {
      map['next_review_due'] = Variable<DateTime>(nextReviewDue.value);
    }
    if (uniqueViewers.present) {
      map['unique_viewers'] = Variable<int>(uniqueViewers.value);
    }
    if (returnVisitors.present) {
      map['return_visitors'] = Variable<int>(returnVisitors.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntryMetadataCompanion(')
          ..write('entryId: $entryId, ')
          ..write('viewCount: $viewCount, ')
          ..write('helpfulCount: $helpfulCount, ')
          ..write('notHelpfulCount: $notHelpfulCount, ')
          ..write('averageTimeSeconds: $averageTimeSeconds, ')
          ..write('lastViewedAt: $lastViewedAt, ')
          ..write('searchTermsFound: $searchTermsFound, ')
          ..write('searchResultClicks: $searchResultClicks, ')
          ..write('completenessScore: $completenessScore, ')
          ..write('needsReview: $needsReview, ')
          ..write('nextReviewDue: $nextReviewDue, ')
          ..write('uniqueViewers: $uniqueViewers, ')
          ..write('returnVisitors: $returnVisitors, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KnowledgeAttachmentsTable extends KnowledgeAttachments
    with TableInfo<$KnowledgeAttachmentsTable, KnowledgeAttachment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KnowledgeAttachmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _entryIdMeta =
      const VerificationMeta('entryId');
  @override
  late final GeneratedColumn<String> entryId = GeneratedColumn<String>(
      'entry_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES knowledge_entries (id)'));
  static const VerificationMeta _fileNameMeta =
      const VerificationMeta('fileName');
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
      'file_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _filePathMeta =
      const VerificationMeta('filePath');
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
      'file_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fileTypeMeta =
      const VerificationMeta('fileType');
  @override
  late final GeneratedColumn<String> fileType = GeneratedColumn<String>(
      'file_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fileSizeBytesMeta =
      const VerificationMeta('fileSizeBytes');
  @override
  late final GeneratedColumn<int> fileSizeBytes = GeneratedColumn<int>(
      'file_size_bytes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _fileHashMeta =
      const VerificationMeta('fileHash');
  @override
  late final GeneratedColumn<String> fileHash = GeneratedColumn<String>(
      'file_hash', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _altTextMeta =
      const VerificationMeta('altText');
  @override
  late final GeneratedColumn<String> altText = GeneratedColumn<String>(
      'alt_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _captionMeta =
      const VerificationMeta('caption');
  @override
  late final GeneratedColumn<String> caption = GeneratedColumn<String>(
      'caption', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _displayOrderMeta =
      const VerificationMeta('displayOrder');
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
      'display_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _attachmentTypeMeta =
      const VerificationMeta('attachmentType');
  @override
  late final GeneratedColumn<String> attachmentType = GeneratedColumn<String>(
      'attachment_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isInlineMeta =
      const VerificationMeta('isInline');
  @override
  late final GeneratedColumn<bool> isInline = GeneratedColumn<bool>(
      'is_inline', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_inline" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _uploadedAtMeta =
      const VerificationMeta('uploadedAt');
  @override
  late final GeneratedColumn<DateTime> uploadedAt = GeneratedColumn<DateTime>(
      'uploaded_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _uploadedByMeta =
      const VerificationMeta('uploadedBy');
  @override
  late final GeneratedColumn<String> uploadedBy = GeneratedColumn<String>(
      'uploaded_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        entryId,
        fileName,
        filePath,
        fileType,
        fileSizeBytes,
        fileHash,
        altText,
        caption,
        displayOrder,
        attachmentType,
        isInline,
        uploadedAt,
        uploadedBy
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'knowledge_attachments';
  @override
  VerificationContext validateIntegrity(
      Insertable<KnowledgeAttachment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entry_id')) {
      context.handle(_entryIdMeta,
          entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta));
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(_fileNameMeta,
          fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta));
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(_filePathMeta,
          filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta));
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('file_type')) {
      context.handle(_fileTypeMeta,
          fileType.isAcceptableOrUnknown(data['file_type']!, _fileTypeMeta));
    } else if (isInserting) {
      context.missing(_fileTypeMeta);
    }
    if (data.containsKey('file_size_bytes')) {
      context.handle(
          _fileSizeBytesMeta,
          fileSizeBytes.isAcceptableOrUnknown(
              data['file_size_bytes']!, _fileSizeBytesMeta));
    } else if (isInserting) {
      context.missing(_fileSizeBytesMeta);
    }
    if (data.containsKey('file_hash')) {
      context.handle(_fileHashMeta,
          fileHash.isAcceptableOrUnknown(data['file_hash']!, _fileHashMeta));
    }
    if (data.containsKey('alt_text')) {
      context.handle(_altTextMeta,
          altText.isAcceptableOrUnknown(data['alt_text']!, _altTextMeta));
    }
    if (data.containsKey('caption')) {
      context.handle(_captionMeta,
          caption.isAcceptableOrUnknown(data['caption']!, _captionMeta));
    }
    if (data.containsKey('display_order')) {
      context.handle(
          _displayOrderMeta,
          displayOrder.isAcceptableOrUnknown(
              data['display_order']!, _displayOrderMeta));
    }
    if (data.containsKey('attachment_type')) {
      context.handle(
          _attachmentTypeMeta,
          attachmentType.isAcceptableOrUnknown(
              data['attachment_type']!, _attachmentTypeMeta));
    } else if (isInserting) {
      context.missing(_attachmentTypeMeta);
    }
    if (data.containsKey('is_inline')) {
      context.handle(_isInlineMeta,
          isInline.isAcceptableOrUnknown(data['is_inline']!, _isInlineMeta));
    }
    if (data.containsKey('uploaded_at')) {
      context.handle(
          _uploadedAtMeta,
          uploadedAt.isAcceptableOrUnknown(
              data['uploaded_at']!, _uploadedAtMeta));
    } else if (isInserting) {
      context.missing(_uploadedAtMeta);
    }
    if (data.containsKey('uploaded_by')) {
      context.handle(
          _uploadedByMeta,
          uploadedBy.isAcceptableOrUnknown(
              data['uploaded_by']!, _uploadedByMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KnowledgeAttachment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KnowledgeAttachment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      entryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entry_id'])!,
      fileName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_name'])!,
      filePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_path'])!,
      fileType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_type'])!,
      fileSizeBytes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}file_size_bytes'])!,
      fileHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_hash']),
      altText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}alt_text']),
      caption: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}caption']),
      displayOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}display_order'])!,
      attachmentType: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}attachment_type'])!,
      isInline: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_inline'])!,
      uploadedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}uploaded_at'])!,
      uploadedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uploaded_by']),
    );
  }

  @override
  $KnowledgeAttachmentsTable createAlias(String alias) {
    return $KnowledgeAttachmentsTable(attachedDatabase, alias);
  }
}

class KnowledgeAttachment extends DataClass
    implements Insertable<KnowledgeAttachment> {
  final int id;
  final String entryId;
  final String fileName;
  final String filePath;
  final String fileType;
  final int fileSizeBytes;
  final String? fileHash;
  final String? altText;
  final String? caption;
  final int displayOrder;
  final String attachmentType;
  final bool isInline;
  final DateTime uploadedAt;
  final String? uploadedBy;
  const KnowledgeAttachment(
      {required this.id,
      required this.entryId,
      required this.fileName,
      required this.filePath,
      required this.fileType,
      required this.fileSizeBytes,
      this.fileHash,
      this.altText,
      this.caption,
      required this.displayOrder,
      required this.attachmentType,
      required this.isInline,
      required this.uploadedAt,
      this.uploadedBy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entry_id'] = Variable<String>(entryId);
    map['file_name'] = Variable<String>(fileName);
    map['file_path'] = Variable<String>(filePath);
    map['file_type'] = Variable<String>(fileType);
    map['file_size_bytes'] = Variable<int>(fileSizeBytes);
    if (!nullToAbsent || fileHash != null) {
      map['file_hash'] = Variable<String>(fileHash);
    }
    if (!nullToAbsent || altText != null) {
      map['alt_text'] = Variable<String>(altText);
    }
    if (!nullToAbsent || caption != null) {
      map['caption'] = Variable<String>(caption);
    }
    map['display_order'] = Variable<int>(displayOrder);
    map['attachment_type'] = Variable<String>(attachmentType);
    map['is_inline'] = Variable<bool>(isInline);
    map['uploaded_at'] = Variable<DateTime>(uploadedAt);
    if (!nullToAbsent || uploadedBy != null) {
      map['uploaded_by'] = Variable<String>(uploadedBy);
    }
    return map;
  }

  KnowledgeAttachmentsCompanion toCompanion(bool nullToAbsent) {
    return KnowledgeAttachmentsCompanion(
      id: Value(id),
      entryId: Value(entryId),
      fileName: Value(fileName),
      filePath: Value(filePath),
      fileType: Value(fileType),
      fileSizeBytes: Value(fileSizeBytes),
      fileHash: fileHash == null && nullToAbsent
          ? const Value.absent()
          : Value(fileHash),
      altText: altText == null && nullToAbsent
          ? const Value.absent()
          : Value(altText),
      caption: caption == null && nullToAbsent
          ? const Value.absent()
          : Value(caption),
      displayOrder: Value(displayOrder),
      attachmentType: Value(attachmentType),
      isInline: Value(isInline),
      uploadedAt: Value(uploadedAt),
      uploadedBy: uploadedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(uploadedBy),
    );
  }

  factory KnowledgeAttachment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KnowledgeAttachment(
      id: serializer.fromJson<int>(json['id']),
      entryId: serializer.fromJson<String>(json['entryId']),
      fileName: serializer.fromJson<String>(json['fileName']),
      filePath: serializer.fromJson<String>(json['filePath']),
      fileType: serializer.fromJson<String>(json['fileType']),
      fileSizeBytes: serializer.fromJson<int>(json['fileSizeBytes']),
      fileHash: serializer.fromJson<String?>(json['fileHash']),
      altText: serializer.fromJson<String?>(json['altText']),
      caption: serializer.fromJson<String?>(json['caption']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
      attachmentType: serializer.fromJson<String>(json['attachmentType']),
      isInline: serializer.fromJson<bool>(json['isInline']),
      uploadedAt: serializer.fromJson<DateTime>(json['uploadedAt']),
      uploadedBy: serializer.fromJson<String?>(json['uploadedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entryId': serializer.toJson<String>(entryId),
      'fileName': serializer.toJson<String>(fileName),
      'filePath': serializer.toJson<String>(filePath),
      'fileType': serializer.toJson<String>(fileType),
      'fileSizeBytes': serializer.toJson<int>(fileSizeBytes),
      'fileHash': serializer.toJson<String?>(fileHash),
      'altText': serializer.toJson<String?>(altText),
      'caption': serializer.toJson<String?>(caption),
      'displayOrder': serializer.toJson<int>(displayOrder),
      'attachmentType': serializer.toJson<String>(attachmentType),
      'isInline': serializer.toJson<bool>(isInline),
      'uploadedAt': serializer.toJson<DateTime>(uploadedAt),
      'uploadedBy': serializer.toJson<String?>(uploadedBy),
    };
  }

  KnowledgeAttachment copyWith(
          {int? id,
          String? entryId,
          String? fileName,
          String? filePath,
          String? fileType,
          int? fileSizeBytes,
          Value<String?> fileHash = const Value.absent(),
          Value<String?> altText = const Value.absent(),
          Value<String?> caption = const Value.absent(),
          int? displayOrder,
          String? attachmentType,
          bool? isInline,
          DateTime? uploadedAt,
          Value<String?> uploadedBy = const Value.absent()}) =>
      KnowledgeAttachment(
        id: id ?? this.id,
        entryId: entryId ?? this.entryId,
        fileName: fileName ?? this.fileName,
        filePath: filePath ?? this.filePath,
        fileType: fileType ?? this.fileType,
        fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
        fileHash: fileHash.present ? fileHash.value : this.fileHash,
        altText: altText.present ? altText.value : this.altText,
        caption: caption.present ? caption.value : this.caption,
        displayOrder: displayOrder ?? this.displayOrder,
        attachmentType: attachmentType ?? this.attachmentType,
        isInline: isInline ?? this.isInline,
        uploadedAt: uploadedAt ?? this.uploadedAt,
        uploadedBy: uploadedBy.present ? uploadedBy.value : this.uploadedBy,
      );
  KnowledgeAttachment copyWithCompanion(KnowledgeAttachmentsCompanion data) {
    return KnowledgeAttachment(
      id: data.id.present ? data.id.value : this.id,
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      fileType: data.fileType.present ? data.fileType.value : this.fileType,
      fileSizeBytes: data.fileSizeBytes.present
          ? data.fileSizeBytes.value
          : this.fileSizeBytes,
      fileHash: data.fileHash.present ? data.fileHash.value : this.fileHash,
      altText: data.altText.present ? data.altText.value : this.altText,
      caption: data.caption.present ? data.caption.value : this.caption,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
      attachmentType: data.attachmentType.present
          ? data.attachmentType.value
          : this.attachmentType,
      isInline: data.isInline.present ? data.isInline.value : this.isInline,
      uploadedAt:
          data.uploadedAt.present ? data.uploadedAt.value : this.uploadedAt,
      uploadedBy:
          data.uploadedBy.present ? data.uploadedBy.value : this.uploadedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeAttachment(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('fileName: $fileName, ')
          ..write('filePath: $filePath, ')
          ..write('fileType: $fileType, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('fileHash: $fileHash, ')
          ..write('altText: $altText, ')
          ..write('caption: $caption, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('attachmentType: $attachmentType, ')
          ..write('isInline: $isInline, ')
          ..write('uploadedAt: $uploadedAt, ')
          ..write('uploadedBy: $uploadedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      entryId,
      fileName,
      filePath,
      fileType,
      fileSizeBytes,
      fileHash,
      altText,
      caption,
      displayOrder,
      attachmentType,
      isInline,
      uploadedAt,
      uploadedBy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KnowledgeAttachment &&
          other.id == this.id &&
          other.entryId == this.entryId &&
          other.fileName == this.fileName &&
          other.filePath == this.filePath &&
          other.fileType == this.fileType &&
          other.fileSizeBytes == this.fileSizeBytes &&
          other.fileHash == this.fileHash &&
          other.altText == this.altText &&
          other.caption == this.caption &&
          other.displayOrder == this.displayOrder &&
          other.attachmentType == this.attachmentType &&
          other.isInline == this.isInline &&
          other.uploadedAt == this.uploadedAt &&
          other.uploadedBy == this.uploadedBy);
}

class KnowledgeAttachmentsCompanion
    extends UpdateCompanion<KnowledgeAttachment> {
  final Value<int> id;
  final Value<String> entryId;
  final Value<String> fileName;
  final Value<String> filePath;
  final Value<String> fileType;
  final Value<int> fileSizeBytes;
  final Value<String?> fileHash;
  final Value<String?> altText;
  final Value<String?> caption;
  final Value<int> displayOrder;
  final Value<String> attachmentType;
  final Value<bool> isInline;
  final Value<DateTime> uploadedAt;
  final Value<String?> uploadedBy;
  const KnowledgeAttachmentsCompanion({
    this.id = const Value.absent(),
    this.entryId = const Value.absent(),
    this.fileName = const Value.absent(),
    this.filePath = const Value.absent(),
    this.fileType = const Value.absent(),
    this.fileSizeBytes = const Value.absent(),
    this.fileHash = const Value.absent(),
    this.altText = const Value.absent(),
    this.caption = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.attachmentType = const Value.absent(),
    this.isInline = const Value.absent(),
    this.uploadedAt = const Value.absent(),
    this.uploadedBy = const Value.absent(),
  });
  KnowledgeAttachmentsCompanion.insert({
    this.id = const Value.absent(),
    required String entryId,
    required String fileName,
    required String filePath,
    required String fileType,
    required int fileSizeBytes,
    this.fileHash = const Value.absent(),
    this.altText = const Value.absent(),
    this.caption = const Value.absent(),
    this.displayOrder = const Value.absent(),
    required String attachmentType,
    this.isInline = const Value.absent(),
    required DateTime uploadedAt,
    this.uploadedBy = const Value.absent(),
  })  : entryId = Value(entryId),
        fileName = Value(fileName),
        filePath = Value(filePath),
        fileType = Value(fileType),
        fileSizeBytes = Value(fileSizeBytes),
        attachmentType = Value(attachmentType),
        uploadedAt = Value(uploadedAt);
  static Insertable<KnowledgeAttachment> custom({
    Expression<int>? id,
    Expression<String>? entryId,
    Expression<String>? fileName,
    Expression<String>? filePath,
    Expression<String>? fileType,
    Expression<int>? fileSizeBytes,
    Expression<String>? fileHash,
    Expression<String>? altText,
    Expression<String>? caption,
    Expression<int>? displayOrder,
    Expression<String>? attachmentType,
    Expression<bool>? isInline,
    Expression<DateTime>? uploadedAt,
    Expression<String>? uploadedBy,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entryId != null) 'entry_id': entryId,
      if (fileName != null) 'file_name': fileName,
      if (filePath != null) 'file_path': filePath,
      if (fileType != null) 'file_type': fileType,
      if (fileSizeBytes != null) 'file_size_bytes': fileSizeBytes,
      if (fileHash != null) 'file_hash': fileHash,
      if (altText != null) 'alt_text': altText,
      if (caption != null) 'caption': caption,
      if (displayOrder != null) 'display_order': displayOrder,
      if (attachmentType != null) 'attachment_type': attachmentType,
      if (isInline != null) 'is_inline': isInline,
      if (uploadedAt != null) 'uploaded_at': uploadedAt,
      if (uploadedBy != null) 'uploaded_by': uploadedBy,
    });
  }

  KnowledgeAttachmentsCompanion copyWith(
      {Value<int>? id,
      Value<String>? entryId,
      Value<String>? fileName,
      Value<String>? filePath,
      Value<String>? fileType,
      Value<int>? fileSizeBytes,
      Value<String?>? fileHash,
      Value<String?>? altText,
      Value<String?>? caption,
      Value<int>? displayOrder,
      Value<String>? attachmentType,
      Value<bool>? isInline,
      Value<DateTime>? uploadedAt,
      Value<String?>? uploadedBy}) {
    return KnowledgeAttachmentsCompanion(
      id: id ?? this.id,
      entryId: entryId ?? this.entryId,
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
      fileType: fileType ?? this.fileType,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
      fileHash: fileHash ?? this.fileHash,
      altText: altText ?? this.altText,
      caption: caption ?? this.caption,
      displayOrder: displayOrder ?? this.displayOrder,
      attachmentType: attachmentType ?? this.attachmentType,
      isInline: isInline ?? this.isInline,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      uploadedBy: uploadedBy ?? this.uploadedBy,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entryId.present) {
      map['entry_id'] = Variable<String>(entryId.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (fileType.present) {
      map['file_type'] = Variable<String>(fileType.value);
    }
    if (fileSizeBytes.present) {
      map['file_size_bytes'] = Variable<int>(fileSizeBytes.value);
    }
    if (fileHash.present) {
      map['file_hash'] = Variable<String>(fileHash.value);
    }
    if (altText.present) {
      map['alt_text'] = Variable<String>(altText.value);
    }
    if (caption.present) {
      map['caption'] = Variable<String>(caption.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    if (attachmentType.present) {
      map['attachment_type'] = Variable<String>(attachmentType.value);
    }
    if (isInline.present) {
      map['is_inline'] = Variable<bool>(isInline.value);
    }
    if (uploadedAt.present) {
      map['uploaded_at'] = Variable<DateTime>(uploadedAt.value);
    }
    if (uploadedBy.present) {
      map['uploaded_by'] = Variable<String>(uploadedBy.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeAttachmentsCompanion(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('fileName: $fileName, ')
          ..write('filePath: $filePath, ')
          ..write('fileType: $fileType, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('fileHash: $fileHash, ')
          ..write('altText: $altText, ')
          ..write('caption: $caption, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('attachmentType: $attachmentType, ')
          ..write('isInline: $isInline, ')
          ..write('uploadedAt: $uploadedAt, ')
          ..write('uploadedBy: $uploadedBy')
          ..write(')'))
        .toString();
  }
}

class $KnowledgeHistoryTable extends KnowledgeHistory
    with TableInfo<$KnowledgeHistoryTable, KnowledgeHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KnowledgeHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _entryIdMeta =
      const VerificationMeta('entryId');
  @override
  late final GeneratedColumn<String> entryId = GeneratedColumn<String>(
      'entry_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES knowledge_entries (id)'));
  static const VerificationMeta _changeTypeMeta =
      const VerificationMeta('changeType');
  @override
  late final GeneratedColumn<String> changeType = GeneratedColumn<String>(
      'change_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fieldNameMeta =
      const VerificationMeta('fieldName');
  @override
  late final GeneratedColumn<String> fieldName = GeneratedColumn<String>(
      'field_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _oldValueMeta =
      const VerificationMeta('oldValue');
  @override
  late final GeneratedColumn<String> oldValue = GeneratedColumn<String>(
      'old_value', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _newValueMeta =
      const VerificationMeta('newValue');
  @override
  late final GeneratedColumn<String> newValue = GeneratedColumn<String>(
      'new_value', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _changeNotesMeta =
      const VerificationMeta('changeNotes');
  @override
  late final GeneratedColumn<String> changeNotes = GeneratedColumn<String>(
      'change_notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _changedByMeta =
      const VerificationMeta('changedBy');
  @override
  late final GeneratedColumn<String> changedBy = GeneratedColumn<String>(
      'changed_by', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _changedByRoleMeta =
      const VerificationMeta('changedByRole');
  @override
  late final GeneratedColumn<String> changedByRole = GeneratedColumn<String>(
      'changed_by_role', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _changedAtMeta =
      const VerificationMeta('changedAt');
  @override
  late final GeneratedColumn<DateTime> changedAt = GeneratedColumn<DateTime>(
      'changed_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _versionBeforeMeta =
      const VerificationMeta('versionBefore');
  @override
  late final GeneratedColumn<String> versionBefore = GeneratedColumn<String>(
      'version_before', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _versionAfterMeta =
      const VerificationMeta('versionAfter');
  @override
  late final GeneratedColumn<String> versionAfter = GeneratedColumn<String>(
      'version_after', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        entryId,
        changeType,
        fieldName,
        oldValue,
        newValue,
        changeNotes,
        changedBy,
        changedByRole,
        changedAt,
        versionBefore,
        versionAfter
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'knowledge_history';
  @override
  VerificationContext validateIntegrity(
      Insertable<KnowledgeHistoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entry_id')) {
      context.handle(_entryIdMeta,
          entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta));
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('change_type')) {
      context.handle(
          _changeTypeMeta,
          changeType.isAcceptableOrUnknown(
              data['change_type']!, _changeTypeMeta));
    } else if (isInserting) {
      context.missing(_changeTypeMeta);
    }
    if (data.containsKey('field_name')) {
      context.handle(_fieldNameMeta,
          fieldName.isAcceptableOrUnknown(data['field_name']!, _fieldNameMeta));
    }
    if (data.containsKey('old_value')) {
      context.handle(_oldValueMeta,
          oldValue.isAcceptableOrUnknown(data['old_value']!, _oldValueMeta));
    }
    if (data.containsKey('new_value')) {
      context.handle(_newValueMeta,
          newValue.isAcceptableOrUnknown(data['new_value']!, _newValueMeta));
    }
    if (data.containsKey('change_notes')) {
      context.handle(
          _changeNotesMeta,
          changeNotes.isAcceptableOrUnknown(
              data['change_notes']!, _changeNotesMeta));
    }
    if (data.containsKey('changed_by')) {
      context.handle(_changedByMeta,
          changedBy.isAcceptableOrUnknown(data['changed_by']!, _changedByMeta));
    } else if (isInserting) {
      context.missing(_changedByMeta);
    }
    if (data.containsKey('changed_by_role')) {
      context.handle(
          _changedByRoleMeta,
          changedByRole.isAcceptableOrUnknown(
              data['changed_by_role']!, _changedByRoleMeta));
    }
    if (data.containsKey('changed_at')) {
      context.handle(_changedAtMeta,
          changedAt.isAcceptableOrUnknown(data['changed_at']!, _changedAtMeta));
    } else if (isInserting) {
      context.missing(_changedAtMeta);
    }
    if (data.containsKey('version_before')) {
      context.handle(
          _versionBeforeMeta,
          versionBefore.isAcceptableOrUnknown(
              data['version_before']!, _versionBeforeMeta));
    }
    if (data.containsKey('version_after')) {
      context.handle(
          _versionAfterMeta,
          versionAfter.isAcceptableOrUnknown(
              data['version_after']!, _versionAfterMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KnowledgeHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KnowledgeHistoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      entryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entry_id'])!,
      changeType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}change_type'])!,
      fieldName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}field_name']),
      oldValue: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}old_value']),
      newValue: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}new_value']),
      changeNotes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}change_notes']),
      changedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}changed_by'])!,
      changedByRole: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}changed_by_role']),
      changedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}changed_at'])!,
      versionBefore: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}version_before']),
      versionAfter: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}version_after']),
    );
  }

  @override
  $KnowledgeHistoryTable createAlias(String alias) {
    return $KnowledgeHistoryTable(attachedDatabase, alias);
  }
}

class KnowledgeHistoryData extends DataClass
    implements Insertable<KnowledgeHistoryData> {
  final int id;
  final String entryId;
  final String changeType;
  final String? fieldName;
  final String? oldValue;
  final String? newValue;
  final String? changeNotes;
  final String changedBy;
  final String? changedByRole;
  final DateTime changedAt;
  final String? versionBefore;
  final String? versionAfter;
  const KnowledgeHistoryData(
      {required this.id,
      required this.entryId,
      required this.changeType,
      this.fieldName,
      this.oldValue,
      this.newValue,
      this.changeNotes,
      required this.changedBy,
      this.changedByRole,
      required this.changedAt,
      this.versionBefore,
      this.versionAfter});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entry_id'] = Variable<String>(entryId);
    map['change_type'] = Variable<String>(changeType);
    if (!nullToAbsent || fieldName != null) {
      map['field_name'] = Variable<String>(fieldName);
    }
    if (!nullToAbsent || oldValue != null) {
      map['old_value'] = Variable<String>(oldValue);
    }
    if (!nullToAbsent || newValue != null) {
      map['new_value'] = Variable<String>(newValue);
    }
    if (!nullToAbsent || changeNotes != null) {
      map['change_notes'] = Variable<String>(changeNotes);
    }
    map['changed_by'] = Variable<String>(changedBy);
    if (!nullToAbsent || changedByRole != null) {
      map['changed_by_role'] = Variable<String>(changedByRole);
    }
    map['changed_at'] = Variable<DateTime>(changedAt);
    if (!nullToAbsent || versionBefore != null) {
      map['version_before'] = Variable<String>(versionBefore);
    }
    if (!nullToAbsent || versionAfter != null) {
      map['version_after'] = Variable<String>(versionAfter);
    }
    return map;
  }

  KnowledgeHistoryCompanion toCompanion(bool nullToAbsent) {
    return KnowledgeHistoryCompanion(
      id: Value(id),
      entryId: Value(entryId),
      changeType: Value(changeType),
      fieldName: fieldName == null && nullToAbsent
          ? const Value.absent()
          : Value(fieldName),
      oldValue: oldValue == null && nullToAbsent
          ? const Value.absent()
          : Value(oldValue),
      newValue: newValue == null && nullToAbsent
          ? const Value.absent()
          : Value(newValue),
      changeNotes: changeNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(changeNotes),
      changedBy: Value(changedBy),
      changedByRole: changedByRole == null && nullToAbsent
          ? const Value.absent()
          : Value(changedByRole),
      changedAt: Value(changedAt),
      versionBefore: versionBefore == null && nullToAbsent
          ? const Value.absent()
          : Value(versionBefore),
      versionAfter: versionAfter == null && nullToAbsent
          ? const Value.absent()
          : Value(versionAfter),
    );
  }

  factory KnowledgeHistoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KnowledgeHistoryData(
      id: serializer.fromJson<int>(json['id']),
      entryId: serializer.fromJson<String>(json['entryId']),
      changeType: serializer.fromJson<String>(json['changeType']),
      fieldName: serializer.fromJson<String?>(json['fieldName']),
      oldValue: serializer.fromJson<String?>(json['oldValue']),
      newValue: serializer.fromJson<String?>(json['newValue']),
      changeNotes: serializer.fromJson<String?>(json['changeNotes']),
      changedBy: serializer.fromJson<String>(json['changedBy']),
      changedByRole: serializer.fromJson<String?>(json['changedByRole']),
      changedAt: serializer.fromJson<DateTime>(json['changedAt']),
      versionBefore: serializer.fromJson<String?>(json['versionBefore']),
      versionAfter: serializer.fromJson<String?>(json['versionAfter']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entryId': serializer.toJson<String>(entryId),
      'changeType': serializer.toJson<String>(changeType),
      'fieldName': serializer.toJson<String?>(fieldName),
      'oldValue': serializer.toJson<String?>(oldValue),
      'newValue': serializer.toJson<String?>(newValue),
      'changeNotes': serializer.toJson<String?>(changeNotes),
      'changedBy': serializer.toJson<String>(changedBy),
      'changedByRole': serializer.toJson<String?>(changedByRole),
      'changedAt': serializer.toJson<DateTime>(changedAt),
      'versionBefore': serializer.toJson<String?>(versionBefore),
      'versionAfter': serializer.toJson<String?>(versionAfter),
    };
  }

  KnowledgeHistoryData copyWith(
          {int? id,
          String? entryId,
          String? changeType,
          Value<String?> fieldName = const Value.absent(),
          Value<String?> oldValue = const Value.absent(),
          Value<String?> newValue = const Value.absent(),
          Value<String?> changeNotes = const Value.absent(),
          String? changedBy,
          Value<String?> changedByRole = const Value.absent(),
          DateTime? changedAt,
          Value<String?> versionBefore = const Value.absent(),
          Value<String?> versionAfter = const Value.absent()}) =>
      KnowledgeHistoryData(
        id: id ?? this.id,
        entryId: entryId ?? this.entryId,
        changeType: changeType ?? this.changeType,
        fieldName: fieldName.present ? fieldName.value : this.fieldName,
        oldValue: oldValue.present ? oldValue.value : this.oldValue,
        newValue: newValue.present ? newValue.value : this.newValue,
        changeNotes: changeNotes.present ? changeNotes.value : this.changeNotes,
        changedBy: changedBy ?? this.changedBy,
        changedByRole:
            changedByRole.present ? changedByRole.value : this.changedByRole,
        changedAt: changedAt ?? this.changedAt,
        versionBefore:
            versionBefore.present ? versionBefore.value : this.versionBefore,
        versionAfter:
            versionAfter.present ? versionAfter.value : this.versionAfter,
      );
  KnowledgeHistoryData copyWithCompanion(KnowledgeHistoryCompanion data) {
    return KnowledgeHistoryData(
      id: data.id.present ? data.id.value : this.id,
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      changeType:
          data.changeType.present ? data.changeType.value : this.changeType,
      fieldName: data.fieldName.present ? data.fieldName.value : this.fieldName,
      oldValue: data.oldValue.present ? data.oldValue.value : this.oldValue,
      newValue: data.newValue.present ? data.newValue.value : this.newValue,
      changeNotes:
          data.changeNotes.present ? data.changeNotes.value : this.changeNotes,
      changedBy: data.changedBy.present ? data.changedBy.value : this.changedBy,
      changedByRole: data.changedByRole.present
          ? data.changedByRole.value
          : this.changedByRole,
      changedAt: data.changedAt.present ? data.changedAt.value : this.changedAt,
      versionBefore: data.versionBefore.present
          ? data.versionBefore.value
          : this.versionBefore,
      versionAfter: data.versionAfter.present
          ? data.versionAfter.value
          : this.versionAfter,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeHistoryData(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('changeType: $changeType, ')
          ..write('fieldName: $fieldName, ')
          ..write('oldValue: $oldValue, ')
          ..write('newValue: $newValue, ')
          ..write('changeNotes: $changeNotes, ')
          ..write('changedBy: $changedBy, ')
          ..write('changedByRole: $changedByRole, ')
          ..write('changedAt: $changedAt, ')
          ..write('versionBefore: $versionBefore, ')
          ..write('versionAfter: $versionAfter')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      entryId,
      changeType,
      fieldName,
      oldValue,
      newValue,
      changeNotes,
      changedBy,
      changedByRole,
      changedAt,
      versionBefore,
      versionAfter);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KnowledgeHistoryData &&
          other.id == this.id &&
          other.entryId == this.entryId &&
          other.changeType == this.changeType &&
          other.fieldName == this.fieldName &&
          other.oldValue == this.oldValue &&
          other.newValue == this.newValue &&
          other.changeNotes == this.changeNotes &&
          other.changedBy == this.changedBy &&
          other.changedByRole == this.changedByRole &&
          other.changedAt == this.changedAt &&
          other.versionBefore == this.versionBefore &&
          other.versionAfter == this.versionAfter);
}

class KnowledgeHistoryCompanion extends UpdateCompanion<KnowledgeHistoryData> {
  final Value<int> id;
  final Value<String> entryId;
  final Value<String> changeType;
  final Value<String?> fieldName;
  final Value<String?> oldValue;
  final Value<String?> newValue;
  final Value<String?> changeNotes;
  final Value<String> changedBy;
  final Value<String?> changedByRole;
  final Value<DateTime> changedAt;
  final Value<String?> versionBefore;
  final Value<String?> versionAfter;
  const KnowledgeHistoryCompanion({
    this.id = const Value.absent(),
    this.entryId = const Value.absent(),
    this.changeType = const Value.absent(),
    this.fieldName = const Value.absent(),
    this.oldValue = const Value.absent(),
    this.newValue = const Value.absent(),
    this.changeNotes = const Value.absent(),
    this.changedBy = const Value.absent(),
    this.changedByRole = const Value.absent(),
    this.changedAt = const Value.absent(),
    this.versionBefore = const Value.absent(),
    this.versionAfter = const Value.absent(),
  });
  KnowledgeHistoryCompanion.insert({
    this.id = const Value.absent(),
    required String entryId,
    required String changeType,
    this.fieldName = const Value.absent(),
    this.oldValue = const Value.absent(),
    this.newValue = const Value.absent(),
    this.changeNotes = const Value.absent(),
    required String changedBy,
    this.changedByRole = const Value.absent(),
    required DateTime changedAt,
    this.versionBefore = const Value.absent(),
    this.versionAfter = const Value.absent(),
  })  : entryId = Value(entryId),
        changeType = Value(changeType),
        changedBy = Value(changedBy),
        changedAt = Value(changedAt);
  static Insertable<KnowledgeHistoryData> custom({
    Expression<int>? id,
    Expression<String>? entryId,
    Expression<String>? changeType,
    Expression<String>? fieldName,
    Expression<String>? oldValue,
    Expression<String>? newValue,
    Expression<String>? changeNotes,
    Expression<String>? changedBy,
    Expression<String>? changedByRole,
    Expression<DateTime>? changedAt,
    Expression<String>? versionBefore,
    Expression<String>? versionAfter,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entryId != null) 'entry_id': entryId,
      if (changeType != null) 'change_type': changeType,
      if (fieldName != null) 'field_name': fieldName,
      if (oldValue != null) 'old_value': oldValue,
      if (newValue != null) 'new_value': newValue,
      if (changeNotes != null) 'change_notes': changeNotes,
      if (changedBy != null) 'changed_by': changedBy,
      if (changedByRole != null) 'changed_by_role': changedByRole,
      if (changedAt != null) 'changed_at': changedAt,
      if (versionBefore != null) 'version_before': versionBefore,
      if (versionAfter != null) 'version_after': versionAfter,
    });
  }

  KnowledgeHistoryCompanion copyWith(
      {Value<int>? id,
      Value<String>? entryId,
      Value<String>? changeType,
      Value<String?>? fieldName,
      Value<String?>? oldValue,
      Value<String?>? newValue,
      Value<String?>? changeNotes,
      Value<String>? changedBy,
      Value<String?>? changedByRole,
      Value<DateTime>? changedAt,
      Value<String?>? versionBefore,
      Value<String?>? versionAfter}) {
    return KnowledgeHistoryCompanion(
      id: id ?? this.id,
      entryId: entryId ?? this.entryId,
      changeType: changeType ?? this.changeType,
      fieldName: fieldName ?? this.fieldName,
      oldValue: oldValue ?? this.oldValue,
      newValue: newValue ?? this.newValue,
      changeNotes: changeNotes ?? this.changeNotes,
      changedBy: changedBy ?? this.changedBy,
      changedByRole: changedByRole ?? this.changedByRole,
      changedAt: changedAt ?? this.changedAt,
      versionBefore: versionBefore ?? this.versionBefore,
      versionAfter: versionAfter ?? this.versionAfter,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entryId.present) {
      map['entry_id'] = Variable<String>(entryId.value);
    }
    if (changeType.present) {
      map['change_type'] = Variable<String>(changeType.value);
    }
    if (fieldName.present) {
      map['field_name'] = Variable<String>(fieldName.value);
    }
    if (oldValue.present) {
      map['old_value'] = Variable<String>(oldValue.value);
    }
    if (newValue.present) {
      map['new_value'] = Variable<String>(newValue.value);
    }
    if (changeNotes.present) {
      map['change_notes'] = Variable<String>(changeNotes.value);
    }
    if (changedBy.present) {
      map['changed_by'] = Variable<String>(changedBy.value);
    }
    if (changedByRole.present) {
      map['changed_by_role'] = Variable<String>(changedByRole.value);
    }
    if (changedAt.present) {
      map['changed_at'] = Variable<DateTime>(changedAt.value);
    }
    if (versionBefore.present) {
      map['version_before'] = Variable<String>(versionBefore.value);
    }
    if (versionAfter.present) {
      map['version_after'] = Variable<String>(versionAfter.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeHistoryCompanion(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('changeType: $changeType, ')
          ..write('fieldName: $fieldName, ')
          ..write('oldValue: $oldValue, ')
          ..write('newValue: $newValue, ')
          ..write('changeNotes: $changeNotes, ')
          ..write('changedBy: $changedBy, ')
          ..write('changedByRole: $changedByRole, ')
          ..write('changedAt: $changedAt, ')
          ..write('versionBefore: $versionBefore, ')
          ..write('versionAfter: $versionAfter')
          ..write(')'))
        .toString();
  }
}

class $KnowledgeRelationsTable extends KnowledgeRelations
    with TableInfo<$KnowledgeRelationsTable, KnowledgeRelation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KnowledgeRelationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _fromEntryIdMeta =
      const VerificationMeta('fromEntryId');
  @override
  late final GeneratedColumn<String> fromEntryId = GeneratedColumn<String>(
      'from_entry_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES knowledge_entries (id)'));
  static const VerificationMeta _toEntryIdMeta =
      const VerificationMeta('toEntryId');
  @override
  late final GeneratedColumn<String> toEntryId = GeneratedColumn<String>(
      'to_entry_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES knowledge_entries (id)'));
  static const VerificationMeta _relationTypeMeta =
      const VerificationMeta('relationType');
  @override
  late final GeneratedColumn<String> relationType = GeneratedColumn<String>(
      'relation_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _strengthMeta =
      const VerificationMeta('strength');
  @override
  late final GeneratedColumn<int> strength = GeneratedColumn<int>(
      'strength', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(50));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdByMeta =
      const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
      'created_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        fromEntryId,
        toEntryId,
        relationType,
        strength,
        createdAt,
        createdBy
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'knowledge_relations';
  @override
  VerificationContext validateIntegrity(Insertable<KnowledgeRelation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('from_entry_id')) {
      context.handle(
          _fromEntryIdMeta,
          fromEntryId.isAcceptableOrUnknown(
              data['from_entry_id']!, _fromEntryIdMeta));
    } else if (isInserting) {
      context.missing(_fromEntryIdMeta);
    }
    if (data.containsKey('to_entry_id')) {
      context.handle(
          _toEntryIdMeta,
          toEntryId.isAcceptableOrUnknown(
              data['to_entry_id']!, _toEntryIdMeta));
    } else if (isInserting) {
      context.missing(_toEntryIdMeta);
    }
    if (data.containsKey('relation_type')) {
      context.handle(
          _relationTypeMeta,
          relationType.isAcceptableOrUnknown(
              data['relation_type']!, _relationTypeMeta));
    } else if (isInserting) {
      context.missing(_relationTypeMeta);
    }
    if (data.containsKey('strength')) {
      context.handle(_strengthMeta,
          strength.isAcceptableOrUnknown(data['strength']!, _strengthMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KnowledgeRelation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KnowledgeRelation(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      fromEntryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}from_entry_id'])!,
      toEntryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}to_entry_id'])!,
      relationType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}relation_type'])!,
      strength: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}strength'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      createdBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_by']),
    );
  }

  @override
  $KnowledgeRelationsTable createAlias(String alias) {
    return $KnowledgeRelationsTable(attachedDatabase, alias);
  }
}

class KnowledgeRelation extends DataClass
    implements Insertable<KnowledgeRelation> {
  final int id;
  final String fromEntryId;
  final String toEntryId;
  final String relationType;
  final int strength;
  final DateTime createdAt;
  final String? createdBy;
  const KnowledgeRelation(
      {required this.id,
      required this.fromEntryId,
      required this.toEntryId,
      required this.relationType,
      required this.strength,
      required this.createdAt,
      this.createdBy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['from_entry_id'] = Variable<String>(fromEntryId);
    map['to_entry_id'] = Variable<String>(toEntryId);
    map['relation_type'] = Variable<String>(relationType);
    map['strength'] = Variable<int>(strength);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    return map;
  }

  KnowledgeRelationsCompanion toCompanion(bool nullToAbsent) {
    return KnowledgeRelationsCompanion(
      id: Value(id),
      fromEntryId: Value(fromEntryId),
      toEntryId: Value(toEntryId),
      relationType: Value(relationType),
      strength: Value(strength),
      createdAt: Value(createdAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
    );
  }

  factory KnowledgeRelation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KnowledgeRelation(
      id: serializer.fromJson<int>(json['id']),
      fromEntryId: serializer.fromJson<String>(json['fromEntryId']),
      toEntryId: serializer.fromJson<String>(json['toEntryId']),
      relationType: serializer.fromJson<String>(json['relationType']),
      strength: serializer.fromJson<int>(json['strength']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fromEntryId': serializer.toJson<String>(fromEntryId),
      'toEntryId': serializer.toJson<String>(toEntryId),
      'relationType': serializer.toJson<String>(relationType),
      'strength': serializer.toJson<int>(strength),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'createdBy': serializer.toJson<String?>(createdBy),
    };
  }

  KnowledgeRelation copyWith(
          {int? id,
          String? fromEntryId,
          String? toEntryId,
          String? relationType,
          int? strength,
          DateTime? createdAt,
          Value<String?> createdBy = const Value.absent()}) =>
      KnowledgeRelation(
        id: id ?? this.id,
        fromEntryId: fromEntryId ?? this.fromEntryId,
        toEntryId: toEntryId ?? this.toEntryId,
        relationType: relationType ?? this.relationType,
        strength: strength ?? this.strength,
        createdAt: createdAt ?? this.createdAt,
        createdBy: createdBy.present ? createdBy.value : this.createdBy,
      );
  KnowledgeRelation copyWithCompanion(KnowledgeRelationsCompanion data) {
    return KnowledgeRelation(
      id: data.id.present ? data.id.value : this.id,
      fromEntryId:
          data.fromEntryId.present ? data.fromEntryId.value : this.fromEntryId,
      toEntryId: data.toEntryId.present ? data.toEntryId.value : this.toEntryId,
      relationType: data.relationType.present
          ? data.relationType.value
          : this.relationType,
      strength: data.strength.present ? data.strength.value : this.strength,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeRelation(')
          ..write('id: $id, ')
          ..write('fromEntryId: $fromEntryId, ')
          ..write('toEntryId: $toEntryId, ')
          ..write('relationType: $relationType, ')
          ..write('strength: $strength, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, fromEntryId, toEntryId, relationType, strength, createdAt, createdBy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KnowledgeRelation &&
          other.id == this.id &&
          other.fromEntryId == this.fromEntryId &&
          other.toEntryId == this.toEntryId &&
          other.relationType == this.relationType &&
          other.strength == this.strength &&
          other.createdAt == this.createdAt &&
          other.createdBy == this.createdBy);
}

class KnowledgeRelationsCompanion extends UpdateCompanion<KnowledgeRelation> {
  final Value<int> id;
  final Value<String> fromEntryId;
  final Value<String> toEntryId;
  final Value<String> relationType;
  final Value<int> strength;
  final Value<DateTime> createdAt;
  final Value<String?> createdBy;
  const KnowledgeRelationsCompanion({
    this.id = const Value.absent(),
    this.fromEntryId = const Value.absent(),
    this.toEntryId = const Value.absent(),
    this.relationType = const Value.absent(),
    this.strength = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createdBy = const Value.absent(),
  });
  KnowledgeRelationsCompanion.insert({
    this.id = const Value.absent(),
    required String fromEntryId,
    required String toEntryId,
    required String relationType,
    this.strength = const Value.absent(),
    required DateTime createdAt,
    this.createdBy = const Value.absent(),
  })  : fromEntryId = Value(fromEntryId),
        toEntryId = Value(toEntryId),
        relationType = Value(relationType),
        createdAt = Value(createdAt);
  static Insertable<KnowledgeRelation> custom({
    Expression<int>? id,
    Expression<String>? fromEntryId,
    Expression<String>? toEntryId,
    Expression<String>? relationType,
    Expression<int>? strength,
    Expression<DateTime>? createdAt,
    Expression<String>? createdBy,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fromEntryId != null) 'from_entry_id': fromEntryId,
      if (toEntryId != null) 'to_entry_id': toEntryId,
      if (relationType != null) 'relation_type': relationType,
      if (strength != null) 'strength': strength,
      if (createdAt != null) 'created_at': createdAt,
      if (createdBy != null) 'created_by': createdBy,
    });
  }

  KnowledgeRelationsCompanion copyWith(
      {Value<int>? id,
      Value<String>? fromEntryId,
      Value<String>? toEntryId,
      Value<String>? relationType,
      Value<int>? strength,
      Value<DateTime>? createdAt,
      Value<String?>? createdBy}) {
    return KnowledgeRelationsCompanion(
      id: id ?? this.id,
      fromEntryId: fromEntryId ?? this.fromEntryId,
      toEntryId: toEntryId ?? this.toEntryId,
      relationType: relationType ?? this.relationType,
      strength: strength ?? this.strength,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fromEntryId.present) {
      map['from_entry_id'] = Variable<String>(fromEntryId.value);
    }
    if (toEntryId.present) {
      map['to_entry_id'] = Variable<String>(toEntryId.value);
    }
    if (relationType.present) {
      map['relation_type'] = Variable<String>(relationType.value);
    }
    if (strength.present) {
      map['strength'] = Variable<int>(strength.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KnowledgeRelationsCompanion(')
          ..write('id: $id, ')
          ..write('fromEntryId: $fromEntryId, ')
          ..write('toEntryId: $toEntryId, ')
          ..write('relationType: $relationType, ')
          ..write('strength: $strength, ')
          ..write('createdAt: $createdAt, ')
          ..write('createdBy: $createdBy')
          ..write(')'))
        .toString();
  }
}

class $MachineProfilesTable extends MachineProfiles
    with TableInfo<$MachineProfilesTable, MachineProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MachineProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _equipmentTypeMeta =
      const VerificationMeta('equipmentType');
  @override
  late final GeneratedColumn<String> equipmentType = GeneratedColumn<String>(
      'equipment_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _manufacturerMeta =
      const VerificationMeta('manufacturer');
  @override
  late final GeneratedColumn<String> manufacturer = GeneratedColumn<String>(
      'manufacturer', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
      'model', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _aliasesMeta =
      const VerificationMeta('aliases');
  @override
  late final GeneratedColumn<String> aliases = GeneratedColumn<String>(
      'aliases', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _searchKeysMeta =
      const VerificationMeta('searchKeys');
  @override
  late final GeneratedColumn<String> searchKeys = GeneratedColumn<String>(
      'search_keys', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageAssetMeta =
      const VerificationMeta('imageAsset');
  @override
  late final GeneratedColumn<String> imageAsset = GeneratedColumn<String>(
      'image_asset', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        equipmentType,
        manufacturer,
        model,
        aliases,
        searchKeys,
        description,
        imageAsset,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'machine_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<MachineProfile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('equipment_type')) {
      context.handle(
          _equipmentTypeMeta,
          equipmentType.isAcceptableOrUnknown(
              data['equipment_type']!, _equipmentTypeMeta));
    } else if (isInserting) {
      context.missing(_equipmentTypeMeta);
    }
    if (data.containsKey('manufacturer')) {
      context.handle(
          _manufacturerMeta,
          manufacturer.isAcceptableOrUnknown(
              data['manufacturer']!, _manufacturerMeta));
    } else if (isInserting) {
      context.missing(_manufacturerMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
          _modelMeta, model.isAcceptableOrUnknown(data['model']!, _modelMeta));
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('aliases')) {
      context.handle(_aliasesMeta,
          aliases.isAcceptableOrUnknown(data['aliases']!, _aliasesMeta));
    }
    if (data.containsKey('search_keys')) {
      context.handle(
          _searchKeysMeta,
          searchKeys.isAcceptableOrUnknown(
              data['search_keys']!, _searchKeysMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('image_asset')) {
      context.handle(
          _imageAssetMeta,
          imageAsset.isAcceptableOrUnknown(
              data['image_asset']!, _imageAssetMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MachineProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MachineProfile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      equipmentType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}equipment_type'])!,
      manufacturer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}manufacturer'])!,
      model: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}model'])!,
      aliases: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}aliases']),
      searchKeys: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}search_keys']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      imageAsset: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_asset']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $MachineProfilesTable createAlias(String alias) {
    return $MachineProfilesTable(attachedDatabase, alias);
  }
}

class MachineProfile extends DataClass implements Insertable<MachineProfile> {
  final int id;
  final String equipmentType;
  final String manufacturer;
  final String model;
  final String? aliases;
  final String? searchKeys;
  final String? description;
  final String? imageAsset;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MachineProfile(
      {required this.id,
      required this.equipmentType,
      required this.manufacturer,
      required this.model,
      this.aliases,
      this.searchKeys,
      this.description,
      this.imageAsset,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['equipment_type'] = Variable<String>(equipmentType);
    map['manufacturer'] = Variable<String>(manufacturer);
    map['model'] = Variable<String>(model);
    if (!nullToAbsent || aliases != null) {
      map['aliases'] = Variable<String>(aliases);
    }
    if (!nullToAbsent || searchKeys != null) {
      map['search_keys'] = Variable<String>(searchKeys);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || imageAsset != null) {
      map['image_asset'] = Variable<String>(imageAsset);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MachineProfilesCompanion toCompanion(bool nullToAbsent) {
    return MachineProfilesCompanion(
      id: Value(id),
      equipmentType: Value(equipmentType),
      manufacturer: Value(manufacturer),
      model: Value(model),
      aliases: aliases == null && nullToAbsent
          ? const Value.absent()
          : Value(aliases),
      searchKeys: searchKeys == null && nullToAbsent
          ? const Value.absent()
          : Value(searchKeys),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      imageAsset: imageAsset == null && nullToAbsent
          ? const Value.absent()
          : Value(imageAsset),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MachineProfile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MachineProfile(
      id: serializer.fromJson<int>(json['id']),
      equipmentType: serializer.fromJson<String>(json['equipmentType']),
      manufacturer: serializer.fromJson<String>(json['manufacturer']),
      model: serializer.fromJson<String>(json['model']),
      aliases: serializer.fromJson<String?>(json['aliases']),
      searchKeys: serializer.fromJson<String?>(json['searchKeys']),
      description: serializer.fromJson<String?>(json['description']),
      imageAsset: serializer.fromJson<String?>(json['imageAsset']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'equipmentType': serializer.toJson<String>(equipmentType),
      'manufacturer': serializer.toJson<String>(manufacturer),
      'model': serializer.toJson<String>(model),
      'aliases': serializer.toJson<String?>(aliases),
      'searchKeys': serializer.toJson<String?>(searchKeys),
      'description': serializer.toJson<String?>(description),
      'imageAsset': serializer.toJson<String?>(imageAsset),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MachineProfile copyWith(
          {int? id,
          String? equipmentType,
          String? manufacturer,
          String? model,
          Value<String?> aliases = const Value.absent(),
          Value<String?> searchKeys = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> imageAsset = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      MachineProfile(
        id: id ?? this.id,
        equipmentType: equipmentType ?? this.equipmentType,
        manufacturer: manufacturer ?? this.manufacturer,
        model: model ?? this.model,
        aliases: aliases.present ? aliases.value : this.aliases,
        searchKeys: searchKeys.present ? searchKeys.value : this.searchKeys,
        description: description.present ? description.value : this.description,
        imageAsset: imageAsset.present ? imageAsset.value : this.imageAsset,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  MachineProfile copyWithCompanion(MachineProfilesCompanion data) {
    return MachineProfile(
      id: data.id.present ? data.id.value : this.id,
      equipmentType: data.equipmentType.present
          ? data.equipmentType.value
          : this.equipmentType,
      manufacturer: data.manufacturer.present
          ? data.manufacturer.value
          : this.manufacturer,
      model: data.model.present ? data.model.value : this.model,
      aliases: data.aliases.present ? data.aliases.value : this.aliases,
      searchKeys:
          data.searchKeys.present ? data.searchKeys.value : this.searchKeys,
      description:
          data.description.present ? data.description.value : this.description,
      imageAsset:
          data.imageAsset.present ? data.imageAsset.value : this.imageAsset,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MachineProfile(')
          ..write('id: $id, ')
          ..write('equipmentType: $equipmentType, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('model: $model, ')
          ..write('aliases: $aliases, ')
          ..write('searchKeys: $searchKeys, ')
          ..write('description: $description, ')
          ..write('imageAsset: $imageAsset, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, equipmentType, manufacturer, model,
      aliases, searchKeys, description, imageAsset, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MachineProfile &&
          other.id == this.id &&
          other.equipmentType == this.equipmentType &&
          other.manufacturer == this.manufacturer &&
          other.model == this.model &&
          other.aliases == this.aliases &&
          other.searchKeys == this.searchKeys &&
          other.description == this.description &&
          other.imageAsset == this.imageAsset &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MachineProfilesCompanion extends UpdateCompanion<MachineProfile> {
  final Value<int> id;
  final Value<String> equipmentType;
  final Value<String> manufacturer;
  final Value<String> model;
  final Value<String?> aliases;
  final Value<String?> searchKeys;
  final Value<String?> description;
  final Value<String?> imageAsset;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const MachineProfilesCompanion({
    this.id = const Value.absent(),
    this.equipmentType = const Value.absent(),
    this.manufacturer = const Value.absent(),
    this.model = const Value.absent(),
    this.aliases = const Value.absent(),
    this.searchKeys = const Value.absent(),
    this.description = const Value.absent(),
    this.imageAsset = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MachineProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String equipmentType,
    required String manufacturer,
    required String model,
    this.aliases = const Value.absent(),
    this.searchKeys = const Value.absent(),
    this.description = const Value.absent(),
    this.imageAsset = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : equipmentType = Value(equipmentType),
        manufacturer = Value(manufacturer),
        model = Value(model);
  static Insertable<MachineProfile> custom({
    Expression<int>? id,
    Expression<String>? equipmentType,
    Expression<String>? manufacturer,
    Expression<String>? model,
    Expression<String>? aliases,
    Expression<String>? searchKeys,
    Expression<String>? description,
    Expression<String>? imageAsset,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (equipmentType != null) 'equipment_type': equipmentType,
      if (manufacturer != null) 'manufacturer': manufacturer,
      if (model != null) 'model': model,
      if (aliases != null) 'aliases': aliases,
      if (searchKeys != null) 'search_keys': searchKeys,
      if (description != null) 'description': description,
      if (imageAsset != null) 'image_asset': imageAsset,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MachineProfilesCompanion copyWith(
      {Value<int>? id,
      Value<String>? equipmentType,
      Value<String>? manufacturer,
      Value<String>? model,
      Value<String?>? aliases,
      Value<String?>? searchKeys,
      Value<String?>? description,
      Value<String?>? imageAsset,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return MachineProfilesCompanion(
      id: id ?? this.id,
      equipmentType: equipmentType ?? this.equipmentType,
      manufacturer: manufacturer ?? this.manufacturer,
      model: model ?? this.model,
      aliases: aliases ?? this.aliases,
      searchKeys: searchKeys ?? this.searchKeys,
      description: description ?? this.description,
      imageAsset: imageAsset ?? this.imageAsset,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (equipmentType.present) {
      map['equipment_type'] = Variable<String>(equipmentType.value);
    }
    if (manufacturer.present) {
      map['manufacturer'] = Variable<String>(manufacturer.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (aliases.present) {
      map['aliases'] = Variable<String>(aliases.value);
    }
    if (searchKeys.present) {
      map['search_keys'] = Variable<String>(searchKeys.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageAsset.present) {
      map['image_asset'] = Variable<String>(imageAsset.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MachineProfilesCompanion(')
          ..write('id: $id, ')
          ..write('equipmentType: $equipmentType, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('model: $model, ')
          ..write('aliases: $aliases, ')
          ..write('searchKeys: $searchKeys, ')
          ..write('description: $description, ')
          ..write('imageAsset: $imageAsset, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ContinuingEducationCoursesTable extends ContinuingEducationCourses
    with
        TableInfo<$ContinuingEducationCoursesTable, ContinuingEducationCourse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContinuingEducationCoursesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _providerMeta =
      const VerificationMeta('provider');
  @override
  late final GeneratedColumn<String> provider = GeneratedColumn<String>(
      'provider', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationHoursMeta =
      const VerificationMeta('durationHours');
  @override
  late final GeneratedColumn<int> durationHours = GeneratedColumn<int>(
      'duration_hours', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _externalUrlMeta =
      const VerificationMeta('externalUrl');
  @override
  late final GeneratedColumn<String> externalUrl = GeneratedColumn<String>(
      'external_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, provider, description, category, durationHours, externalUrl];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'continuing_education_courses';
  @override
  VerificationContext validateIntegrity(
      Insertable<ContinuingEducationCourse> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('provider')) {
      context.handle(_providerMeta,
          provider.isAcceptableOrUnknown(data['provider']!, _providerMeta));
    } else if (isInserting) {
      context.missing(_providerMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('duration_hours')) {
      context.handle(
          _durationHoursMeta,
          durationHours.isAcceptableOrUnknown(
              data['duration_hours']!, _durationHoursMeta));
    }
    if (data.containsKey('external_url')) {
      context.handle(
          _externalUrlMeta,
          externalUrl.isAcceptableOrUnknown(
              data['external_url']!, _externalUrlMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContinuingEducationCourse map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContinuingEducationCourse(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      provider: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}provider'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      durationHours: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_hours']),
      externalUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}external_url']),
    );
  }

  @override
  $ContinuingEducationCoursesTable createAlias(String alias) {
    return $ContinuingEducationCoursesTable(attachedDatabase, alias);
  }
}

class ContinuingEducationCourse extends DataClass
    implements Insertable<ContinuingEducationCourse> {
  final int id;
  final String title;
  final String provider;
  final String? description;
  final String category;
  final int? durationHours;
  final String? externalUrl;
  const ContinuingEducationCourse(
      {required this.id,
      required this.title,
      required this.provider,
      this.description,
      required this.category,
      this.durationHours,
      this.externalUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['provider'] = Variable<String>(provider);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || durationHours != null) {
      map['duration_hours'] = Variable<int>(durationHours);
    }
    if (!nullToAbsent || externalUrl != null) {
      map['external_url'] = Variable<String>(externalUrl);
    }
    return map;
  }

  ContinuingEducationCoursesCompanion toCompanion(bool nullToAbsent) {
    return ContinuingEducationCoursesCompanion(
      id: Value(id),
      title: Value(title),
      provider: Value(provider),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      category: Value(category),
      durationHours: durationHours == null && nullToAbsent
          ? const Value.absent()
          : Value(durationHours),
      externalUrl: externalUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(externalUrl),
    );
  }

  factory ContinuingEducationCourse.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContinuingEducationCourse(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      provider: serializer.fromJson<String>(json['provider']),
      description: serializer.fromJson<String?>(json['description']),
      category: serializer.fromJson<String>(json['category']),
      durationHours: serializer.fromJson<int?>(json['durationHours']),
      externalUrl: serializer.fromJson<String?>(json['externalUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'provider': serializer.toJson<String>(provider),
      'description': serializer.toJson<String?>(description),
      'category': serializer.toJson<String>(category),
      'durationHours': serializer.toJson<int?>(durationHours),
      'externalUrl': serializer.toJson<String?>(externalUrl),
    };
  }

  ContinuingEducationCourse copyWith(
          {int? id,
          String? title,
          String? provider,
          Value<String?> description = const Value.absent(),
          String? category,
          Value<int?> durationHours = const Value.absent(),
          Value<String?> externalUrl = const Value.absent()}) =>
      ContinuingEducationCourse(
        id: id ?? this.id,
        title: title ?? this.title,
        provider: provider ?? this.provider,
        description: description.present ? description.value : this.description,
        category: category ?? this.category,
        durationHours:
            durationHours.present ? durationHours.value : this.durationHours,
        externalUrl: externalUrl.present ? externalUrl.value : this.externalUrl,
      );
  ContinuingEducationCourse copyWithCompanion(
      ContinuingEducationCoursesCompanion data) {
    return ContinuingEducationCourse(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      provider: data.provider.present ? data.provider.value : this.provider,
      description:
          data.description.present ? data.description.value : this.description,
      category: data.category.present ? data.category.value : this.category,
      durationHours: data.durationHours.present
          ? data.durationHours.value
          : this.durationHours,
      externalUrl:
          data.externalUrl.present ? data.externalUrl.value : this.externalUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContinuingEducationCourse(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('provider: $provider, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('durationHours: $durationHours, ')
          ..write('externalUrl: $externalUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, provider, description, category, durationHours, externalUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContinuingEducationCourse &&
          other.id == this.id &&
          other.title == this.title &&
          other.provider == this.provider &&
          other.description == this.description &&
          other.category == this.category &&
          other.durationHours == this.durationHours &&
          other.externalUrl == this.externalUrl);
}

class ContinuingEducationCoursesCompanion
    extends UpdateCompanion<ContinuingEducationCourse> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> provider;
  final Value<String?> description;
  final Value<String> category;
  final Value<int?> durationHours;
  final Value<String?> externalUrl;
  const ContinuingEducationCoursesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.provider = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.durationHours = const Value.absent(),
    this.externalUrl = const Value.absent(),
  });
  ContinuingEducationCoursesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String provider,
    this.description = const Value.absent(),
    required String category,
    this.durationHours = const Value.absent(),
    this.externalUrl = const Value.absent(),
  })  : title = Value(title),
        provider = Value(provider),
        category = Value(category);
  static Insertable<ContinuingEducationCourse> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? provider,
    Expression<String>? description,
    Expression<String>? category,
    Expression<int>? durationHours,
    Expression<String>? externalUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (provider != null) 'provider': provider,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (durationHours != null) 'duration_hours': durationHours,
      if (externalUrl != null) 'external_url': externalUrl,
    });
  }

  ContinuingEducationCoursesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? provider,
      Value<String?>? description,
      Value<String>? category,
      Value<int?>? durationHours,
      Value<String?>? externalUrl}) {
    return ContinuingEducationCoursesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      provider: provider ?? this.provider,
      description: description ?? this.description,
      category: category ?? this.category,
      durationHours: durationHours ?? this.durationHours,
      externalUrl: externalUrl ?? this.externalUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(provider.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (durationHours.present) {
      map['duration_hours'] = Variable<int>(durationHours.value);
    }
    if (externalUrl.present) {
      map['external_url'] = Variable<String>(externalUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContinuingEducationCoursesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('provider: $provider, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('durationHours: $durationHours, ')
          ..write('externalUrl: $externalUrl')
          ..write(')'))
        .toString();
  }
}

class $UserCourseEnrollmentsTable extends UserCourseEnrollments
    with TableInfo<$UserCourseEnrollmentsTable, UserCourseEnrollment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserCourseEnrollmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _courseIdMeta =
      const VerificationMeta('courseId');
  @override
  late final GeneratedColumn<int> courseId = GeneratedColumn<int>(
      'course_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _enrolledAtMeta =
      const VerificationMeta('enrolledAt');
  @override
  late final GeneratedColumn<DateTime> enrolledAt = GeneratedColumn<DateTime>(
      'enrolled_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, courseId, enrolledAt, completedAt, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_course_enrollments';
  @override
  VerificationContext validateIntegrity(
      Insertable<UserCourseEnrollment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('course_id')) {
      context.handle(_courseIdMeta,
          courseId.isAcceptableOrUnknown(data['course_id']!, _courseIdMeta));
    } else if (isInserting) {
      context.missing(_courseIdMeta);
    }
    if (data.containsKey('enrolled_at')) {
      context.handle(
          _enrolledAtMeta,
          enrolledAt.isAcceptableOrUnknown(
              data['enrolled_at']!, _enrolledAtMeta));
    } else if (isInserting) {
      context.missing(_enrolledAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserCourseEnrollment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserCourseEnrollment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      courseId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}course_id'])!,
      enrolledAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}enrolled_at'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $UserCourseEnrollmentsTable createAlias(String alias) {
    return $UserCourseEnrollmentsTable(attachedDatabase, alias);
  }
}

class UserCourseEnrollment extends DataClass
    implements Insertable<UserCourseEnrollment> {
  final int id;
  final int userId;
  final int courseId;
  final DateTime enrolledAt;
  final DateTime? completedAt;
  final String status;
  const UserCourseEnrollment(
      {required this.id,
      required this.userId,
      required this.courseId,
      required this.enrolledAt,
      this.completedAt,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['course_id'] = Variable<int>(courseId);
    map['enrolled_at'] = Variable<DateTime>(enrolledAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  UserCourseEnrollmentsCompanion toCompanion(bool nullToAbsent) {
    return UserCourseEnrollmentsCompanion(
      id: Value(id),
      userId: Value(userId),
      courseId: Value(courseId),
      enrolledAt: Value(enrolledAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      status: Value(status),
    );
  }

  factory UserCourseEnrollment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserCourseEnrollment(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      courseId: serializer.fromJson<int>(json['courseId']),
      enrolledAt: serializer.fromJson<DateTime>(json['enrolledAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'courseId': serializer.toJson<int>(courseId),
      'enrolledAt': serializer.toJson<DateTime>(enrolledAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'status': serializer.toJson<String>(status),
    };
  }

  UserCourseEnrollment copyWith(
          {int? id,
          int? userId,
          int? courseId,
          DateTime? enrolledAt,
          Value<DateTime?> completedAt = const Value.absent(),
          String? status}) =>
      UserCourseEnrollment(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        courseId: courseId ?? this.courseId,
        enrolledAt: enrolledAt ?? this.enrolledAt,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
        status: status ?? this.status,
      );
  UserCourseEnrollment copyWithCompanion(UserCourseEnrollmentsCompanion data) {
    return UserCourseEnrollment(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      courseId: data.courseId.present ? data.courseId.value : this.courseId,
      enrolledAt:
          data.enrolledAt.present ? data.enrolledAt.value : this.enrolledAt,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserCourseEnrollment(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('courseId: $courseId, ')
          ..write('enrolledAt: $enrolledAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, courseId, enrolledAt, completedAt, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserCourseEnrollment &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.courseId == this.courseId &&
          other.enrolledAt == this.enrolledAt &&
          other.completedAt == this.completedAt &&
          other.status == this.status);
}

class UserCourseEnrollmentsCompanion
    extends UpdateCompanion<UserCourseEnrollment> {
  final Value<int> id;
  final Value<int> userId;
  final Value<int> courseId;
  final Value<DateTime> enrolledAt;
  final Value<DateTime?> completedAt;
  final Value<String> status;
  const UserCourseEnrollmentsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.courseId = const Value.absent(),
    this.enrolledAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.status = const Value.absent(),
  });
  UserCourseEnrollmentsCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required int courseId,
    required DateTime enrolledAt,
    this.completedAt = const Value.absent(),
    required String status,
  })  : userId = Value(userId),
        courseId = Value(courseId),
        enrolledAt = Value(enrolledAt),
        status = Value(status);
  static Insertable<UserCourseEnrollment> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<int>? courseId,
    Expression<DateTime>? enrolledAt,
    Expression<DateTime>? completedAt,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (courseId != null) 'course_id': courseId,
      if (enrolledAt != null) 'enrolled_at': enrolledAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (status != null) 'status': status,
    });
  }

  UserCourseEnrollmentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<int>? courseId,
      Value<DateTime>? enrolledAt,
      Value<DateTime?>? completedAt,
      Value<String>? status}) {
    return UserCourseEnrollmentsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      courseId: courseId ?? this.courseId,
      enrolledAt: enrolledAt ?? this.enrolledAt,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (courseId.present) {
      map['course_id'] = Variable<int>(courseId.value);
    }
    if (enrolledAt.present) {
      map['enrolled_at'] = Variable<DateTime>(enrolledAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserCourseEnrollmentsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('courseId: $courseId, ')
          ..write('enrolledAt: $enrolledAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _expenseDateMeta =
      const VerificationMeta('expenseDate');
  @override
  late final GeneratedColumn<DateTime> expenseDate = GeneratedColumn<DateTime>(
      'expense_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _receiptPathMeta =
      const VerificationMeta('receiptPath');
  @override
  late final GeneratedColumn<String> receiptPath = GeneratedColumn<String>(
      'receipt_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _workOrderIdMeta =
      const VerificationMeta('workOrderId');
  @override
  late final GeneratedColumn<int> workOrderId = GeneratedColumn<int>(
      'work_order_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        expenseDate,
        category,
        amount,
        description,
        receiptPath,
        workOrderId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(Insertable<Expense> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('expense_date')) {
      context.handle(
          _expenseDateMeta,
          expenseDate.isAcceptableOrUnknown(
              data['expense_date']!, _expenseDateMeta));
    } else if (isInserting) {
      context.missing(_expenseDateMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('receipt_path')) {
      context.handle(
          _receiptPathMeta,
          receiptPath.isAcceptableOrUnknown(
              data['receipt_path']!, _receiptPathMeta));
    }
    if (data.containsKey('work_order_id')) {
      context.handle(
          _workOrderIdMeta,
          workOrderId.isAcceptableOrUnknown(
              data['work_order_id']!, _workOrderIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      expenseDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}expense_date'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      receiptPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}receipt_path']),
      workOrderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}work_order_id']),
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final int id;
  final int userId;
  final DateTime expenseDate;
  final String category;
  final double amount;
  final String? description;
  final String? receiptPath;
  final int? workOrderId;
  const Expense(
      {required this.id,
      required this.userId,
      required this.expenseDate,
      required this.category,
      required this.amount,
      this.description,
      this.receiptPath,
      this.workOrderId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['expense_date'] = Variable<DateTime>(expenseDate);
    map['category'] = Variable<String>(category);
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || receiptPath != null) {
      map['receipt_path'] = Variable<String>(receiptPath);
    }
    if (!nullToAbsent || workOrderId != null) {
      map['work_order_id'] = Variable<int>(workOrderId);
    }
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      userId: Value(userId),
      expenseDate: Value(expenseDate),
      category: Value(category),
      amount: Value(amount),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      receiptPath: receiptPath == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptPath),
      workOrderId: workOrderId == null && nullToAbsent
          ? const Value.absent()
          : Value(workOrderId),
    );
  }

  factory Expense.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      expenseDate: serializer.fromJson<DateTime>(json['expenseDate']),
      category: serializer.fromJson<String>(json['category']),
      amount: serializer.fromJson<double>(json['amount']),
      description: serializer.fromJson<String?>(json['description']),
      receiptPath: serializer.fromJson<String?>(json['receiptPath']),
      workOrderId: serializer.fromJson<int?>(json['workOrderId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'expenseDate': serializer.toJson<DateTime>(expenseDate),
      'category': serializer.toJson<String>(category),
      'amount': serializer.toJson<double>(amount),
      'description': serializer.toJson<String?>(description),
      'receiptPath': serializer.toJson<String?>(receiptPath),
      'workOrderId': serializer.toJson<int?>(workOrderId),
    };
  }

  Expense copyWith(
          {int? id,
          int? userId,
          DateTime? expenseDate,
          String? category,
          double? amount,
          Value<String?> description = const Value.absent(),
          Value<String?> receiptPath = const Value.absent(),
          Value<int?> workOrderId = const Value.absent()}) =>
      Expense(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        expenseDate: expenseDate ?? this.expenseDate,
        category: category ?? this.category,
        amount: amount ?? this.amount,
        description: description.present ? description.value : this.description,
        receiptPath: receiptPath.present ? receiptPath.value : this.receiptPath,
        workOrderId: workOrderId.present ? workOrderId.value : this.workOrderId,
      );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      expenseDate:
          data.expenseDate.present ? data.expenseDate.value : this.expenseDate,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      description:
          data.description.present ? data.description.value : this.description,
      receiptPath:
          data.receiptPath.present ? data.receiptPath.value : this.receiptPath,
      workOrderId:
          data.workOrderId.present ? data.workOrderId.value : this.workOrderId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('expenseDate: $expenseDate, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('receiptPath: $receiptPath, ')
          ..write('workOrderId: $workOrderId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, expenseDate, category, amount,
      description, receiptPath, workOrderId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.expenseDate == this.expenseDate &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.description == this.description &&
          other.receiptPath == this.receiptPath &&
          other.workOrderId == this.workOrderId);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<int> id;
  final Value<int> userId;
  final Value<DateTime> expenseDate;
  final Value<String> category;
  final Value<double> amount;
  final Value<String?> description;
  final Value<String?> receiptPath;
  final Value<int?> workOrderId;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.expenseDate = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.description = const Value.absent(),
    this.receiptPath = const Value.absent(),
    this.workOrderId = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required DateTime expenseDate,
    required String category,
    required double amount,
    this.description = const Value.absent(),
    this.receiptPath = const Value.absent(),
    this.workOrderId = const Value.absent(),
  })  : userId = Value(userId),
        expenseDate = Value(expenseDate),
        category = Value(category),
        amount = Value(amount);
  static Insertable<Expense> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<DateTime>? expenseDate,
    Expression<String>? category,
    Expression<double>? amount,
    Expression<String>? description,
    Expression<String>? receiptPath,
    Expression<int>? workOrderId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (expenseDate != null) 'expense_date': expenseDate,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (description != null) 'description': description,
      if (receiptPath != null) 'receipt_path': receiptPath,
      if (workOrderId != null) 'work_order_id': workOrderId,
    });
  }

  ExpensesCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<DateTime>? expenseDate,
      Value<String>? category,
      Value<double>? amount,
      Value<String?>? description,
      Value<String?>? receiptPath,
      Value<int?>? workOrderId}) {
    return ExpensesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      expenseDate: expenseDate ?? this.expenseDate,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      receiptPath: receiptPath ?? this.receiptPath,
      workOrderId: workOrderId ?? this.workOrderId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (expenseDate.present) {
      map['expense_date'] = Variable<DateTime>(expenseDate.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (receiptPath.present) {
      map['receipt_path'] = Variable<String>(receiptPath.value);
    }
    if (workOrderId.present) {
      map['work_order_id'] = Variable<int>(workOrderId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('expenseDate: $expenseDate, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('description: $description, ')
          ..write('receiptPath: $receiptPath, ')
          ..write('workOrderId: $workOrderId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClientsTable clients = $ClientsTable(this);
  late final $SitesTable sites = $SitesTable(this);
  late final $StartingPointsTable startingPoints = $StartingPointsTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $WeatherSnapshotTable weatherSnapshot =
      $WeatherSnapshotTable(this);
  late final $TrafficSnapshotTable trafficSnapshot =
      $TrafficSnapshotTable(this);
  late final $WorkCallsTable workCalls = $WorkCallsTable(this);
  late final $IndustryBriefingTable industryBriefing =
      $IndustryBriefingTable(this);
  late final $CompanyAnnouncementsTable companyAnnouncements =
      $CompanyAnnouncementsTable(this);
  late final $WorkOrdersTable workOrders = $WorkOrdersTable(this);
  late final $AppointmentsTable appointments = $AppointmentsTable(this);
  late final $EquipmentTable equipment = $EquipmentTable(this);
  late final $WorkOrderEquipmentTable workOrderEquipment =
      $WorkOrderEquipmentTable(this);
  late final $WorkPerformedTable workPerformed = $WorkPerformedTable(this);
  late final $PartsUsedTable partsUsed = $PartsUsedTable(this);
  late final $NotesTable notes = $NotesTable(this);
  late final $DocumentsTable documents = $DocumentsTable(this);
  late final $KnowledgeEntriesTable knowledgeEntries =
      $KnowledgeEntriesTable(this);
  late final $KnowledgeCategoriesTable knowledgeCategories =
      $KnowledgeCategoriesTable(this);
  late final $KnowledgeTagsTable knowledgeTags = $KnowledgeTagsTable(this);
  late final $EntryTagsTable entryTags = $EntryTagsTable(this);
  late final $EntryMetadataTable entryMetadata = $EntryMetadataTable(this);
  late final $KnowledgeAttachmentsTable knowledgeAttachments =
      $KnowledgeAttachmentsTable(this);
  late final $KnowledgeHistoryTable knowledgeHistory =
      $KnowledgeHistoryTable(this);
  late final $KnowledgeRelationsTable knowledgeRelations =
      $KnowledgeRelationsTable(this);
  late final $MachineProfilesTable machineProfiles =
      $MachineProfilesTable(this);
  late final $ContinuingEducationCoursesTable continuingEducationCourses =
      $ContinuingEducationCoursesTable(this);
  late final $UserCourseEnrollmentsTable userCourseEnrollments =
      $UserCourseEnrollmentsTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        clients,
        sites,
        startingPoints,
        users,
        weatherSnapshot,
        trafficSnapshot,
        workCalls,
        industryBriefing,
        companyAnnouncements,
        workOrders,
        appointments,
        equipment,
        workOrderEquipment,
        workPerformed,
        partsUsed,
        notes,
        documents,
        knowledgeEntries,
        knowledgeCategories,
        knowledgeTags,
        entryTags,
        entryMetadata,
        knowledgeAttachments,
        knowledgeHistory,
        knowledgeRelations,
        machineProfiles,
        continuingEducationCourses,
        userCourseEnrollments,
        expenses
      ];
}

typedef $$ClientsTableCreateCompanionBuilder = ClientsCompanion Function({
  Value<int> id,
  required String name,
  required String themeColor,
});
typedef $$ClientsTableUpdateCompanionBuilder = ClientsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> themeColor,
});

final class $$ClientsTableReferences
    extends BaseReferences<_$AppDatabase, $ClientsTable, Client> {
  $$ClientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SitesTable, List<Site>> _sitesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.sites,
          aliasName: $_aliasNameGenerator(db.clients.id, db.sites.clientId));

  $$SitesTableProcessedTableManager get sitesRefs {
    final manager = $$SitesTableTableManager($_db, $_db.sites)
        .filter((f) => f.clientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sitesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ClientsTableFilterComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get themeColor => $composableBuilder(
      column: $table.themeColor, builder: (column) => ColumnFilters(column));

  Expression<bool> sitesRefs(
      Expression<bool> Function($$SitesTableFilterComposer f) f) {
    final $$SitesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sites,
        getReferencedColumn: (t) => t.clientId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SitesTableFilterComposer(
              $db: $db,
              $table: $db.sites,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ClientsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get themeColor => $composableBuilder(
      column: $table.themeColor, builder: (column) => ColumnOrderings(column));
}

class $$ClientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get themeColor => $composableBuilder(
      column: $table.themeColor, builder: (column) => column);

  Expression<T> sitesRefs<T extends Object>(
      Expression<T> Function($$SitesTableAnnotationComposer a) f) {
    final $$SitesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sites,
        getReferencedColumn: (t) => t.clientId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SitesTableAnnotationComposer(
              $db: $db,
              $table: $db.sites,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ClientsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClientsTable,
    Client,
    $$ClientsTableFilterComposer,
    $$ClientsTableOrderingComposer,
    $$ClientsTableAnnotationComposer,
    $$ClientsTableCreateCompanionBuilder,
    $$ClientsTableUpdateCompanionBuilder,
    (Client, $$ClientsTableReferences),
    Client,
    PrefetchHooks Function({bool sitesRefs})> {
  $$ClientsTableTableManager(_$AppDatabase db, $ClientsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> themeColor = const Value.absent(),
          }) =>
              ClientsCompanion(
            id: id,
            name: name,
            themeColor: themeColor,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String themeColor,
          }) =>
              ClientsCompanion.insert(
            id: id,
            name: name,
            themeColor: themeColor,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ClientsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({sitesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (sitesRefs) db.sites],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sitesRefs)
                    await $_getPrefetchedData<Client, $ClientsTable, Site>(
                        currentTable: table,
                        referencedTable:
                            $$ClientsTableReferences._sitesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClientsTableReferences(db, table, p0).sitesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.clientId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ClientsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ClientsTable,
    Client,
    $$ClientsTableFilterComposer,
    $$ClientsTableOrderingComposer,
    $$ClientsTableAnnotationComposer,
    $$ClientsTableCreateCompanionBuilder,
    $$ClientsTableUpdateCompanionBuilder,
    (Client, $$ClientsTableReferences),
    Client,
    PrefetchHooks Function({bool sitesRefs})>;
typedef $$SitesTableCreateCompanionBuilder = SitesCompanion Function({
  Value<int> id,
  required int clientId,
  required String branchName,
  required String address,
  required double latitude,
  required double longitude,
  required String region,
});
typedef $$SitesTableUpdateCompanionBuilder = SitesCompanion Function({
  Value<int> id,
  Value<int> clientId,
  Value<String> branchName,
  Value<String> address,
  Value<double> latitude,
  Value<double> longitude,
  Value<String> region,
});

final class $$SitesTableReferences
    extends BaseReferences<_$AppDatabase, $SitesTable, Site> {
  $$SitesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTable _clientIdTable(_$AppDatabase db) => db.clients
      .createAlias($_aliasNameGenerator(db.sites.clientId, db.clients.id));

  $$ClientsTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<int>('client_id')!;

    final manager = $$ClientsTableTableManager($_db, $_db.clients)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SitesTableFilterComposer extends Composer<_$AppDatabase, $SitesTable> {
  $$SitesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get branchName => $composableBuilder(
      column: $table.branchName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnFilters(column));

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableFilterComposer(
              $db: $db,
              $table: $db.clients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SitesTableOrderingComposer
    extends Composer<_$AppDatabase, $SitesTable> {
  $$SitesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get branchName => $composableBuilder(
      column: $table.branchName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnOrderings(column));

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableOrderingComposer(
              $db: $db,
              $table: $db.clients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SitesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SitesTable> {
  $$SitesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get branchName => $composableBuilder(
      column: $table.branchName, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $db.clients,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientsTableAnnotationComposer(
              $db: $db,
              $table: $db.clients,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SitesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SitesTable,
    Site,
    $$SitesTableFilterComposer,
    $$SitesTableOrderingComposer,
    $$SitesTableAnnotationComposer,
    $$SitesTableCreateCompanionBuilder,
    $$SitesTableUpdateCompanionBuilder,
    (Site, $$SitesTableReferences),
    Site,
    PrefetchHooks Function({bool clientId})> {
  $$SitesTableTableManager(_$AppDatabase db, $SitesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SitesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SitesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SitesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> clientId = const Value.absent(),
            Value<String> branchName = const Value.absent(),
            Value<String> address = const Value.absent(),
            Value<double> latitude = const Value.absent(),
            Value<double> longitude = const Value.absent(),
            Value<String> region = const Value.absent(),
          }) =>
              SitesCompanion(
            id: id,
            clientId: clientId,
            branchName: branchName,
            address: address,
            latitude: latitude,
            longitude: longitude,
            region: region,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int clientId,
            required String branchName,
            required String address,
            required double latitude,
            required double longitude,
            required String region,
          }) =>
              SitesCompanion.insert(
            id: id,
            clientId: clientId,
            branchName: branchName,
            address: address,
            latitude: latitude,
            longitude: longitude,
            region: region,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$SitesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({clientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (clientId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.clientId,
                    referencedTable: $$SitesTableReferences._clientIdTable(db),
                    referencedColumn:
                        $$SitesTableReferences._clientIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SitesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SitesTable,
    Site,
    $$SitesTableFilterComposer,
    $$SitesTableOrderingComposer,
    $$SitesTableAnnotationComposer,
    $$SitesTableCreateCompanionBuilder,
    $$SitesTableUpdateCompanionBuilder,
    (Site, $$SitesTableReferences),
    Site,
    PrefetchHooks Function({bool clientId})>;
typedef $$StartingPointsTableCreateCompanionBuilder = StartingPointsCompanion
    Function({
  Value<int> id,
  required String name,
  required double latitude,
  required double longitude,
});
typedef $$StartingPointsTableUpdateCompanionBuilder = StartingPointsCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<double> latitude,
  Value<double> longitude,
});

class $$StartingPointsTableFilterComposer
    extends Composer<_$AppDatabase, $StartingPointsTable> {
  $$StartingPointsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));
}

class $$StartingPointsTableOrderingComposer
    extends Composer<_$AppDatabase, $StartingPointsTable> {
  $$StartingPointsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));
}

class $$StartingPointsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StartingPointsTable> {
  $$StartingPointsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);
}

class $$StartingPointsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StartingPointsTable,
    StartingPoint,
    $$StartingPointsTableFilterComposer,
    $$StartingPointsTableOrderingComposer,
    $$StartingPointsTableAnnotationComposer,
    $$StartingPointsTableCreateCompanionBuilder,
    $$StartingPointsTableUpdateCompanionBuilder,
    (
      StartingPoint,
      BaseReferences<_$AppDatabase, $StartingPointsTable, StartingPoint>
    ),
    StartingPoint,
    PrefetchHooks Function()> {
  $$StartingPointsTableTableManager(
      _$AppDatabase db, $StartingPointsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StartingPointsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StartingPointsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StartingPointsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<double> latitude = const Value.absent(),
            Value<double> longitude = const Value.absent(),
          }) =>
              StartingPointsCompanion(
            id: id,
            name: name,
            latitude: latitude,
            longitude: longitude,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required double latitude,
            required double longitude,
          }) =>
              StartingPointsCompanion.insert(
            id: id,
            name: name,
            latitude: latitude,
            longitude: longitude,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$StartingPointsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StartingPointsTable,
    StartingPoint,
    $$StartingPointsTableFilterComposer,
    $$StartingPointsTableOrderingComposer,
    $$StartingPointsTableAnnotationComposer,
    $$StartingPointsTableCreateCompanionBuilder,
    $$StartingPointsTableUpdateCompanionBuilder,
    (
      StartingPoint,
      BaseReferences<_$AppDatabase, $StartingPointsTable, StartingPoint>
    ),
    StartingPoint,
    PrefetchHooks Function()>;
typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String username,
  required String fullName,
  required String email,
  required String role,
  Value<String> passwordHash,
  Value<String> passwordSalt,
  Value<String?> pin,
  Value<DateTime?> dateOfBirth,
  Value<String?> location,
  Value<String?> phoneNumber,
  Value<String?> bio,
  Value<DateTime> createdAt,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> username,
  Value<String> fullName,
  Value<String> email,
  Value<String> role,
  Value<String> passwordHash,
  Value<String> passwordSalt,
  Value<String?> pin,
  Value<DateTime?> dateOfBirth,
  Value<String?> location,
  Value<String?> phoneNumber,
  Value<String?> bio,
  Value<DateTime> createdAt,
});

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get passwordSalt => $composableBuilder(
      column: $table.passwordSalt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pin => $composableBuilder(
      column: $table.pin, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bio => $composableBuilder(
      column: $table.bio, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get passwordSalt => $composableBuilder(
      column: $table.passwordSalt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pin => $composableBuilder(
      column: $table.pin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bio => $composableBuilder(
      column: $table.bio, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => column);

  GeneratedColumn<String> get passwordSalt => $composableBuilder(
      column: $table.passwordSalt, builder: (column) => column);

  GeneratedColumn<String> get pin =>
      $composableBuilder(column: $table.pin, builder: (column) => column);

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
      column: $table.dateOfBirth, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => column);

  GeneratedColumn<String> get bio =>
      $composableBuilder(column: $table.bio, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
    User,
    PrefetchHooks Function()> {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String> fullName = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String> passwordHash = const Value.absent(),
            Value<String> passwordSalt = const Value.absent(),
            Value<String?> pin = const Value.absent(),
            Value<DateTime?> dateOfBirth = const Value.absent(),
            Value<String?> location = const Value.absent(),
            Value<String?> phoneNumber = const Value.absent(),
            Value<String?> bio = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            username: username,
            fullName: fullName,
            email: email,
            role: role,
            passwordHash: passwordHash,
            passwordSalt: passwordSalt,
            pin: pin,
            dateOfBirth: dateOfBirth,
            location: location,
            phoneNumber: phoneNumber,
            bio: bio,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String username,
            required String fullName,
            required String email,
            required String role,
            Value<String> passwordHash = const Value.absent(),
            Value<String> passwordSalt = const Value.absent(),
            Value<String?> pin = const Value.absent(),
            Value<DateTime?> dateOfBirth = const Value.absent(),
            Value<String?> location = const Value.absent(),
            Value<String?> phoneNumber = const Value.absent(),
            Value<String?> bio = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            username: username,
            fullName: fullName,
            email: email,
            role: role,
            passwordHash: passwordHash,
            passwordSalt: passwordSalt,
            pin: pin,
            dateOfBirth: dateOfBirth,
            location: location,
            phoneNumber: phoneNumber,
            bio: bio,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
    User,
    PrefetchHooks Function()>;
typedef $$WeatherSnapshotTableCreateCompanionBuilder = WeatherSnapshotCompanion
    Function({
  Value<int> id,
  required String region,
  required int temperature,
  required String condition,
  required DateTime fetchedAt,
  required String source,
  Value<String?> zipCode,
});
typedef $$WeatherSnapshotTableUpdateCompanionBuilder = WeatherSnapshotCompanion
    Function({
  Value<int> id,
  Value<String> region,
  Value<int> temperature,
  Value<String> condition,
  Value<DateTime> fetchedAt,
  Value<String> source,
  Value<String?> zipCode,
});

class $$WeatherSnapshotTableFilterComposer
    extends Composer<_$AppDatabase, $WeatherSnapshotTable> {
  $$WeatherSnapshotTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get temperature => $composableBuilder(
      column: $table.temperature, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get condition => $composableBuilder(
      column: $table.condition, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
      column: $table.fetchedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get zipCode => $composableBuilder(
      column: $table.zipCode, builder: (column) => ColumnFilters(column));
}

class $$WeatherSnapshotTableOrderingComposer
    extends Composer<_$AppDatabase, $WeatherSnapshotTable> {
  $$WeatherSnapshotTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get temperature => $composableBuilder(
      column: $table.temperature, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get condition => $composableBuilder(
      column: $table.condition, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
      column: $table.fetchedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get zipCode => $composableBuilder(
      column: $table.zipCode, builder: (column) => ColumnOrderings(column));
}

class $$WeatherSnapshotTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeatherSnapshotTable> {
  $$WeatherSnapshotTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<int> get temperature => $composableBuilder(
      column: $table.temperature, builder: (column) => column);

  GeneratedColumn<String> get condition =>
      $composableBuilder(column: $table.condition, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get zipCode =>
      $composableBuilder(column: $table.zipCode, builder: (column) => column);
}

class $$WeatherSnapshotTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WeatherSnapshotTable,
    WeatherSnapshotData,
    $$WeatherSnapshotTableFilterComposer,
    $$WeatherSnapshotTableOrderingComposer,
    $$WeatherSnapshotTableAnnotationComposer,
    $$WeatherSnapshotTableCreateCompanionBuilder,
    $$WeatherSnapshotTableUpdateCompanionBuilder,
    (
      WeatherSnapshotData,
      BaseReferences<_$AppDatabase, $WeatherSnapshotTable, WeatherSnapshotData>
    ),
    WeatherSnapshotData,
    PrefetchHooks Function()> {
  $$WeatherSnapshotTableTableManager(
      _$AppDatabase db, $WeatherSnapshotTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeatherSnapshotTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeatherSnapshotTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeatherSnapshotTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> region = const Value.absent(),
            Value<int> temperature = const Value.absent(),
            Value<String> condition = const Value.absent(),
            Value<DateTime> fetchedAt = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String?> zipCode = const Value.absent(),
          }) =>
              WeatherSnapshotCompanion(
            id: id,
            region: region,
            temperature: temperature,
            condition: condition,
            fetchedAt: fetchedAt,
            source: source,
            zipCode: zipCode,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String region,
            required int temperature,
            required String condition,
            required DateTime fetchedAt,
            required String source,
            Value<String?> zipCode = const Value.absent(),
          }) =>
              WeatherSnapshotCompanion.insert(
            id: id,
            region: region,
            temperature: temperature,
            condition: condition,
            fetchedAt: fetchedAt,
            source: source,
            zipCode: zipCode,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WeatherSnapshotTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WeatherSnapshotTable,
    WeatherSnapshotData,
    $$WeatherSnapshotTableFilterComposer,
    $$WeatherSnapshotTableOrderingComposer,
    $$WeatherSnapshotTableAnnotationComposer,
    $$WeatherSnapshotTableCreateCompanionBuilder,
    $$WeatherSnapshotTableUpdateCompanionBuilder,
    (
      WeatherSnapshotData,
      BaseReferences<_$AppDatabase, $WeatherSnapshotTable, WeatherSnapshotData>
    ),
    WeatherSnapshotData,
    PrefetchHooks Function()>;
typedef $$TrafficSnapshotTableCreateCompanionBuilder = TrafficSnapshotCompanion
    Function({
  Value<int> id,
  required String routeLabel,
  required int etaMinutes,
  required String conditionLabel,
  required DateTime fetchedAt,
  required String source,
});
typedef $$TrafficSnapshotTableUpdateCompanionBuilder = TrafficSnapshotCompanion
    Function({
  Value<int> id,
  Value<String> routeLabel,
  Value<int> etaMinutes,
  Value<String> conditionLabel,
  Value<DateTime> fetchedAt,
  Value<String> source,
});

class $$TrafficSnapshotTableFilterComposer
    extends Composer<_$AppDatabase, $TrafficSnapshotTable> {
  $$TrafficSnapshotTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get routeLabel => $composableBuilder(
      column: $table.routeLabel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get etaMinutes => $composableBuilder(
      column: $table.etaMinutes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get conditionLabel => $composableBuilder(
      column: $table.conditionLabel,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
      column: $table.fetchedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));
}

class $$TrafficSnapshotTableOrderingComposer
    extends Composer<_$AppDatabase, $TrafficSnapshotTable> {
  $$TrafficSnapshotTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get routeLabel => $composableBuilder(
      column: $table.routeLabel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get etaMinutes => $composableBuilder(
      column: $table.etaMinutes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get conditionLabel => $composableBuilder(
      column: $table.conditionLabel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
      column: $table.fetchedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));
}

class $$TrafficSnapshotTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrafficSnapshotTable> {
  $$TrafficSnapshotTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get routeLabel => $composableBuilder(
      column: $table.routeLabel, builder: (column) => column);

  GeneratedColumn<int> get etaMinutes => $composableBuilder(
      column: $table.etaMinutes, builder: (column) => column);

  GeneratedColumn<String> get conditionLabel => $composableBuilder(
      column: $table.conditionLabel, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);
}

class $$TrafficSnapshotTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TrafficSnapshotTable,
    TrafficSnapshotData,
    $$TrafficSnapshotTableFilterComposer,
    $$TrafficSnapshotTableOrderingComposer,
    $$TrafficSnapshotTableAnnotationComposer,
    $$TrafficSnapshotTableCreateCompanionBuilder,
    $$TrafficSnapshotTableUpdateCompanionBuilder,
    (
      TrafficSnapshotData,
      BaseReferences<_$AppDatabase, $TrafficSnapshotTable, TrafficSnapshotData>
    ),
    TrafficSnapshotData,
    PrefetchHooks Function()> {
  $$TrafficSnapshotTableTableManager(
      _$AppDatabase db, $TrafficSnapshotTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrafficSnapshotTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrafficSnapshotTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrafficSnapshotTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> routeLabel = const Value.absent(),
            Value<int> etaMinutes = const Value.absent(),
            Value<String> conditionLabel = const Value.absent(),
            Value<DateTime> fetchedAt = const Value.absent(),
            Value<String> source = const Value.absent(),
          }) =>
              TrafficSnapshotCompanion(
            id: id,
            routeLabel: routeLabel,
            etaMinutes: etaMinutes,
            conditionLabel: conditionLabel,
            fetchedAt: fetchedAt,
            source: source,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String routeLabel,
            required int etaMinutes,
            required String conditionLabel,
            required DateTime fetchedAt,
            required String source,
          }) =>
              TrafficSnapshotCompanion.insert(
            id: id,
            routeLabel: routeLabel,
            etaMinutes: etaMinutes,
            conditionLabel: conditionLabel,
            fetchedAt: fetchedAt,
            source: source,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TrafficSnapshotTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TrafficSnapshotTable,
    TrafficSnapshotData,
    $$TrafficSnapshotTableFilterComposer,
    $$TrafficSnapshotTableOrderingComposer,
    $$TrafficSnapshotTableAnnotationComposer,
    $$TrafficSnapshotTableCreateCompanionBuilder,
    $$TrafficSnapshotTableUpdateCompanionBuilder,
    (
      TrafficSnapshotData,
      BaseReferences<_$AppDatabase, $TrafficSnapshotTable, TrafficSnapshotData>
    ),
    TrafficSnapshotData,
    PrefetchHooks Function()>;
typedef $$WorkCallsTableCreateCompanionBuilder = WorkCallsCompanion Function({
  Value<int> id,
  required String status,
  Value<DateTime?> scheduledAt,
  Value<DateTime?> completedAt,
  Value<String?> workOrderNumber,
});
typedef $$WorkCallsTableUpdateCompanionBuilder = WorkCallsCompanion Function({
  Value<int> id,
  Value<String> status,
  Value<DateTime?> scheduledAt,
  Value<DateTime?> completedAt,
  Value<String?> workOrderNumber,
});

class $$WorkCallsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkCallsTable> {
  $$WorkCallsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get scheduledAt => $composableBuilder(
      column: $table.scheduledAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workOrderNumber => $composableBuilder(
      column: $table.workOrderNumber,
      builder: (column) => ColumnFilters(column));
}

class $$WorkCallsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkCallsTable> {
  $$WorkCallsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get scheduledAt => $composableBuilder(
      column: $table.scheduledAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workOrderNumber => $composableBuilder(
      column: $table.workOrderNumber,
      builder: (column) => ColumnOrderings(column));
}

class $$WorkCallsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkCallsTable> {
  $$WorkCallsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledAt => $composableBuilder(
      column: $table.scheduledAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  GeneratedColumn<String> get workOrderNumber => $composableBuilder(
      column: $table.workOrderNumber, builder: (column) => column);
}

class $$WorkCallsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkCallsTable,
    WorkCall,
    $$WorkCallsTableFilterComposer,
    $$WorkCallsTableOrderingComposer,
    $$WorkCallsTableAnnotationComposer,
    $$WorkCallsTableCreateCompanionBuilder,
    $$WorkCallsTableUpdateCompanionBuilder,
    (WorkCall, BaseReferences<_$AppDatabase, $WorkCallsTable, WorkCall>),
    WorkCall,
    PrefetchHooks Function()> {
  $$WorkCallsTableTableManager(_$AppDatabase db, $WorkCallsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkCallsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkCallsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkCallsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime?> scheduledAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<String?> workOrderNumber = const Value.absent(),
          }) =>
              WorkCallsCompanion(
            id: id,
            status: status,
            scheduledAt: scheduledAt,
            completedAt: completedAt,
            workOrderNumber: workOrderNumber,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String status,
            Value<DateTime?> scheduledAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<String?> workOrderNumber = const Value.absent(),
          }) =>
              WorkCallsCompanion.insert(
            id: id,
            status: status,
            scheduledAt: scheduledAt,
            completedAt: completedAt,
            workOrderNumber: workOrderNumber,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WorkCallsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkCallsTable,
    WorkCall,
    $$WorkCallsTableFilterComposer,
    $$WorkCallsTableOrderingComposer,
    $$WorkCallsTableAnnotationComposer,
    $$WorkCallsTableCreateCompanionBuilder,
    $$WorkCallsTableUpdateCompanionBuilder,
    (WorkCall, BaseReferences<_$AppDatabase, $WorkCallsTable, WorkCall>),
    WorkCall,
    PrefetchHooks Function()>;
typedef $$IndustryBriefingTableCreateCompanionBuilder
    = IndustryBriefingCompanion Function({
  Value<int> id,
  required String title,
  required String source,
  Value<String?> previewImage,
  required DateTime publishedAt,
  required DateTime fetchedAt,
});
typedef $$IndustryBriefingTableUpdateCompanionBuilder
    = IndustryBriefingCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> source,
  Value<String?> previewImage,
  Value<DateTime> publishedAt,
  Value<DateTime> fetchedAt,
});

class $$IndustryBriefingTableFilterComposer
    extends Composer<_$AppDatabase, $IndustryBriefingTable> {
  $$IndustryBriefingTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get previewImage => $composableBuilder(
      column: $table.previewImage, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
      column: $table.fetchedAt, builder: (column) => ColumnFilters(column));
}

class $$IndustryBriefingTableOrderingComposer
    extends Composer<_$AppDatabase, $IndustryBriefingTable> {
  $$IndustryBriefingTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get previewImage => $composableBuilder(
      column: $table.previewImage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
      column: $table.fetchedAt, builder: (column) => ColumnOrderings(column));
}

class $$IndustryBriefingTableAnnotationComposer
    extends Composer<_$AppDatabase, $IndustryBriefingTable> {
  $$IndustryBriefingTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get previewImage => $composableBuilder(
      column: $table.previewImage, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);
}

class $$IndustryBriefingTableTableManager extends RootTableManager<
    _$AppDatabase,
    $IndustryBriefingTable,
    IndustryBriefingData,
    $$IndustryBriefingTableFilterComposer,
    $$IndustryBriefingTableOrderingComposer,
    $$IndustryBriefingTableAnnotationComposer,
    $$IndustryBriefingTableCreateCompanionBuilder,
    $$IndustryBriefingTableUpdateCompanionBuilder,
    (
      IndustryBriefingData,
      BaseReferences<_$AppDatabase, $IndustryBriefingTable,
          IndustryBriefingData>
    ),
    IndustryBriefingData,
    PrefetchHooks Function()> {
  $$IndustryBriefingTableTableManager(
      _$AppDatabase db, $IndustryBriefingTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IndustryBriefingTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IndustryBriefingTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IndustryBriefingTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String?> previewImage = const Value.absent(),
            Value<DateTime> publishedAt = const Value.absent(),
            Value<DateTime> fetchedAt = const Value.absent(),
          }) =>
              IndustryBriefingCompanion(
            id: id,
            title: title,
            source: source,
            previewImage: previewImage,
            publishedAt: publishedAt,
            fetchedAt: fetchedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String source,
            Value<String?> previewImage = const Value.absent(),
            required DateTime publishedAt,
            required DateTime fetchedAt,
          }) =>
              IndustryBriefingCompanion.insert(
            id: id,
            title: title,
            source: source,
            previewImage: previewImage,
            publishedAt: publishedAt,
            fetchedAt: fetchedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$IndustryBriefingTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $IndustryBriefingTable,
    IndustryBriefingData,
    $$IndustryBriefingTableFilterComposer,
    $$IndustryBriefingTableOrderingComposer,
    $$IndustryBriefingTableAnnotationComposer,
    $$IndustryBriefingTableCreateCompanionBuilder,
    $$IndustryBriefingTableUpdateCompanionBuilder,
    (
      IndustryBriefingData,
      BaseReferences<_$AppDatabase, $IndustryBriefingTable,
          IndustryBriefingData>
    ),
    IndustryBriefingData,
    PrefetchHooks Function()>;
typedef $$CompanyAnnouncementsTableCreateCompanionBuilder
    = CompanyAnnouncementsCompanion Function({
  Value<int> id,
  required String category,
  required String title,
  required String body,
  Value<String?> actionLabel,
  Value<bool> active,
  required DateTime publishedAt,
  Value<bool> acknowledged,
  Value<DateTime?> acknowledgedAt,
});
typedef $$CompanyAnnouncementsTableUpdateCompanionBuilder
    = CompanyAnnouncementsCompanion Function({
  Value<int> id,
  Value<String> category,
  Value<String> title,
  Value<String> body,
  Value<String?> actionLabel,
  Value<bool> active,
  Value<DateTime> publishedAt,
  Value<bool> acknowledged,
  Value<DateTime?> acknowledgedAt,
});

class $$CompanyAnnouncementsTableFilterComposer
    extends Composer<_$AppDatabase, $CompanyAnnouncementsTable> {
  $$CompanyAnnouncementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get actionLabel => $composableBuilder(
      column: $table.actionLabel, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get acknowledged => $composableBuilder(
      column: $table.acknowledged, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get acknowledgedAt => $composableBuilder(
      column: $table.acknowledgedAt,
      builder: (column) => ColumnFilters(column));
}

class $$CompanyAnnouncementsTableOrderingComposer
    extends Composer<_$AppDatabase, $CompanyAnnouncementsTable> {
  $$CompanyAnnouncementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get actionLabel => $composableBuilder(
      column: $table.actionLabel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get acknowledged => $composableBuilder(
      column: $table.acknowledged,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get acknowledgedAt => $composableBuilder(
      column: $table.acknowledgedAt,
      builder: (column) => ColumnOrderings(column));
}

class $$CompanyAnnouncementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompanyAnnouncementsTable> {
  $$CompanyAnnouncementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get actionLabel => $composableBuilder(
      column: $table.actionLabel, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => column);

  GeneratedColumn<bool> get acknowledged => $composableBuilder(
      column: $table.acknowledged, builder: (column) => column);

  GeneratedColumn<DateTime> get acknowledgedAt => $composableBuilder(
      column: $table.acknowledgedAt, builder: (column) => column);
}

class $$CompanyAnnouncementsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CompanyAnnouncementsTable,
    CompanyAnnouncement,
    $$CompanyAnnouncementsTableFilterComposer,
    $$CompanyAnnouncementsTableOrderingComposer,
    $$CompanyAnnouncementsTableAnnotationComposer,
    $$CompanyAnnouncementsTableCreateCompanionBuilder,
    $$CompanyAnnouncementsTableUpdateCompanionBuilder,
    (
      CompanyAnnouncement,
      BaseReferences<_$AppDatabase, $CompanyAnnouncementsTable,
          CompanyAnnouncement>
    ),
    CompanyAnnouncement,
    PrefetchHooks Function()> {
  $$CompanyAnnouncementsTableTableManager(
      _$AppDatabase db, $CompanyAnnouncementsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompanyAnnouncementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompanyAnnouncementsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompanyAnnouncementsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> body = const Value.absent(),
            Value<String?> actionLabel = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> publishedAt = const Value.absent(),
            Value<bool> acknowledged = const Value.absent(),
            Value<DateTime?> acknowledgedAt = const Value.absent(),
          }) =>
              CompanyAnnouncementsCompanion(
            id: id,
            category: category,
            title: title,
            body: body,
            actionLabel: actionLabel,
            active: active,
            publishedAt: publishedAt,
            acknowledged: acknowledged,
            acknowledgedAt: acknowledgedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String category,
            required String title,
            required String body,
            Value<String?> actionLabel = const Value.absent(),
            Value<bool> active = const Value.absent(),
            required DateTime publishedAt,
            Value<bool> acknowledged = const Value.absent(),
            Value<DateTime?> acknowledgedAt = const Value.absent(),
          }) =>
              CompanyAnnouncementsCompanion.insert(
            id: id,
            category: category,
            title: title,
            body: body,
            actionLabel: actionLabel,
            active: active,
            publishedAt: publishedAt,
            acknowledged: acknowledged,
            acknowledgedAt: acknowledgedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CompanyAnnouncementsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $CompanyAnnouncementsTable,
        CompanyAnnouncement,
        $$CompanyAnnouncementsTableFilterComposer,
        $$CompanyAnnouncementsTableOrderingComposer,
        $$CompanyAnnouncementsTableAnnotationComposer,
        $$CompanyAnnouncementsTableCreateCompanionBuilder,
        $$CompanyAnnouncementsTableUpdateCompanionBuilder,
        (
          CompanyAnnouncement,
          BaseReferences<_$AppDatabase, $CompanyAnnouncementsTable,
              CompanyAnnouncement>
        ),
        CompanyAnnouncement,
        PrefetchHooks Function()>;
typedef $$WorkOrdersTableCreateCompanionBuilder = WorkOrdersCompanion Function({
  Value<int> id,
  required int siteId,
  required String status,
  Value<String?> priority,
  Value<String?> descriptionOfWork,
  Value<String?> internalNotes,
  required DateTime createdAt,
  Value<DateTime?> closedAt,
  Value<String?> createdBy,
  Value<String?> assignedTechnician,
});
typedef $$WorkOrdersTableUpdateCompanionBuilder = WorkOrdersCompanion Function({
  Value<int> id,
  Value<int> siteId,
  Value<String> status,
  Value<String?> priority,
  Value<String?> descriptionOfWork,
  Value<String?> internalNotes,
  Value<DateTime> createdAt,
  Value<DateTime?> closedAt,
  Value<String?> createdBy,
  Value<String?> assignedTechnician,
});

class $$WorkOrdersTableFilterComposer
    extends Composer<_$AppDatabase, $WorkOrdersTable> {
  $$WorkOrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get siteId => $composableBuilder(
      column: $table.siteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descriptionOfWork => $composableBuilder(
      column: $table.descriptionOfWork,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get internalNotes => $composableBuilder(
      column: $table.internalNotes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get closedAt => $composableBuilder(
      column: $table.closedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get assignedTechnician => $composableBuilder(
      column: $table.assignedTechnician,
      builder: (column) => ColumnFilters(column));
}

class $$WorkOrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkOrdersTable> {
  $$WorkOrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get siteId => $composableBuilder(
      column: $table.siteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descriptionOfWork => $composableBuilder(
      column: $table.descriptionOfWork,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get internalNotes => $composableBuilder(
      column: $table.internalNotes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get closedAt => $composableBuilder(
      column: $table.closedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get assignedTechnician => $composableBuilder(
      column: $table.assignedTechnician,
      builder: (column) => ColumnOrderings(column));
}

class $$WorkOrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkOrdersTable> {
  $$WorkOrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get siteId =>
      $composableBuilder(column: $table.siteId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get descriptionOfWork => $composableBuilder(
      column: $table.descriptionOfWork, builder: (column) => column);

  GeneratedColumn<String> get internalNotes => $composableBuilder(
      column: $table.internalNotes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get closedAt =>
      $composableBuilder(column: $table.closedAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get assignedTechnician => $composableBuilder(
      column: $table.assignedTechnician, builder: (column) => column);
}

class $$WorkOrdersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkOrdersTable,
    WorkOrder,
    $$WorkOrdersTableFilterComposer,
    $$WorkOrdersTableOrderingComposer,
    $$WorkOrdersTableAnnotationComposer,
    $$WorkOrdersTableCreateCompanionBuilder,
    $$WorkOrdersTableUpdateCompanionBuilder,
    (WorkOrder, BaseReferences<_$AppDatabase, $WorkOrdersTable, WorkOrder>),
    WorkOrder,
    PrefetchHooks Function()> {
  $$WorkOrdersTableTableManager(_$AppDatabase db, $WorkOrdersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkOrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> siteId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> priority = const Value.absent(),
            Value<String?> descriptionOfWork = const Value.absent(),
            Value<String?> internalNotes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> closedAt = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<String?> assignedTechnician = const Value.absent(),
          }) =>
              WorkOrdersCompanion(
            id: id,
            siteId: siteId,
            status: status,
            priority: priority,
            descriptionOfWork: descriptionOfWork,
            internalNotes: internalNotes,
            createdAt: createdAt,
            closedAt: closedAt,
            createdBy: createdBy,
            assignedTechnician: assignedTechnician,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int siteId,
            required String status,
            Value<String?> priority = const Value.absent(),
            Value<String?> descriptionOfWork = const Value.absent(),
            Value<String?> internalNotes = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> closedAt = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<String?> assignedTechnician = const Value.absent(),
          }) =>
              WorkOrdersCompanion.insert(
            id: id,
            siteId: siteId,
            status: status,
            priority: priority,
            descriptionOfWork: descriptionOfWork,
            internalNotes: internalNotes,
            createdAt: createdAt,
            closedAt: closedAt,
            createdBy: createdBy,
            assignedTechnician: assignedTechnician,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WorkOrdersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkOrdersTable,
    WorkOrder,
    $$WorkOrdersTableFilterComposer,
    $$WorkOrdersTableOrderingComposer,
    $$WorkOrdersTableAnnotationComposer,
    $$WorkOrdersTableCreateCompanionBuilder,
    $$WorkOrdersTableUpdateCompanionBuilder,
    (WorkOrder, BaseReferences<_$AppDatabase, $WorkOrdersTable, WorkOrder>),
    WorkOrder,
    PrefetchHooks Function()>;
typedef $$AppointmentsTableCreateCompanionBuilder = AppointmentsCompanion
    Function({
  Value<int> id,
  required int workOrderId,
  required DateTime scheduledStart,
  Value<int?> expectedDurationMinutes,
  Value<String?> technician,
});
typedef $$AppointmentsTableUpdateCompanionBuilder = AppointmentsCompanion
    Function({
  Value<int> id,
  Value<int> workOrderId,
  Value<DateTime> scheduledStart,
  Value<int?> expectedDurationMinutes,
  Value<String?> technician,
});

class $$AppointmentsTableFilterComposer
    extends Composer<_$AppDatabase, $AppointmentsTable> {
  $$AppointmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get workOrderId => $composableBuilder(
      column: $table.workOrderId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get scheduledStart => $composableBuilder(
      column: $table.scheduledStart,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get expectedDurationMinutes => $composableBuilder(
      column: $table.expectedDurationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get technician => $composableBuilder(
      column: $table.technician, builder: (column) => ColumnFilters(column));
}

class $$AppointmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppointmentsTable> {
  $$AppointmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get workOrderId => $composableBuilder(
      column: $table.workOrderId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get scheduledStart => $composableBuilder(
      column: $table.scheduledStart,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get expectedDurationMinutes => $composableBuilder(
      column: $table.expectedDurationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get technician => $composableBuilder(
      column: $table.technician, builder: (column) => ColumnOrderings(column));
}

class $$AppointmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppointmentsTable> {
  $$AppointmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get workOrderId => $composableBuilder(
      column: $table.workOrderId, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledStart => $composableBuilder(
      column: $table.scheduledStart, builder: (column) => column);

  GeneratedColumn<int> get expectedDurationMinutes => $composableBuilder(
      column: $table.expectedDurationMinutes, builder: (column) => column);

  GeneratedColumn<String> get technician => $composableBuilder(
      column: $table.technician, builder: (column) => column);
}

class $$AppointmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppointmentsTable,
    Appointment,
    $$AppointmentsTableFilterComposer,
    $$AppointmentsTableOrderingComposer,
    $$AppointmentsTableAnnotationComposer,
    $$AppointmentsTableCreateCompanionBuilder,
    $$AppointmentsTableUpdateCompanionBuilder,
    (
      Appointment,
      BaseReferences<_$AppDatabase, $AppointmentsTable, Appointment>
    ),
    Appointment,
    PrefetchHooks Function()> {
  $$AppointmentsTableTableManager(_$AppDatabase db, $AppointmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppointmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppointmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppointmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> workOrderId = const Value.absent(),
            Value<DateTime> scheduledStart = const Value.absent(),
            Value<int?> expectedDurationMinutes = const Value.absent(),
            Value<String?> technician = const Value.absent(),
          }) =>
              AppointmentsCompanion(
            id: id,
            workOrderId: workOrderId,
            scheduledStart: scheduledStart,
            expectedDurationMinutes: expectedDurationMinutes,
            technician: technician,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int workOrderId,
            required DateTime scheduledStart,
            Value<int?> expectedDurationMinutes = const Value.absent(),
            Value<String?> technician = const Value.absent(),
          }) =>
              AppointmentsCompanion.insert(
            id: id,
            workOrderId: workOrderId,
            scheduledStart: scheduledStart,
            expectedDurationMinutes: expectedDurationMinutes,
            technician: technician,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppointmentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppointmentsTable,
    Appointment,
    $$AppointmentsTableFilterComposer,
    $$AppointmentsTableOrderingComposer,
    $$AppointmentsTableAnnotationComposer,
    $$AppointmentsTableCreateCompanionBuilder,
    $$AppointmentsTableUpdateCompanionBuilder,
    (
      Appointment,
      BaseReferences<_$AppDatabase, $AppointmentsTable, Appointment>
    ),
    Appointment,
    PrefetchHooks Function()>;
typedef $$EquipmentTableCreateCompanionBuilder = EquipmentCompanion Function({
  Value<int> id,
  required int siteId,
  Value<int?> machineProfileId,
  required String equipmentType,
  Value<String?> manufacturer,
  Value<String?> model,
  Value<String?> serialNumber,
  Value<bool> underWarranty,
  Value<bool> underServiceContract,
  Value<String?> contractReference,
  Value<bool> active,
});
typedef $$EquipmentTableUpdateCompanionBuilder = EquipmentCompanion Function({
  Value<int> id,
  Value<int> siteId,
  Value<int?> machineProfileId,
  Value<String> equipmentType,
  Value<String?> manufacturer,
  Value<String?> model,
  Value<String?> serialNumber,
  Value<bool> underWarranty,
  Value<bool> underServiceContract,
  Value<String?> contractReference,
  Value<bool> active,
});

class $$EquipmentTableFilterComposer
    extends Composer<_$AppDatabase, $EquipmentTable> {
  $$EquipmentTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get siteId => $composableBuilder(
      column: $table.siteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get machineProfileId => $composableBuilder(
      column: $table.machineProfileId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get equipmentType => $composableBuilder(
      column: $table.equipmentType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get manufacturer => $composableBuilder(
      column: $table.manufacturer, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get serialNumber => $composableBuilder(
      column: $table.serialNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get underWarranty => $composableBuilder(
      column: $table.underWarranty, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get underServiceContract => $composableBuilder(
      column: $table.underServiceContract,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contractReference => $composableBuilder(
      column: $table.contractReference,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));
}

class $$EquipmentTableOrderingComposer
    extends Composer<_$AppDatabase, $EquipmentTable> {
  $$EquipmentTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get siteId => $composableBuilder(
      column: $table.siteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get machineProfileId => $composableBuilder(
      column: $table.machineProfileId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get equipmentType => $composableBuilder(
      column: $table.equipmentType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get manufacturer => $composableBuilder(
      column: $table.manufacturer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get serialNumber => $composableBuilder(
      column: $table.serialNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get underWarranty => $composableBuilder(
      column: $table.underWarranty,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get underServiceContract => $composableBuilder(
      column: $table.underServiceContract,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contractReference => $composableBuilder(
      column: $table.contractReference,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));
}

class $$EquipmentTableAnnotationComposer
    extends Composer<_$AppDatabase, $EquipmentTable> {
  $$EquipmentTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get siteId =>
      $composableBuilder(column: $table.siteId, builder: (column) => column);

  GeneratedColumn<int> get machineProfileId => $composableBuilder(
      column: $table.machineProfileId, builder: (column) => column);

  GeneratedColumn<String> get equipmentType => $composableBuilder(
      column: $table.equipmentType, builder: (column) => column);

  GeneratedColumn<String> get manufacturer => $composableBuilder(
      column: $table.manufacturer, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get serialNumber => $composableBuilder(
      column: $table.serialNumber, builder: (column) => column);

  GeneratedColumn<bool> get underWarranty => $composableBuilder(
      column: $table.underWarranty, builder: (column) => column);

  GeneratedColumn<bool> get underServiceContract => $composableBuilder(
      column: $table.underServiceContract, builder: (column) => column);

  GeneratedColumn<String> get contractReference => $composableBuilder(
      column: $table.contractReference, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);
}

class $$EquipmentTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EquipmentTable,
    EquipmentData,
    $$EquipmentTableFilterComposer,
    $$EquipmentTableOrderingComposer,
    $$EquipmentTableAnnotationComposer,
    $$EquipmentTableCreateCompanionBuilder,
    $$EquipmentTableUpdateCompanionBuilder,
    (
      EquipmentData,
      BaseReferences<_$AppDatabase, $EquipmentTable, EquipmentData>
    ),
    EquipmentData,
    PrefetchHooks Function()> {
  $$EquipmentTableTableManager(_$AppDatabase db, $EquipmentTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EquipmentTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EquipmentTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EquipmentTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> siteId = const Value.absent(),
            Value<int?> machineProfileId = const Value.absent(),
            Value<String> equipmentType = const Value.absent(),
            Value<String?> manufacturer = const Value.absent(),
            Value<String?> model = const Value.absent(),
            Value<String?> serialNumber = const Value.absent(),
            Value<bool> underWarranty = const Value.absent(),
            Value<bool> underServiceContract = const Value.absent(),
            Value<String?> contractReference = const Value.absent(),
            Value<bool> active = const Value.absent(),
          }) =>
              EquipmentCompanion(
            id: id,
            siteId: siteId,
            machineProfileId: machineProfileId,
            equipmentType: equipmentType,
            manufacturer: manufacturer,
            model: model,
            serialNumber: serialNumber,
            underWarranty: underWarranty,
            underServiceContract: underServiceContract,
            contractReference: contractReference,
            active: active,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int siteId,
            Value<int?> machineProfileId = const Value.absent(),
            required String equipmentType,
            Value<String?> manufacturer = const Value.absent(),
            Value<String?> model = const Value.absent(),
            Value<String?> serialNumber = const Value.absent(),
            Value<bool> underWarranty = const Value.absent(),
            Value<bool> underServiceContract = const Value.absent(),
            Value<String?> contractReference = const Value.absent(),
            Value<bool> active = const Value.absent(),
          }) =>
              EquipmentCompanion.insert(
            id: id,
            siteId: siteId,
            machineProfileId: machineProfileId,
            equipmentType: equipmentType,
            manufacturer: manufacturer,
            model: model,
            serialNumber: serialNumber,
            underWarranty: underWarranty,
            underServiceContract: underServiceContract,
            contractReference: contractReference,
            active: active,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EquipmentTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EquipmentTable,
    EquipmentData,
    $$EquipmentTableFilterComposer,
    $$EquipmentTableOrderingComposer,
    $$EquipmentTableAnnotationComposer,
    $$EquipmentTableCreateCompanionBuilder,
    $$EquipmentTableUpdateCompanionBuilder,
    (
      EquipmentData,
      BaseReferences<_$AppDatabase, $EquipmentTable, EquipmentData>
    ),
    EquipmentData,
    PrefetchHooks Function()>;
typedef $$WorkOrderEquipmentTableCreateCompanionBuilder
    = WorkOrderEquipmentCompanion Function({
  required int workOrderId,
  required int equipmentId,
  Value<int> rowid,
});
typedef $$WorkOrderEquipmentTableUpdateCompanionBuilder
    = WorkOrderEquipmentCompanion Function({
  Value<int> workOrderId,
  Value<int> equipmentId,
  Value<int> rowid,
});

class $$WorkOrderEquipmentTableFilterComposer
    extends Composer<_$AppDatabase, $WorkOrderEquipmentTable> {
  $$WorkOrderEquipmentTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get workOrderId => $composableBuilder(
      column: $table.workOrderId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get equipmentId => $composableBuilder(
      column: $table.equipmentId, builder: (column) => ColumnFilters(column));
}

class $$WorkOrderEquipmentTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkOrderEquipmentTable> {
  $$WorkOrderEquipmentTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get workOrderId => $composableBuilder(
      column: $table.workOrderId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get equipmentId => $composableBuilder(
      column: $table.equipmentId, builder: (column) => ColumnOrderings(column));
}

class $$WorkOrderEquipmentTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkOrderEquipmentTable> {
  $$WorkOrderEquipmentTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get workOrderId => $composableBuilder(
      column: $table.workOrderId, builder: (column) => column);

  GeneratedColumn<int> get equipmentId => $composableBuilder(
      column: $table.equipmentId, builder: (column) => column);
}

class $$WorkOrderEquipmentTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkOrderEquipmentTable,
    WorkOrderEquipmentData,
    $$WorkOrderEquipmentTableFilterComposer,
    $$WorkOrderEquipmentTableOrderingComposer,
    $$WorkOrderEquipmentTableAnnotationComposer,
    $$WorkOrderEquipmentTableCreateCompanionBuilder,
    $$WorkOrderEquipmentTableUpdateCompanionBuilder,
    (
      WorkOrderEquipmentData,
      BaseReferences<_$AppDatabase, $WorkOrderEquipmentTable,
          WorkOrderEquipmentData>
    ),
    WorkOrderEquipmentData,
    PrefetchHooks Function()> {
  $$WorkOrderEquipmentTableTableManager(
      _$AppDatabase db, $WorkOrderEquipmentTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkOrderEquipmentTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkOrderEquipmentTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkOrderEquipmentTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> workOrderId = const Value.absent(),
            Value<int> equipmentId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkOrderEquipmentCompanion(
            workOrderId: workOrderId,
            equipmentId: equipmentId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int workOrderId,
            required int equipmentId,
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkOrderEquipmentCompanion.insert(
            workOrderId: workOrderId,
            equipmentId: equipmentId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WorkOrderEquipmentTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkOrderEquipmentTable,
    WorkOrderEquipmentData,
    $$WorkOrderEquipmentTableFilterComposer,
    $$WorkOrderEquipmentTableOrderingComposer,
    $$WorkOrderEquipmentTableAnnotationComposer,
    $$WorkOrderEquipmentTableCreateCompanionBuilder,
    $$WorkOrderEquipmentTableUpdateCompanionBuilder,
    (
      WorkOrderEquipmentData,
      BaseReferences<_$AppDatabase, $WorkOrderEquipmentTable,
          WorkOrderEquipmentData>
    ),
    WorkOrderEquipmentData,
    PrefetchHooks Function()>;
typedef $$WorkPerformedTableCreateCompanionBuilder = WorkPerformedCompanion
    Function({
  Value<int> id,
  required int workOrderId,
  Value<int?> equipmentId,
  required String technician,
  required DateTime startedAt,
  Value<int?> durationMinutes,
  Value<String?> workDescription,
  Value<String?> resolution,
  Value<bool> repeatIssue,
});
typedef $$WorkPerformedTableUpdateCompanionBuilder = WorkPerformedCompanion
    Function({
  Value<int> id,
  Value<int> workOrderId,
  Value<int?> equipmentId,
  Value<String> technician,
  Value<DateTime> startedAt,
  Value<int?> durationMinutes,
  Value<String?> workDescription,
  Value<String?> resolution,
  Value<bool> repeatIssue,
});

class $$WorkPerformedTableFilterComposer
    extends Composer<_$AppDatabase, $WorkPerformedTable> {
  $$WorkPerformedTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get workOrderId => $composableBuilder(
      column: $table.workOrderId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get equipmentId => $composableBuilder(
      column: $table.equipmentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get technician => $composableBuilder(
      column: $table.technician, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workDescription => $composableBuilder(
      column: $table.workDescription,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get resolution => $composableBuilder(
      column: $table.resolution, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get repeatIssue => $composableBuilder(
      column: $table.repeatIssue, builder: (column) => ColumnFilters(column));
}

class $$WorkPerformedTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkPerformedTable> {
  $$WorkPerformedTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get workOrderId => $composableBuilder(
      column: $table.workOrderId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get equipmentId => $composableBuilder(
      column: $table.equipmentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get technician => $composableBuilder(
      column: $table.technician, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workDescription => $composableBuilder(
      column: $table.workDescription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get resolution => $composableBuilder(
      column: $table.resolution, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get repeatIssue => $composableBuilder(
      column: $table.repeatIssue, builder: (column) => ColumnOrderings(column));
}

class $$WorkPerformedTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkPerformedTable> {
  $$WorkPerformedTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get workOrderId => $composableBuilder(
      column: $table.workOrderId, builder: (column) => column);

  GeneratedColumn<int> get equipmentId => $composableBuilder(
      column: $table.equipmentId, builder: (column) => column);

  GeneratedColumn<String> get technician => $composableBuilder(
      column: $table.technician, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes, builder: (column) => column);

  GeneratedColumn<String> get workDescription => $composableBuilder(
      column: $table.workDescription, builder: (column) => column);

  GeneratedColumn<String> get resolution => $composableBuilder(
      column: $table.resolution, builder: (column) => column);

  GeneratedColumn<bool> get repeatIssue => $composableBuilder(
      column: $table.repeatIssue, builder: (column) => column);
}

class $$WorkPerformedTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkPerformedTable,
    WorkPerformedData,
    $$WorkPerformedTableFilterComposer,
    $$WorkPerformedTableOrderingComposer,
    $$WorkPerformedTableAnnotationComposer,
    $$WorkPerformedTableCreateCompanionBuilder,
    $$WorkPerformedTableUpdateCompanionBuilder,
    (
      WorkPerformedData,
      BaseReferences<_$AppDatabase, $WorkPerformedTable, WorkPerformedData>
    ),
    WorkPerformedData,
    PrefetchHooks Function()> {
  $$WorkPerformedTableTableManager(_$AppDatabase db, $WorkPerformedTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkPerformedTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkPerformedTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkPerformedTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> workOrderId = const Value.absent(),
            Value<int?> equipmentId = const Value.absent(),
            Value<String> technician = const Value.absent(),
            Value<DateTime> startedAt = const Value.absent(),
            Value<int?> durationMinutes = const Value.absent(),
            Value<String?> workDescription = const Value.absent(),
            Value<String?> resolution = const Value.absent(),
            Value<bool> repeatIssue = const Value.absent(),
          }) =>
              WorkPerformedCompanion(
            id: id,
            workOrderId: workOrderId,
            equipmentId: equipmentId,
            technician: technician,
            startedAt: startedAt,
            durationMinutes: durationMinutes,
            workDescription: workDescription,
            resolution: resolution,
            repeatIssue: repeatIssue,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int workOrderId,
            Value<int?> equipmentId = const Value.absent(),
            required String technician,
            required DateTime startedAt,
            Value<int?> durationMinutes = const Value.absent(),
            Value<String?> workDescription = const Value.absent(),
            Value<String?> resolution = const Value.absent(),
            Value<bool> repeatIssue = const Value.absent(),
          }) =>
              WorkPerformedCompanion.insert(
            id: id,
            workOrderId: workOrderId,
            equipmentId: equipmentId,
            technician: technician,
            startedAt: startedAt,
            durationMinutes: durationMinutes,
            workDescription: workDescription,
            resolution: resolution,
            repeatIssue: repeatIssue,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WorkPerformedTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkPerformedTable,
    WorkPerformedData,
    $$WorkPerformedTableFilterComposer,
    $$WorkPerformedTableOrderingComposer,
    $$WorkPerformedTableAnnotationComposer,
    $$WorkPerformedTableCreateCompanionBuilder,
    $$WorkPerformedTableUpdateCompanionBuilder,
    (
      WorkPerformedData,
      BaseReferences<_$AppDatabase, $WorkPerformedTable, WorkPerformedData>
    ),
    WorkPerformedData,
    PrefetchHooks Function()>;
typedef $$PartsUsedTableCreateCompanionBuilder = PartsUsedCompanion Function({
  Value<int> id,
  required int workPerformedId,
  Value<String?> partNumber,
  Value<String?> description,
  Value<int> quantity,
});
typedef $$PartsUsedTableUpdateCompanionBuilder = PartsUsedCompanion Function({
  Value<int> id,
  Value<int> workPerformedId,
  Value<String?> partNumber,
  Value<String?> description,
  Value<int> quantity,
});

class $$PartsUsedTableFilterComposer
    extends Composer<_$AppDatabase, $PartsUsedTable> {
  $$PartsUsedTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get workPerformedId => $composableBuilder(
      column: $table.workPerformedId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get partNumber => $composableBuilder(
      column: $table.partNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));
}

class $$PartsUsedTableOrderingComposer
    extends Composer<_$AppDatabase, $PartsUsedTable> {
  $$PartsUsedTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get workPerformedId => $composableBuilder(
      column: $table.workPerformedId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get partNumber => $composableBuilder(
      column: $table.partNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));
}

class $$PartsUsedTableAnnotationComposer
    extends Composer<_$AppDatabase, $PartsUsedTable> {
  $$PartsUsedTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get workPerformedId => $composableBuilder(
      column: $table.workPerformedId, builder: (column) => column);

  GeneratedColumn<String> get partNumber => $composableBuilder(
      column: $table.partNumber, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);
}

class $$PartsUsedTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PartsUsedTable,
    PartsUsedData,
    $$PartsUsedTableFilterComposer,
    $$PartsUsedTableOrderingComposer,
    $$PartsUsedTableAnnotationComposer,
    $$PartsUsedTableCreateCompanionBuilder,
    $$PartsUsedTableUpdateCompanionBuilder,
    (
      PartsUsedData,
      BaseReferences<_$AppDatabase, $PartsUsedTable, PartsUsedData>
    ),
    PartsUsedData,
    PrefetchHooks Function()> {
  $$PartsUsedTableTableManager(_$AppDatabase db, $PartsUsedTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PartsUsedTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PartsUsedTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PartsUsedTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> workPerformedId = const Value.absent(),
            Value<String?> partNumber = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> quantity = const Value.absent(),
          }) =>
              PartsUsedCompanion(
            id: id,
            workPerformedId: workPerformedId,
            partNumber: partNumber,
            description: description,
            quantity: quantity,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int workPerformedId,
            Value<String?> partNumber = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> quantity = const Value.absent(),
          }) =>
              PartsUsedCompanion.insert(
            id: id,
            workPerformedId: workPerformedId,
            partNumber: partNumber,
            description: description,
            quantity: quantity,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PartsUsedTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PartsUsedTable,
    PartsUsedData,
    $$PartsUsedTableFilterComposer,
    $$PartsUsedTableOrderingComposer,
    $$PartsUsedTableAnnotationComposer,
    $$PartsUsedTableCreateCompanionBuilder,
    $$PartsUsedTableUpdateCompanionBuilder,
    (
      PartsUsedData,
      BaseReferences<_$AppDatabase, $PartsUsedTable, PartsUsedData>
    ),
    PartsUsedData,
    PrefetchHooks Function()>;
typedef $$NotesTableCreateCompanionBuilder = NotesCompanion Function({
  Value<int> id,
  required int siteId,
  Value<int?> workOrderId,
  required String noteType,
  required String noteText,
  required DateTime createdAt,
  Value<String?> createdBy,
});
typedef $$NotesTableUpdateCompanionBuilder = NotesCompanion Function({
  Value<int> id,
  Value<int> siteId,
  Value<int?> workOrderId,
  Value<String> noteType,
  Value<String> noteText,
  Value<DateTime> createdAt,
  Value<String?> createdBy,
});

class $$NotesTableFilterComposer extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get siteId => $composableBuilder(
      column: $table.siteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get workOrderId => $composableBuilder(
      column: $table.workOrderId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get noteType => $composableBuilder(
      column: $table.noteType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get noteText => $composableBuilder(
      column: $table.noteText, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnFilters(column));
}

class $$NotesTableOrderingComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get siteId => $composableBuilder(
      column: $table.siteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get workOrderId => $composableBuilder(
      column: $table.workOrderId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get noteType => $composableBuilder(
      column: $table.noteType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get noteText => $composableBuilder(
      column: $table.noteText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnOrderings(column));
}

class $$NotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get siteId =>
      $composableBuilder(column: $table.siteId, builder: (column) => column);

  GeneratedColumn<int> get workOrderId => $composableBuilder(
      column: $table.workOrderId, builder: (column) => column);

  GeneratedColumn<String> get noteType =>
      $composableBuilder(column: $table.noteType, builder: (column) => column);

  GeneratedColumn<String> get noteText =>
      $composableBuilder(column: $table.noteText, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);
}

class $$NotesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotesTable,
    Note,
    $$NotesTableFilterComposer,
    $$NotesTableOrderingComposer,
    $$NotesTableAnnotationComposer,
    $$NotesTableCreateCompanionBuilder,
    $$NotesTableUpdateCompanionBuilder,
    (Note, BaseReferences<_$AppDatabase, $NotesTable, Note>),
    Note,
    PrefetchHooks Function()> {
  $$NotesTableTableManager(_$AppDatabase db, $NotesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> siteId = const Value.absent(),
            Value<int?> workOrderId = const Value.absent(),
            Value<String> noteType = const Value.absent(),
            Value<String> noteText = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
          }) =>
              NotesCompanion(
            id: id,
            siteId: siteId,
            workOrderId: workOrderId,
            noteType: noteType,
            noteText: noteText,
            createdAt: createdAt,
            createdBy: createdBy,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int siteId,
            Value<int?> workOrderId = const Value.absent(),
            required String noteType,
            required String noteText,
            required DateTime createdAt,
            Value<String?> createdBy = const Value.absent(),
          }) =>
              NotesCompanion.insert(
            id: id,
            siteId: siteId,
            workOrderId: workOrderId,
            noteType: noteType,
            noteText: noteText,
            createdAt: createdAt,
            createdBy: createdBy,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NotesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NotesTable,
    Note,
    $$NotesTableFilterComposer,
    $$NotesTableOrderingComposer,
    $$NotesTableAnnotationComposer,
    $$NotesTableCreateCompanionBuilder,
    $$NotesTableUpdateCompanionBuilder,
    (Note, BaseReferences<_$AppDatabase, $NotesTable, Note>),
    Note,
    PrefetchHooks Function()>;
typedef $$DocumentsTableCreateCompanionBuilder = DocumentsCompanion Function({
  Value<int> id,
  Value<int?> workOrderId,
  Value<int?> siteId,
  required String fileName,
  required String filePath,
  required DateTime uploadedAt,
  Value<String?> uploadedBy,
});
typedef $$DocumentsTableUpdateCompanionBuilder = DocumentsCompanion Function({
  Value<int> id,
  Value<int?> workOrderId,
  Value<int?> siteId,
  Value<String> fileName,
  Value<String> filePath,
  Value<DateTime> uploadedAt,
  Value<String?> uploadedBy,
});

class $$DocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get workOrderId => $composableBuilder(
      column: $table.workOrderId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get siteId => $composableBuilder(
      column: $table.siteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fileName => $composableBuilder(
      column: $table.fileName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get filePath => $composableBuilder(
      column: $table.filePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get uploadedAt => $composableBuilder(
      column: $table.uploadedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uploadedBy => $composableBuilder(
      column: $table.uploadedBy, builder: (column) => ColumnFilters(column));
}

class $$DocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get workOrderId => $composableBuilder(
      column: $table.workOrderId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get siteId => $composableBuilder(
      column: $table.siteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fileName => $composableBuilder(
      column: $table.fileName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get filePath => $composableBuilder(
      column: $table.filePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get uploadedAt => $composableBuilder(
      column: $table.uploadedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uploadedBy => $composableBuilder(
      column: $table.uploadedBy, builder: (column) => ColumnOrderings(column));
}

class $$DocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get workOrderId => $composableBuilder(
      column: $table.workOrderId, builder: (column) => column);

  GeneratedColumn<int> get siteId =>
      $composableBuilder(column: $table.siteId, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<DateTime> get uploadedAt => $composableBuilder(
      column: $table.uploadedAt, builder: (column) => column);

  GeneratedColumn<String> get uploadedBy => $composableBuilder(
      column: $table.uploadedBy, builder: (column) => column);
}

class $$DocumentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DocumentsTable,
    Document,
    $$DocumentsTableFilterComposer,
    $$DocumentsTableOrderingComposer,
    $$DocumentsTableAnnotationComposer,
    $$DocumentsTableCreateCompanionBuilder,
    $$DocumentsTableUpdateCompanionBuilder,
    (Document, BaseReferences<_$AppDatabase, $DocumentsTable, Document>),
    Document,
    PrefetchHooks Function()> {
  $$DocumentsTableTableManager(_$AppDatabase db, $DocumentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> workOrderId = const Value.absent(),
            Value<int?> siteId = const Value.absent(),
            Value<String> fileName = const Value.absent(),
            Value<String> filePath = const Value.absent(),
            Value<DateTime> uploadedAt = const Value.absent(),
            Value<String?> uploadedBy = const Value.absent(),
          }) =>
              DocumentsCompanion(
            id: id,
            workOrderId: workOrderId,
            siteId: siteId,
            fileName: fileName,
            filePath: filePath,
            uploadedAt: uploadedAt,
            uploadedBy: uploadedBy,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> workOrderId = const Value.absent(),
            Value<int?> siteId = const Value.absent(),
            required String fileName,
            required String filePath,
            required DateTime uploadedAt,
            Value<String?> uploadedBy = const Value.absent(),
          }) =>
              DocumentsCompanion.insert(
            id: id,
            workOrderId: workOrderId,
            siteId: siteId,
            fileName: fileName,
            filePath: filePath,
            uploadedAt: uploadedAt,
            uploadedBy: uploadedBy,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DocumentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DocumentsTable,
    Document,
    $$DocumentsTableFilterComposer,
    $$DocumentsTableOrderingComposer,
    $$DocumentsTableAnnotationComposer,
    $$DocumentsTableCreateCompanionBuilder,
    $$DocumentsTableUpdateCompanionBuilder,
    (Document, BaseReferences<_$AppDatabase, $DocumentsTable, Document>),
    Document,
    PrefetchHooks Function()>;
typedef $$KnowledgeEntriesTableCreateCompanionBuilder
    = KnowledgeEntriesCompanion Function({
  required String id,
  required String title,
  required String content,
  Value<String> summary,
  Value<int?> categoryId,
  Value<int?> machineProfileId,
  required String category,
  required String equipmentType,
  Value<String?> equipmentModel,
  Value<String?> manufacturer,
  Value<String?> applicableModels,
  Value<String> serviceType,
  Value<String> difficultyLevel,
  Value<String> priorityLevel,
  Value<String> safetyLevel,
  Value<String?> complianceTags,
  Value<int?> estimatedTimeMinutes,
  Value<String?> requiredTools,
  Value<String?> requiredParts,
  Value<String?> prerequisites,
  Value<String?> specialRequirements,
  Value<String?> symptoms,
  Value<int> solutionsCount,
  Value<bool> hasImages,
  Value<bool> hasAttachments,
  Value<String?> author,
  Value<String?> authorRole,
  Value<String?> reviewer,
  Value<DateTime?> reviewedAt,
  Value<String> reviewStatus,
  Value<bool> approvalRequired,
  Value<String?> changeNotes,
  required String sourceType,
  required String sourceFile,
  Value<String?> externalId,
  Value<DateTime?> lastSyncedAt,
  Value<String?> syncSource,
  required String version,
  required String status,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> publishedAt,
  Value<DateTime?> archivedAt,
  Value<int> rowid,
});
typedef $$KnowledgeEntriesTableUpdateCompanionBuilder
    = KnowledgeEntriesCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> content,
  Value<String> summary,
  Value<int?> categoryId,
  Value<int?> machineProfileId,
  Value<String> category,
  Value<String> equipmentType,
  Value<String?> equipmentModel,
  Value<String?> manufacturer,
  Value<String?> applicableModels,
  Value<String> serviceType,
  Value<String> difficultyLevel,
  Value<String> priorityLevel,
  Value<String> safetyLevel,
  Value<String?> complianceTags,
  Value<int?> estimatedTimeMinutes,
  Value<String?> requiredTools,
  Value<String?> requiredParts,
  Value<String?> prerequisites,
  Value<String?> specialRequirements,
  Value<String?> symptoms,
  Value<int> solutionsCount,
  Value<bool> hasImages,
  Value<bool> hasAttachments,
  Value<String?> author,
  Value<String?> authorRole,
  Value<String?> reviewer,
  Value<DateTime?> reviewedAt,
  Value<String> reviewStatus,
  Value<bool> approvalRequired,
  Value<String?> changeNotes,
  Value<String> sourceType,
  Value<String> sourceFile,
  Value<String?> externalId,
  Value<DateTime?> lastSyncedAt,
  Value<String?> syncSource,
  Value<String> version,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> publishedAt,
  Value<DateTime?> archivedAt,
  Value<int> rowid,
});

final class $$KnowledgeEntriesTableReferences extends BaseReferences<
    _$AppDatabase, $KnowledgeEntriesTable, KnowledgeEntry> {
  $$KnowledgeEntriesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EntryTagsTable, List<EntryTag>>
      _entryTagsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.entryTags,
              aliasName: $_aliasNameGenerator(
                  db.knowledgeEntries.id, db.entryTags.entryId));

  $$EntryTagsTableProcessedTableManager get entryTagsRefs {
    final manager = $$EntryTagsTableTableManager($_db, $_db.entryTags)
        .filter((f) => f.entryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_entryTagsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$EntryMetadataTable, List<EntryMetadataData>>
      _entryMetadataRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.entryMetadata,
              aliasName: $_aliasNameGenerator(
                  db.knowledgeEntries.id, db.entryMetadata.entryId));

  $$EntryMetadataTableProcessedTableManager get entryMetadataRefs {
    final manager = $$EntryMetadataTableTableManager($_db, $_db.entryMetadata)
        .filter((f) => f.entryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_entryMetadataRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$KnowledgeAttachmentsTable,
      List<KnowledgeAttachment>> _knowledgeAttachmentsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.knowledgeAttachments,
          aliasName: $_aliasNameGenerator(
              db.knowledgeEntries.id, db.knowledgeAttachments.entryId));

  $$KnowledgeAttachmentsTableProcessedTableManager
      get knowledgeAttachmentsRefs {
    final manager =
        $$KnowledgeAttachmentsTableTableManager($_db, $_db.knowledgeAttachments)
            .filter((f) => f.entryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_knowledgeAttachmentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$KnowledgeHistoryTable, List<KnowledgeHistoryData>>
      _knowledgeHistoryRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.knowledgeHistory,
              aliasName: $_aliasNameGenerator(
                  db.knowledgeEntries.id, db.knowledgeHistory.entryId));

  $$KnowledgeHistoryTableProcessedTableManager get knowledgeHistoryRefs {
    final manager =
        $$KnowledgeHistoryTableTableManager($_db, $_db.knowledgeHistory)
            .filter((f) => f.entryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_knowledgeHistoryRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$KnowledgeEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $KnowledgeEntriesTable> {
  $$KnowledgeEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get summary => $composableBuilder(
      column: $table.summary, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get machineProfileId => $composableBuilder(
      column: $table.machineProfileId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get equipmentType => $composableBuilder(
      column: $table.equipmentType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get equipmentModel => $composableBuilder(
      column: $table.equipmentModel,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get manufacturer => $composableBuilder(
      column: $table.manufacturer, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get applicableModels => $composableBuilder(
      column: $table.applicableModels,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get serviceType => $composableBuilder(
      column: $table.serviceType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get difficultyLevel => $composableBuilder(
      column: $table.difficultyLevel,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get priorityLevel => $composableBuilder(
      column: $table.priorityLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get safetyLevel => $composableBuilder(
      column: $table.safetyLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get complianceTags => $composableBuilder(
      column: $table.complianceTags,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get estimatedTimeMinutes => $composableBuilder(
      column: $table.estimatedTimeMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get requiredTools => $composableBuilder(
      column: $table.requiredTools, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get requiredParts => $composableBuilder(
      column: $table.requiredParts, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get prerequisites => $composableBuilder(
      column: $table.prerequisites, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get specialRequirements => $composableBuilder(
      column: $table.specialRequirements,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get symptoms => $composableBuilder(
      column: $table.symptoms, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get solutionsCount => $composableBuilder(
      column: $table.solutionsCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasImages => $composableBuilder(
      column: $table.hasImages, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasAttachments => $composableBuilder(
      column: $table.hasAttachments,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get authorRole => $composableBuilder(
      column: $table.authorRole, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reviewer => $composableBuilder(
      column: $table.reviewer, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get reviewedAt => $composableBuilder(
      column: $table.reviewedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reviewStatus => $composableBuilder(
      column: $table.reviewStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get approvalRequired => $composableBuilder(
      column: $table.approvalRequired,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get changeNotes => $composableBuilder(
      column: $table.changeNotes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceType => $composableBuilder(
      column: $table.sourceType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceFile => $composableBuilder(
      column: $table.sourceFile, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get externalId => $composableBuilder(
      column: $table.externalId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncSource => $composableBuilder(
      column: $table.syncSource, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
      column: $table.archivedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> entryTagsRefs(
      Expression<bool> Function($$EntryTagsTableFilterComposer f) f) {
    final $$EntryTagsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.entryTags,
        getReferencedColumn: (t) => t.entryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntryTagsTableFilterComposer(
              $db: $db,
              $table: $db.entryTags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> entryMetadataRefs(
      Expression<bool> Function($$EntryMetadataTableFilterComposer f) f) {
    final $$EntryMetadataTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.entryMetadata,
        getReferencedColumn: (t) => t.entryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntryMetadataTableFilterComposer(
              $db: $db,
              $table: $db.entryMetadata,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> knowledgeAttachmentsRefs(
      Expression<bool> Function($$KnowledgeAttachmentsTableFilterComposer f)
          f) {
    final $$KnowledgeAttachmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.knowledgeAttachments,
        getReferencedColumn: (t) => t.entryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeAttachmentsTableFilterComposer(
              $db: $db,
              $table: $db.knowledgeAttachments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> knowledgeHistoryRefs(
      Expression<bool> Function($$KnowledgeHistoryTableFilterComposer f) f) {
    final $$KnowledgeHistoryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.knowledgeHistory,
        getReferencedColumn: (t) => t.entryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeHistoryTableFilterComposer(
              $db: $db,
              $table: $db.knowledgeHistory,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$KnowledgeEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $KnowledgeEntriesTable> {
  $$KnowledgeEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get summary => $composableBuilder(
      column: $table.summary, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get machineProfileId => $composableBuilder(
      column: $table.machineProfileId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get equipmentType => $composableBuilder(
      column: $table.equipmentType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get equipmentModel => $composableBuilder(
      column: $table.equipmentModel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get manufacturer => $composableBuilder(
      column: $table.manufacturer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get applicableModels => $composableBuilder(
      column: $table.applicableModels,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get serviceType => $composableBuilder(
      column: $table.serviceType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get difficultyLevel => $composableBuilder(
      column: $table.difficultyLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get priorityLevel => $composableBuilder(
      column: $table.priorityLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get safetyLevel => $composableBuilder(
      column: $table.safetyLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get complianceTags => $composableBuilder(
      column: $table.complianceTags,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get estimatedTimeMinutes => $composableBuilder(
      column: $table.estimatedTimeMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get requiredTools => $composableBuilder(
      column: $table.requiredTools,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get requiredParts => $composableBuilder(
      column: $table.requiredParts,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get prerequisites => $composableBuilder(
      column: $table.prerequisites,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get specialRequirements => $composableBuilder(
      column: $table.specialRequirements,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get symptoms => $composableBuilder(
      column: $table.symptoms, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get solutionsCount => $composableBuilder(
      column: $table.solutionsCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasImages => $composableBuilder(
      column: $table.hasImages, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasAttachments => $composableBuilder(
      column: $table.hasAttachments,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get authorRole => $composableBuilder(
      column: $table.authorRole, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reviewer => $composableBuilder(
      column: $table.reviewer, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get reviewedAt => $composableBuilder(
      column: $table.reviewedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reviewStatus => $composableBuilder(
      column: $table.reviewStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get approvalRequired => $composableBuilder(
      column: $table.approvalRequired,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get changeNotes => $composableBuilder(
      column: $table.changeNotes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceType => $composableBuilder(
      column: $table.sourceType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceFile => $composableBuilder(
      column: $table.sourceFile, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get externalId => $composableBuilder(
      column: $table.externalId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncSource => $composableBuilder(
      column: $table.syncSource, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
      column: $table.archivedAt, builder: (column) => ColumnOrderings(column));
}

class $$KnowledgeEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $KnowledgeEntriesTable> {
  $$KnowledgeEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<int> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => column);

  GeneratedColumn<int> get machineProfileId => $composableBuilder(
      column: $table.machineProfileId, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get equipmentType => $composableBuilder(
      column: $table.equipmentType, builder: (column) => column);

  GeneratedColumn<String> get equipmentModel => $composableBuilder(
      column: $table.equipmentModel, builder: (column) => column);

  GeneratedColumn<String> get manufacturer => $composableBuilder(
      column: $table.manufacturer, builder: (column) => column);

  GeneratedColumn<String> get applicableModels => $composableBuilder(
      column: $table.applicableModels, builder: (column) => column);

  GeneratedColumn<String> get serviceType => $composableBuilder(
      column: $table.serviceType, builder: (column) => column);

  GeneratedColumn<String> get difficultyLevel => $composableBuilder(
      column: $table.difficultyLevel, builder: (column) => column);

  GeneratedColumn<String> get priorityLevel => $composableBuilder(
      column: $table.priorityLevel, builder: (column) => column);

  GeneratedColumn<String> get safetyLevel => $composableBuilder(
      column: $table.safetyLevel, builder: (column) => column);

  GeneratedColumn<String> get complianceTags => $composableBuilder(
      column: $table.complianceTags, builder: (column) => column);

  GeneratedColumn<int> get estimatedTimeMinutes => $composableBuilder(
      column: $table.estimatedTimeMinutes, builder: (column) => column);

  GeneratedColumn<String> get requiredTools => $composableBuilder(
      column: $table.requiredTools, builder: (column) => column);

  GeneratedColumn<String> get requiredParts => $composableBuilder(
      column: $table.requiredParts, builder: (column) => column);

  GeneratedColumn<String> get prerequisites => $composableBuilder(
      column: $table.prerequisites, builder: (column) => column);

  GeneratedColumn<String> get specialRequirements => $composableBuilder(
      column: $table.specialRequirements, builder: (column) => column);

  GeneratedColumn<String> get symptoms =>
      $composableBuilder(column: $table.symptoms, builder: (column) => column);

  GeneratedColumn<int> get solutionsCount => $composableBuilder(
      column: $table.solutionsCount, builder: (column) => column);

  GeneratedColumn<bool> get hasImages =>
      $composableBuilder(column: $table.hasImages, builder: (column) => column);

  GeneratedColumn<bool> get hasAttachments => $composableBuilder(
      column: $table.hasAttachments, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get authorRole => $composableBuilder(
      column: $table.authorRole, builder: (column) => column);

  GeneratedColumn<String> get reviewer =>
      $composableBuilder(column: $table.reviewer, builder: (column) => column);

  GeneratedColumn<DateTime> get reviewedAt => $composableBuilder(
      column: $table.reviewedAt, builder: (column) => column);

  GeneratedColumn<String> get reviewStatus => $composableBuilder(
      column: $table.reviewStatus, builder: (column) => column);

  GeneratedColumn<bool> get approvalRequired => $composableBuilder(
      column: $table.approvalRequired, builder: (column) => column);

  GeneratedColumn<String> get changeNotes => $composableBuilder(
      column: $table.changeNotes, builder: (column) => column);

  GeneratedColumn<String> get sourceType => $composableBuilder(
      column: $table.sourceType, builder: (column) => column);

  GeneratedColumn<String> get sourceFile => $composableBuilder(
      column: $table.sourceFile, builder: (column) => column);

  GeneratedColumn<String> get externalId => $composableBuilder(
      column: $table.externalId, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);

  GeneratedColumn<String> get syncSource => $composableBuilder(
      column: $table.syncSource, builder: (column) => column);

  GeneratedColumn<String> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get publishedAt => $composableBuilder(
      column: $table.publishedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
      column: $table.archivedAt, builder: (column) => column);

  Expression<T> entryTagsRefs<T extends Object>(
      Expression<T> Function($$EntryTagsTableAnnotationComposer a) f) {
    final $$EntryTagsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.entryTags,
        getReferencedColumn: (t) => t.entryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntryTagsTableAnnotationComposer(
              $db: $db,
              $table: $db.entryTags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> entryMetadataRefs<T extends Object>(
      Expression<T> Function($$EntryMetadataTableAnnotationComposer a) f) {
    final $$EntryMetadataTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.entryMetadata,
        getReferencedColumn: (t) => t.entryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntryMetadataTableAnnotationComposer(
              $db: $db,
              $table: $db.entryMetadata,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> knowledgeAttachmentsRefs<T extends Object>(
      Expression<T> Function($$KnowledgeAttachmentsTableAnnotationComposer a)
          f) {
    final $$KnowledgeAttachmentsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.knowledgeAttachments,
            getReferencedColumn: (t) => t.entryId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KnowledgeAttachmentsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.knowledgeAttachments,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> knowledgeHistoryRefs<T extends Object>(
      Expression<T> Function($$KnowledgeHistoryTableAnnotationComposer a) f) {
    final $$KnowledgeHistoryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.knowledgeHistory,
        getReferencedColumn: (t) => t.entryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeHistoryTableAnnotationComposer(
              $db: $db,
              $table: $db.knowledgeHistory,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$KnowledgeEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $KnowledgeEntriesTable,
    KnowledgeEntry,
    $$KnowledgeEntriesTableFilterComposer,
    $$KnowledgeEntriesTableOrderingComposer,
    $$KnowledgeEntriesTableAnnotationComposer,
    $$KnowledgeEntriesTableCreateCompanionBuilder,
    $$KnowledgeEntriesTableUpdateCompanionBuilder,
    (KnowledgeEntry, $$KnowledgeEntriesTableReferences),
    KnowledgeEntry,
    PrefetchHooks Function(
        {bool entryTagsRefs,
        bool entryMetadataRefs,
        bool knowledgeAttachmentsRefs,
        bool knowledgeHistoryRefs})> {
  $$KnowledgeEntriesTableTableManager(
      _$AppDatabase db, $KnowledgeEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KnowledgeEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KnowledgeEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KnowledgeEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> summary = const Value.absent(),
            Value<int?> categoryId = const Value.absent(),
            Value<int?> machineProfileId = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> equipmentType = const Value.absent(),
            Value<String?> equipmentModel = const Value.absent(),
            Value<String?> manufacturer = const Value.absent(),
            Value<String?> applicableModels = const Value.absent(),
            Value<String> serviceType = const Value.absent(),
            Value<String> difficultyLevel = const Value.absent(),
            Value<String> priorityLevel = const Value.absent(),
            Value<String> safetyLevel = const Value.absent(),
            Value<String?> complianceTags = const Value.absent(),
            Value<int?> estimatedTimeMinutes = const Value.absent(),
            Value<String?> requiredTools = const Value.absent(),
            Value<String?> requiredParts = const Value.absent(),
            Value<String?> prerequisites = const Value.absent(),
            Value<String?> specialRequirements = const Value.absent(),
            Value<String?> symptoms = const Value.absent(),
            Value<int> solutionsCount = const Value.absent(),
            Value<bool> hasImages = const Value.absent(),
            Value<bool> hasAttachments = const Value.absent(),
            Value<String?> author = const Value.absent(),
            Value<String?> authorRole = const Value.absent(),
            Value<String?> reviewer = const Value.absent(),
            Value<DateTime?> reviewedAt = const Value.absent(),
            Value<String> reviewStatus = const Value.absent(),
            Value<bool> approvalRequired = const Value.absent(),
            Value<String?> changeNotes = const Value.absent(),
            Value<String> sourceType = const Value.absent(),
            Value<String> sourceFile = const Value.absent(),
            Value<String?> externalId = const Value.absent(),
            Value<DateTime?> lastSyncedAt = const Value.absent(),
            Value<String?> syncSource = const Value.absent(),
            Value<String> version = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> publishedAt = const Value.absent(),
            Value<DateTime?> archivedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              KnowledgeEntriesCompanion(
            id: id,
            title: title,
            content: content,
            summary: summary,
            categoryId: categoryId,
            machineProfileId: machineProfileId,
            category: category,
            equipmentType: equipmentType,
            equipmentModel: equipmentModel,
            manufacturer: manufacturer,
            applicableModels: applicableModels,
            serviceType: serviceType,
            difficultyLevel: difficultyLevel,
            priorityLevel: priorityLevel,
            safetyLevel: safetyLevel,
            complianceTags: complianceTags,
            estimatedTimeMinutes: estimatedTimeMinutes,
            requiredTools: requiredTools,
            requiredParts: requiredParts,
            prerequisites: prerequisites,
            specialRequirements: specialRequirements,
            symptoms: symptoms,
            solutionsCount: solutionsCount,
            hasImages: hasImages,
            hasAttachments: hasAttachments,
            author: author,
            authorRole: authorRole,
            reviewer: reviewer,
            reviewedAt: reviewedAt,
            reviewStatus: reviewStatus,
            approvalRequired: approvalRequired,
            changeNotes: changeNotes,
            sourceType: sourceType,
            sourceFile: sourceFile,
            externalId: externalId,
            lastSyncedAt: lastSyncedAt,
            syncSource: syncSource,
            version: version,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            publishedAt: publishedAt,
            archivedAt: archivedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String content,
            Value<String> summary = const Value.absent(),
            Value<int?> categoryId = const Value.absent(),
            Value<int?> machineProfileId = const Value.absent(),
            required String category,
            required String equipmentType,
            Value<String?> equipmentModel = const Value.absent(),
            Value<String?> manufacturer = const Value.absent(),
            Value<String?> applicableModels = const Value.absent(),
            Value<String> serviceType = const Value.absent(),
            Value<String> difficultyLevel = const Value.absent(),
            Value<String> priorityLevel = const Value.absent(),
            Value<String> safetyLevel = const Value.absent(),
            Value<String?> complianceTags = const Value.absent(),
            Value<int?> estimatedTimeMinutes = const Value.absent(),
            Value<String?> requiredTools = const Value.absent(),
            Value<String?> requiredParts = const Value.absent(),
            Value<String?> prerequisites = const Value.absent(),
            Value<String?> specialRequirements = const Value.absent(),
            Value<String?> symptoms = const Value.absent(),
            Value<int> solutionsCount = const Value.absent(),
            Value<bool> hasImages = const Value.absent(),
            Value<bool> hasAttachments = const Value.absent(),
            Value<String?> author = const Value.absent(),
            Value<String?> authorRole = const Value.absent(),
            Value<String?> reviewer = const Value.absent(),
            Value<DateTime?> reviewedAt = const Value.absent(),
            Value<String> reviewStatus = const Value.absent(),
            Value<bool> approvalRequired = const Value.absent(),
            Value<String?> changeNotes = const Value.absent(),
            required String sourceType,
            required String sourceFile,
            Value<String?> externalId = const Value.absent(),
            Value<DateTime?> lastSyncedAt = const Value.absent(),
            Value<String?> syncSource = const Value.absent(),
            required String version,
            required String status,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> publishedAt = const Value.absent(),
            Value<DateTime?> archivedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              KnowledgeEntriesCompanion.insert(
            id: id,
            title: title,
            content: content,
            summary: summary,
            categoryId: categoryId,
            machineProfileId: machineProfileId,
            category: category,
            equipmentType: equipmentType,
            equipmentModel: equipmentModel,
            manufacturer: manufacturer,
            applicableModels: applicableModels,
            serviceType: serviceType,
            difficultyLevel: difficultyLevel,
            priorityLevel: priorityLevel,
            safetyLevel: safetyLevel,
            complianceTags: complianceTags,
            estimatedTimeMinutes: estimatedTimeMinutes,
            requiredTools: requiredTools,
            requiredParts: requiredParts,
            prerequisites: prerequisites,
            specialRequirements: specialRequirements,
            symptoms: symptoms,
            solutionsCount: solutionsCount,
            hasImages: hasImages,
            hasAttachments: hasAttachments,
            author: author,
            authorRole: authorRole,
            reviewer: reviewer,
            reviewedAt: reviewedAt,
            reviewStatus: reviewStatus,
            approvalRequired: approvalRequired,
            changeNotes: changeNotes,
            sourceType: sourceType,
            sourceFile: sourceFile,
            externalId: externalId,
            lastSyncedAt: lastSyncedAt,
            syncSource: syncSource,
            version: version,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            publishedAt: publishedAt,
            archivedAt: archivedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KnowledgeEntriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {entryTagsRefs = false,
              entryMetadataRefs = false,
              knowledgeAttachmentsRefs = false,
              knowledgeHistoryRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (entryTagsRefs) db.entryTags,
                if (entryMetadataRefs) db.entryMetadata,
                if (knowledgeAttachmentsRefs) db.knowledgeAttachments,
                if (knowledgeHistoryRefs) db.knowledgeHistory
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (entryTagsRefs)
                    await $_getPrefetchedData<KnowledgeEntry,
                            $KnowledgeEntriesTable, EntryTag>(
                        currentTable: table,
                        referencedTable: $$KnowledgeEntriesTableReferences
                            ._entryTagsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KnowledgeEntriesTableReferences(db, table, p0)
                                .entryTagsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.entryId == item.id),
                        typedResults: items),
                  if (entryMetadataRefs)
                    await $_getPrefetchedData<KnowledgeEntry,
                            $KnowledgeEntriesTable, EntryMetadataData>(
                        currentTable: table,
                        referencedTable: $$KnowledgeEntriesTableReferences
                            ._entryMetadataRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KnowledgeEntriesTableReferences(db, table, p0)
                                .entryMetadataRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.entryId == item.id),
                        typedResults: items),
                  if (knowledgeAttachmentsRefs)
                    await $_getPrefetchedData<KnowledgeEntry,
                            $KnowledgeEntriesTable, KnowledgeAttachment>(
                        currentTable: table,
                        referencedTable: $$KnowledgeEntriesTableReferences
                            ._knowledgeAttachmentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KnowledgeEntriesTableReferences(db, table, p0)
                                .knowledgeAttachmentsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.entryId == item.id),
                        typedResults: items),
                  if (knowledgeHistoryRefs)
                    await $_getPrefetchedData<KnowledgeEntry,
                            $KnowledgeEntriesTable, KnowledgeHistoryData>(
                        currentTable: table,
                        referencedTable: $$KnowledgeEntriesTableReferences
                            ._knowledgeHistoryRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KnowledgeEntriesTableReferences(db, table, p0)
                                .knowledgeHistoryRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.entryId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$KnowledgeEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $KnowledgeEntriesTable,
    KnowledgeEntry,
    $$KnowledgeEntriesTableFilterComposer,
    $$KnowledgeEntriesTableOrderingComposer,
    $$KnowledgeEntriesTableAnnotationComposer,
    $$KnowledgeEntriesTableCreateCompanionBuilder,
    $$KnowledgeEntriesTableUpdateCompanionBuilder,
    (KnowledgeEntry, $$KnowledgeEntriesTableReferences),
    KnowledgeEntry,
    PrefetchHooks Function(
        {bool entryTagsRefs,
        bool entryMetadataRefs,
        bool knowledgeAttachmentsRefs,
        bool knowledgeHistoryRefs})>;
typedef $$KnowledgeCategoriesTableCreateCompanionBuilder
    = KnowledgeCategoriesCompanion Function({
  Value<int> id,
  required String name,
  required String slug,
  Value<int?> parentId,
  required int level,
  required String path,
  Value<String?> icon,
  Value<String?> description,
  Value<String?> color,
  Value<int> sortOrder,
  Value<bool> active,
  Value<int> articleCount,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$KnowledgeCategoriesTableUpdateCompanionBuilder
    = KnowledgeCategoriesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> slug,
  Value<int?> parentId,
  Value<int> level,
  Value<String> path,
  Value<String?> icon,
  Value<String?> description,
  Value<String?> color,
  Value<int> sortOrder,
  Value<bool> active,
  Value<int> articleCount,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$KnowledgeCategoriesTableReferences extends BaseReferences<
    _$AppDatabase, $KnowledgeCategoriesTable, KnowledgeCategory> {
  $$KnowledgeCategoriesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $KnowledgeCategoriesTable _parentIdTable(_$AppDatabase db) =>
      db.knowledgeCategories.createAlias($_aliasNameGenerator(
          db.knowledgeCategories.parentId, db.knowledgeCategories.id));

  $$KnowledgeCategoriesTableProcessedTableManager? get parentId {
    final $_column = $_itemColumn<int>('parent_id');
    if ($_column == null) return null;
    final manager =
        $$KnowledgeCategoriesTableTableManager($_db, $_db.knowledgeCategories)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$KnowledgeCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $KnowledgeCategoriesTable> {
  $$KnowledgeCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get articleCount => $composableBuilder(
      column: $table.articleCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$KnowledgeCategoriesTableFilterComposer get parentId {
    final $$KnowledgeCategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentId,
        referencedTable: $db.knowledgeCategories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeCategoriesTableFilterComposer(
              $db: $db,
              $table: $db.knowledgeCategories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KnowledgeCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $KnowledgeCategoriesTable> {
  $$KnowledgeCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get articleCount => $composableBuilder(
      column: $table.articleCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$KnowledgeCategoriesTableOrderingComposer get parentId {
    final $$KnowledgeCategoriesTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.parentId,
            referencedTable: $db.knowledgeCategories,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KnowledgeCategoriesTableOrderingComposer(
                  $db: $db,
                  $table: $db.knowledgeCategories,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$KnowledgeCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $KnowledgeCategoriesTable> {
  $$KnowledgeCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<int> get articleCount => $composableBuilder(
      column: $table.articleCount, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$KnowledgeCategoriesTableAnnotationComposer get parentId {
    final $$KnowledgeCategoriesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.parentId,
            referencedTable: $db.knowledgeCategories,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$KnowledgeCategoriesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.knowledgeCategories,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$KnowledgeCategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $KnowledgeCategoriesTable,
    KnowledgeCategory,
    $$KnowledgeCategoriesTableFilterComposer,
    $$KnowledgeCategoriesTableOrderingComposer,
    $$KnowledgeCategoriesTableAnnotationComposer,
    $$KnowledgeCategoriesTableCreateCompanionBuilder,
    $$KnowledgeCategoriesTableUpdateCompanionBuilder,
    (KnowledgeCategory, $$KnowledgeCategoriesTableReferences),
    KnowledgeCategory,
    PrefetchHooks Function({bool parentId})> {
  $$KnowledgeCategoriesTableTableManager(
      _$AppDatabase db, $KnowledgeCategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KnowledgeCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KnowledgeCategoriesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KnowledgeCategoriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> slug = const Value.absent(),
            Value<int?> parentId = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<String?> icon = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<int> articleCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              KnowledgeCategoriesCompanion(
            id: id,
            name: name,
            slug: slug,
            parentId: parentId,
            level: level,
            path: path,
            icon: icon,
            description: description,
            color: color,
            sortOrder: sortOrder,
            active: active,
            articleCount: articleCount,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String slug,
            Value<int?> parentId = const Value.absent(),
            required int level,
            required String path,
            Value<String?> icon = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<int> articleCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              KnowledgeCategoriesCompanion.insert(
            id: id,
            name: name,
            slug: slug,
            parentId: parentId,
            level: level,
            path: path,
            icon: icon,
            description: description,
            color: color,
            sortOrder: sortOrder,
            active: active,
            articleCount: articleCount,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KnowledgeCategoriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({parentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (parentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.parentId,
                    referencedTable:
                        $$KnowledgeCategoriesTableReferences._parentIdTable(db),
                    referencedColumn: $$KnowledgeCategoriesTableReferences
                        ._parentIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$KnowledgeCategoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $KnowledgeCategoriesTable,
    KnowledgeCategory,
    $$KnowledgeCategoriesTableFilterComposer,
    $$KnowledgeCategoriesTableOrderingComposer,
    $$KnowledgeCategoriesTableAnnotationComposer,
    $$KnowledgeCategoriesTableCreateCompanionBuilder,
    $$KnowledgeCategoriesTableUpdateCompanionBuilder,
    (KnowledgeCategory, $$KnowledgeCategoriesTableReferences),
    KnowledgeCategory,
    PrefetchHooks Function({bool parentId})>;
typedef $$KnowledgeTagsTableCreateCompanionBuilder = KnowledgeTagsCompanion
    Function({
  Value<int> id,
  required String name,
  required String slug,
  Value<String?> color,
  Value<String?> description,
  Value<int> usageCount,
  Value<bool> active,
  Value<DateTime> createdAt,
});
typedef $$KnowledgeTagsTableUpdateCompanionBuilder = KnowledgeTagsCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<String> slug,
  Value<String?> color,
  Value<String?> description,
  Value<int> usageCount,
  Value<bool> active,
  Value<DateTime> createdAt,
});

final class $$KnowledgeTagsTableReferences
    extends BaseReferences<_$AppDatabase, $KnowledgeTagsTable, KnowledgeTag> {
  $$KnowledgeTagsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EntryTagsTable, List<EntryTag>>
      _entryTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.entryTags,
          aliasName:
              $_aliasNameGenerator(db.knowledgeTags.id, db.entryTags.tagId));

  $$EntryTagsTableProcessedTableManager get entryTagsRefs {
    final manager = $$EntryTagsTableTableManager($_db, $_db.entryTags)
        .filter((f) => f.tagId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_entryTagsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$KnowledgeTagsTableFilterComposer
    extends Composer<_$AppDatabase, $KnowledgeTagsTable> {
  $$KnowledgeTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get usageCount => $composableBuilder(
      column: $table.usageCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> entryTagsRefs(
      Expression<bool> Function($$EntryTagsTableFilterComposer f) f) {
    final $$EntryTagsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.entryTags,
        getReferencedColumn: (t) => t.tagId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntryTagsTableFilterComposer(
              $db: $db,
              $table: $db.entryTags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$KnowledgeTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $KnowledgeTagsTable> {
  $$KnowledgeTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get usageCount => $composableBuilder(
      column: $table.usageCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active => $composableBuilder(
      column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$KnowledgeTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $KnowledgeTagsTable> {
  $$KnowledgeTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get usageCount => $composableBuilder(
      column: $table.usageCount, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> entryTagsRefs<T extends Object>(
      Expression<T> Function($$EntryTagsTableAnnotationComposer a) f) {
    final $$EntryTagsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.entryTags,
        getReferencedColumn: (t) => t.tagId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EntryTagsTableAnnotationComposer(
              $db: $db,
              $table: $db.entryTags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$KnowledgeTagsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $KnowledgeTagsTable,
    KnowledgeTag,
    $$KnowledgeTagsTableFilterComposer,
    $$KnowledgeTagsTableOrderingComposer,
    $$KnowledgeTagsTableAnnotationComposer,
    $$KnowledgeTagsTableCreateCompanionBuilder,
    $$KnowledgeTagsTableUpdateCompanionBuilder,
    (KnowledgeTag, $$KnowledgeTagsTableReferences),
    KnowledgeTag,
    PrefetchHooks Function({bool entryTagsRefs})> {
  $$KnowledgeTagsTableTableManager(_$AppDatabase db, $KnowledgeTagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KnowledgeTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KnowledgeTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KnowledgeTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> slug = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> usageCount = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              KnowledgeTagsCompanion(
            id: id,
            name: name,
            slug: slug,
            color: color,
            description: description,
            usageCount: usageCount,
            active: active,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String slug,
            Value<String?> color = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> usageCount = const Value.absent(),
            Value<bool> active = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              KnowledgeTagsCompanion.insert(
            id: id,
            name: name,
            slug: slug,
            color: color,
            description: description,
            usageCount: usageCount,
            active: active,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KnowledgeTagsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({entryTagsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (entryTagsRefs) db.entryTags],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (entryTagsRefs)
                    await $_getPrefetchedData<KnowledgeTag, $KnowledgeTagsTable,
                            EntryTag>(
                        currentTable: table,
                        referencedTable: $$KnowledgeTagsTableReferences
                            ._entryTagsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KnowledgeTagsTableReferences(db, table, p0)
                                .entryTagsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.tagId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$KnowledgeTagsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $KnowledgeTagsTable,
    KnowledgeTag,
    $$KnowledgeTagsTableFilterComposer,
    $$KnowledgeTagsTableOrderingComposer,
    $$KnowledgeTagsTableAnnotationComposer,
    $$KnowledgeTagsTableCreateCompanionBuilder,
    $$KnowledgeTagsTableUpdateCompanionBuilder,
    (KnowledgeTag, $$KnowledgeTagsTableReferences),
    KnowledgeTag,
    PrefetchHooks Function({bool entryTagsRefs})>;
typedef $$EntryTagsTableCreateCompanionBuilder = EntryTagsCompanion Function({
  required String entryId,
  required int tagId,
  required DateTime taggedAt,
  Value<int> rowid,
});
typedef $$EntryTagsTableUpdateCompanionBuilder = EntryTagsCompanion Function({
  Value<String> entryId,
  Value<int> tagId,
  Value<DateTime> taggedAt,
  Value<int> rowid,
});

final class $$EntryTagsTableReferences
    extends BaseReferences<_$AppDatabase, $EntryTagsTable, EntryTag> {
  $$EntryTagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $KnowledgeEntriesTable _entryIdTable(_$AppDatabase db) =>
      db.knowledgeEntries.createAlias(
          $_aliasNameGenerator(db.entryTags.entryId, db.knowledgeEntries.id));

  $$KnowledgeEntriesTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<String>('entry_id')!;

    final manager =
        $$KnowledgeEntriesTableTableManager($_db, $_db.knowledgeEntries)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $KnowledgeTagsTable _tagIdTable(_$AppDatabase db) =>
      db.knowledgeTags.createAlias(
          $_aliasNameGenerator(db.entryTags.tagId, db.knowledgeTags.id));

  $$KnowledgeTagsTableProcessedTableManager get tagId {
    final $_column = $_itemColumn<int>('tag_id')!;

    final manager = $$KnowledgeTagsTableTableManager($_db, $_db.knowledgeTags)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$EntryTagsTableFilterComposer
    extends Composer<_$AppDatabase, $EntryTagsTable> {
  $$EntryTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get taggedAt => $composableBuilder(
      column: $table.taggedAt, builder: (column) => ColumnFilters(column));

  $$KnowledgeEntriesTableFilterComposer get entryId {
    final $$KnowledgeEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entryId,
        referencedTable: $db.knowledgeEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeEntriesTableFilterComposer(
              $db: $db,
              $table: $db.knowledgeEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$KnowledgeTagsTableFilterComposer get tagId {
    final $$KnowledgeTagsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagId,
        referencedTable: $db.knowledgeTags,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeTagsTableFilterComposer(
              $db: $db,
              $table: $db.knowledgeTags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EntryTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $EntryTagsTable> {
  $$EntryTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get taggedAt => $composableBuilder(
      column: $table.taggedAt, builder: (column) => ColumnOrderings(column));

  $$KnowledgeEntriesTableOrderingComposer get entryId {
    final $$KnowledgeEntriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entryId,
        referencedTable: $db.knowledgeEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeEntriesTableOrderingComposer(
              $db: $db,
              $table: $db.knowledgeEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$KnowledgeTagsTableOrderingComposer get tagId {
    final $$KnowledgeTagsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagId,
        referencedTable: $db.knowledgeTags,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeTagsTableOrderingComposer(
              $db: $db,
              $table: $db.knowledgeTags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EntryTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EntryTagsTable> {
  $$EntryTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get taggedAt =>
      $composableBuilder(column: $table.taggedAt, builder: (column) => column);

  $$KnowledgeEntriesTableAnnotationComposer get entryId {
    final $$KnowledgeEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entryId,
        referencedTable: $db.knowledgeEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.knowledgeEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$KnowledgeTagsTableAnnotationComposer get tagId {
    final $$KnowledgeTagsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagId,
        referencedTable: $db.knowledgeTags,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeTagsTableAnnotationComposer(
              $db: $db,
              $table: $db.knowledgeTags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EntryTagsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EntryTagsTable,
    EntryTag,
    $$EntryTagsTableFilterComposer,
    $$EntryTagsTableOrderingComposer,
    $$EntryTagsTableAnnotationComposer,
    $$EntryTagsTableCreateCompanionBuilder,
    $$EntryTagsTableUpdateCompanionBuilder,
    (EntryTag, $$EntryTagsTableReferences),
    EntryTag,
    PrefetchHooks Function({bool entryId, bool tagId})> {
  $$EntryTagsTableTableManager(_$AppDatabase db, $EntryTagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntryTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntryTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntryTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> entryId = const Value.absent(),
            Value<int> tagId = const Value.absent(),
            Value<DateTime> taggedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EntryTagsCompanion(
            entryId: entryId,
            tagId: tagId,
            taggedAt: taggedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String entryId,
            required int tagId,
            required DateTime taggedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              EntryTagsCompanion.insert(
            entryId: entryId,
            tagId: tagId,
            taggedAt: taggedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$EntryTagsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({entryId = false, tagId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (entryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.entryId,
                    referencedTable:
                        $$EntryTagsTableReferences._entryIdTable(db),
                    referencedColumn:
                        $$EntryTagsTableReferences._entryIdTable(db).id,
                  ) as T;
                }
                if (tagId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.tagId,
                    referencedTable: $$EntryTagsTableReferences._tagIdTable(db),
                    referencedColumn:
                        $$EntryTagsTableReferences._tagIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$EntryTagsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EntryTagsTable,
    EntryTag,
    $$EntryTagsTableFilterComposer,
    $$EntryTagsTableOrderingComposer,
    $$EntryTagsTableAnnotationComposer,
    $$EntryTagsTableCreateCompanionBuilder,
    $$EntryTagsTableUpdateCompanionBuilder,
    (EntryTag, $$EntryTagsTableReferences),
    EntryTag,
    PrefetchHooks Function({bool entryId, bool tagId})>;
typedef $$EntryMetadataTableCreateCompanionBuilder = EntryMetadataCompanion
    Function({
  required String entryId,
  Value<int> viewCount,
  Value<int> helpfulCount,
  Value<int> notHelpfulCount,
  Value<int?> averageTimeSeconds,
  Value<DateTime?> lastViewedAt,
  Value<String> searchTermsFound,
  Value<int> searchResultClicks,
  Value<double?> completenessScore,
  Value<bool> needsReview,
  Value<DateTime?> nextReviewDue,
  Value<int> uniqueViewers,
  Value<int> returnVisitors,
  Value<int> rowid,
});
typedef $$EntryMetadataTableUpdateCompanionBuilder = EntryMetadataCompanion
    Function({
  Value<String> entryId,
  Value<int> viewCount,
  Value<int> helpfulCount,
  Value<int> notHelpfulCount,
  Value<int?> averageTimeSeconds,
  Value<DateTime?> lastViewedAt,
  Value<String> searchTermsFound,
  Value<int> searchResultClicks,
  Value<double?> completenessScore,
  Value<bool> needsReview,
  Value<DateTime?> nextReviewDue,
  Value<int> uniqueViewers,
  Value<int> returnVisitors,
  Value<int> rowid,
});

final class $$EntryMetadataTableReferences extends BaseReferences<_$AppDatabase,
    $EntryMetadataTable, EntryMetadataData> {
  $$EntryMetadataTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $KnowledgeEntriesTable _entryIdTable(_$AppDatabase db) =>
      db.knowledgeEntries.createAlias($_aliasNameGenerator(
          db.entryMetadata.entryId, db.knowledgeEntries.id));

  $$KnowledgeEntriesTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<String>('entry_id')!;

    final manager =
        $$KnowledgeEntriesTableTableManager($_db, $_db.knowledgeEntries)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$EntryMetadataTableFilterComposer
    extends Composer<_$AppDatabase, $EntryMetadataTable> {
  $$EntryMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get viewCount => $composableBuilder(
      column: $table.viewCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get helpfulCount => $composableBuilder(
      column: $table.helpfulCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get notHelpfulCount => $composableBuilder(
      column: $table.notHelpfulCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get averageTimeSeconds => $composableBuilder(
      column: $table.averageTimeSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastViewedAt => $composableBuilder(
      column: $table.lastViewedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get searchTermsFound => $composableBuilder(
      column: $table.searchTermsFound,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get searchResultClicks => $composableBuilder(
      column: $table.searchResultClicks,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get completenessScore => $composableBuilder(
      column: $table.completenessScore,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get needsReview => $composableBuilder(
      column: $table.needsReview, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get nextReviewDue => $composableBuilder(
      column: $table.nextReviewDue, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get uniqueViewers => $composableBuilder(
      column: $table.uniqueViewers, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get returnVisitors => $composableBuilder(
      column: $table.returnVisitors,
      builder: (column) => ColumnFilters(column));

  $$KnowledgeEntriesTableFilterComposer get entryId {
    final $$KnowledgeEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entryId,
        referencedTable: $db.knowledgeEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeEntriesTableFilterComposer(
              $db: $db,
              $table: $db.knowledgeEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EntryMetadataTableOrderingComposer
    extends Composer<_$AppDatabase, $EntryMetadataTable> {
  $$EntryMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get viewCount => $composableBuilder(
      column: $table.viewCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get helpfulCount => $composableBuilder(
      column: $table.helpfulCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get notHelpfulCount => $composableBuilder(
      column: $table.notHelpfulCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get averageTimeSeconds => $composableBuilder(
      column: $table.averageTimeSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastViewedAt => $composableBuilder(
      column: $table.lastViewedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get searchTermsFound => $composableBuilder(
      column: $table.searchTermsFound,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get searchResultClicks => $composableBuilder(
      column: $table.searchResultClicks,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get completenessScore => $composableBuilder(
      column: $table.completenessScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get needsReview => $composableBuilder(
      column: $table.needsReview, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get nextReviewDue => $composableBuilder(
      column: $table.nextReviewDue,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get uniqueViewers => $composableBuilder(
      column: $table.uniqueViewers,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get returnVisitors => $composableBuilder(
      column: $table.returnVisitors,
      builder: (column) => ColumnOrderings(column));

  $$KnowledgeEntriesTableOrderingComposer get entryId {
    final $$KnowledgeEntriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entryId,
        referencedTable: $db.knowledgeEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeEntriesTableOrderingComposer(
              $db: $db,
              $table: $db.knowledgeEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EntryMetadataTableAnnotationComposer
    extends Composer<_$AppDatabase, $EntryMetadataTable> {
  $$EntryMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get viewCount =>
      $composableBuilder(column: $table.viewCount, builder: (column) => column);

  GeneratedColumn<int> get helpfulCount => $composableBuilder(
      column: $table.helpfulCount, builder: (column) => column);

  GeneratedColumn<int> get notHelpfulCount => $composableBuilder(
      column: $table.notHelpfulCount, builder: (column) => column);

  GeneratedColumn<int> get averageTimeSeconds => $composableBuilder(
      column: $table.averageTimeSeconds, builder: (column) => column);

  GeneratedColumn<DateTime> get lastViewedAt => $composableBuilder(
      column: $table.lastViewedAt, builder: (column) => column);

  GeneratedColumn<String> get searchTermsFound => $composableBuilder(
      column: $table.searchTermsFound, builder: (column) => column);

  GeneratedColumn<int> get searchResultClicks => $composableBuilder(
      column: $table.searchResultClicks, builder: (column) => column);

  GeneratedColumn<double> get completenessScore => $composableBuilder(
      column: $table.completenessScore, builder: (column) => column);

  GeneratedColumn<bool> get needsReview => $composableBuilder(
      column: $table.needsReview, builder: (column) => column);

  GeneratedColumn<DateTime> get nextReviewDue => $composableBuilder(
      column: $table.nextReviewDue, builder: (column) => column);

  GeneratedColumn<int> get uniqueViewers => $composableBuilder(
      column: $table.uniqueViewers, builder: (column) => column);

  GeneratedColumn<int> get returnVisitors => $composableBuilder(
      column: $table.returnVisitors, builder: (column) => column);

  $$KnowledgeEntriesTableAnnotationComposer get entryId {
    final $$KnowledgeEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entryId,
        referencedTable: $db.knowledgeEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.knowledgeEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EntryMetadataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EntryMetadataTable,
    EntryMetadataData,
    $$EntryMetadataTableFilterComposer,
    $$EntryMetadataTableOrderingComposer,
    $$EntryMetadataTableAnnotationComposer,
    $$EntryMetadataTableCreateCompanionBuilder,
    $$EntryMetadataTableUpdateCompanionBuilder,
    (EntryMetadataData, $$EntryMetadataTableReferences),
    EntryMetadataData,
    PrefetchHooks Function({bool entryId})> {
  $$EntryMetadataTableTableManager(_$AppDatabase db, $EntryMetadataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntryMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntryMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntryMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> entryId = const Value.absent(),
            Value<int> viewCount = const Value.absent(),
            Value<int> helpfulCount = const Value.absent(),
            Value<int> notHelpfulCount = const Value.absent(),
            Value<int?> averageTimeSeconds = const Value.absent(),
            Value<DateTime?> lastViewedAt = const Value.absent(),
            Value<String> searchTermsFound = const Value.absent(),
            Value<int> searchResultClicks = const Value.absent(),
            Value<double?> completenessScore = const Value.absent(),
            Value<bool> needsReview = const Value.absent(),
            Value<DateTime?> nextReviewDue = const Value.absent(),
            Value<int> uniqueViewers = const Value.absent(),
            Value<int> returnVisitors = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EntryMetadataCompanion(
            entryId: entryId,
            viewCount: viewCount,
            helpfulCount: helpfulCount,
            notHelpfulCount: notHelpfulCount,
            averageTimeSeconds: averageTimeSeconds,
            lastViewedAt: lastViewedAt,
            searchTermsFound: searchTermsFound,
            searchResultClicks: searchResultClicks,
            completenessScore: completenessScore,
            needsReview: needsReview,
            nextReviewDue: nextReviewDue,
            uniqueViewers: uniqueViewers,
            returnVisitors: returnVisitors,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String entryId,
            Value<int> viewCount = const Value.absent(),
            Value<int> helpfulCount = const Value.absent(),
            Value<int> notHelpfulCount = const Value.absent(),
            Value<int?> averageTimeSeconds = const Value.absent(),
            Value<DateTime?> lastViewedAt = const Value.absent(),
            Value<String> searchTermsFound = const Value.absent(),
            Value<int> searchResultClicks = const Value.absent(),
            Value<double?> completenessScore = const Value.absent(),
            Value<bool> needsReview = const Value.absent(),
            Value<DateTime?> nextReviewDue = const Value.absent(),
            Value<int> uniqueViewers = const Value.absent(),
            Value<int> returnVisitors = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EntryMetadataCompanion.insert(
            entryId: entryId,
            viewCount: viewCount,
            helpfulCount: helpfulCount,
            notHelpfulCount: notHelpfulCount,
            averageTimeSeconds: averageTimeSeconds,
            lastViewedAt: lastViewedAt,
            searchTermsFound: searchTermsFound,
            searchResultClicks: searchResultClicks,
            completenessScore: completenessScore,
            needsReview: needsReview,
            nextReviewDue: nextReviewDue,
            uniqueViewers: uniqueViewers,
            returnVisitors: returnVisitors,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$EntryMetadataTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({entryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (entryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.entryId,
                    referencedTable:
                        $$EntryMetadataTableReferences._entryIdTable(db),
                    referencedColumn:
                        $$EntryMetadataTableReferences._entryIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$EntryMetadataTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EntryMetadataTable,
    EntryMetadataData,
    $$EntryMetadataTableFilterComposer,
    $$EntryMetadataTableOrderingComposer,
    $$EntryMetadataTableAnnotationComposer,
    $$EntryMetadataTableCreateCompanionBuilder,
    $$EntryMetadataTableUpdateCompanionBuilder,
    (EntryMetadataData, $$EntryMetadataTableReferences),
    EntryMetadataData,
    PrefetchHooks Function({bool entryId})>;
typedef $$KnowledgeAttachmentsTableCreateCompanionBuilder
    = KnowledgeAttachmentsCompanion Function({
  Value<int> id,
  required String entryId,
  required String fileName,
  required String filePath,
  required String fileType,
  required int fileSizeBytes,
  Value<String?> fileHash,
  Value<String?> altText,
  Value<String?> caption,
  Value<int> displayOrder,
  required String attachmentType,
  Value<bool> isInline,
  required DateTime uploadedAt,
  Value<String?> uploadedBy,
});
typedef $$KnowledgeAttachmentsTableUpdateCompanionBuilder
    = KnowledgeAttachmentsCompanion Function({
  Value<int> id,
  Value<String> entryId,
  Value<String> fileName,
  Value<String> filePath,
  Value<String> fileType,
  Value<int> fileSizeBytes,
  Value<String?> fileHash,
  Value<String?> altText,
  Value<String?> caption,
  Value<int> displayOrder,
  Value<String> attachmentType,
  Value<bool> isInline,
  Value<DateTime> uploadedAt,
  Value<String?> uploadedBy,
});

final class $$KnowledgeAttachmentsTableReferences extends BaseReferences<
    _$AppDatabase, $KnowledgeAttachmentsTable, KnowledgeAttachment> {
  $$KnowledgeAttachmentsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $KnowledgeEntriesTable _entryIdTable(_$AppDatabase db) =>
      db.knowledgeEntries.createAlias($_aliasNameGenerator(
          db.knowledgeAttachments.entryId, db.knowledgeEntries.id));

  $$KnowledgeEntriesTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<String>('entry_id')!;

    final manager =
        $$KnowledgeEntriesTableTableManager($_db, $_db.knowledgeEntries)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$KnowledgeAttachmentsTableFilterComposer
    extends Composer<_$AppDatabase, $KnowledgeAttachmentsTable> {
  $$KnowledgeAttachmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fileName => $composableBuilder(
      column: $table.fileName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get filePath => $composableBuilder(
      column: $table.filePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fileType => $composableBuilder(
      column: $table.fileType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fileSizeBytes => $composableBuilder(
      column: $table.fileSizeBytes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fileHash => $composableBuilder(
      column: $table.fileHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get altText => $composableBuilder(
      column: $table.altText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get caption => $composableBuilder(
      column: $table.caption, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get displayOrder => $composableBuilder(
      column: $table.displayOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get attachmentType => $composableBuilder(
      column: $table.attachmentType,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isInline => $composableBuilder(
      column: $table.isInline, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get uploadedAt => $composableBuilder(
      column: $table.uploadedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uploadedBy => $composableBuilder(
      column: $table.uploadedBy, builder: (column) => ColumnFilters(column));

  $$KnowledgeEntriesTableFilterComposer get entryId {
    final $$KnowledgeEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entryId,
        referencedTable: $db.knowledgeEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeEntriesTableFilterComposer(
              $db: $db,
              $table: $db.knowledgeEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KnowledgeAttachmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $KnowledgeAttachmentsTable> {
  $$KnowledgeAttachmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fileName => $composableBuilder(
      column: $table.fileName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get filePath => $composableBuilder(
      column: $table.filePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fileType => $composableBuilder(
      column: $table.fileType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fileSizeBytes => $composableBuilder(
      column: $table.fileSizeBytes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fileHash => $composableBuilder(
      column: $table.fileHash, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get altText => $composableBuilder(
      column: $table.altText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get caption => $composableBuilder(
      column: $table.caption, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get displayOrder => $composableBuilder(
      column: $table.displayOrder,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get attachmentType => $composableBuilder(
      column: $table.attachmentType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isInline => $composableBuilder(
      column: $table.isInline, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get uploadedAt => $composableBuilder(
      column: $table.uploadedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uploadedBy => $composableBuilder(
      column: $table.uploadedBy, builder: (column) => ColumnOrderings(column));

  $$KnowledgeEntriesTableOrderingComposer get entryId {
    final $$KnowledgeEntriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entryId,
        referencedTable: $db.knowledgeEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeEntriesTableOrderingComposer(
              $db: $db,
              $table: $db.knowledgeEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KnowledgeAttachmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $KnowledgeAttachmentsTable> {
  $$KnowledgeAttachmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get fileType =>
      $composableBuilder(column: $table.fileType, builder: (column) => column);

  GeneratedColumn<int> get fileSizeBytes => $composableBuilder(
      column: $table.fileSizeBytes, builder: (column) => column);

  GeneratedColumn<String> get fileHash =>
      $composableBuilder(column: $table.fileHash, builder: (column) => column);

  GeneratedColumn<String> get altText =>
      $composableBuilder(column: $table.altText, builder: (column) => column);

  GeneratedColumn<String> get caption =>
      $composableBuilder(column: $table.caption, builder: (column) => column);

  GeneratedColumn<int> get displayOrder => $composableBuilder(
      column: $table.displayOrder, builder: (column) => column);

  GeneratedColumn<String> get attachmentType => $composableBuilder(
      column: $table.attachmentType, builder: (column) => column);

  GeneratedColumn<bool> get isInline =>
      $composableBuilder(column: $table.isInline, builder: (column) => column);

  GeneratedColumn<DateTime> get uploadedAt => $composableBuilder(
      column: $table.uploadedAt, builder: (column) => column);

  GeneratedColumn<String> get uploadedBy => $composableBuilder(
      column: $table.uploadedBy, builder: (column) => column);

  $$KnowledgeEntriesTableAnnotationComposer get entryId {
    final $$KnowledgeEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entryId,
        referencedTable: $db.knowledgeEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.knowledgeEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KnowledgeAttachmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $KnowledgeAttachmentsTable,
    KnowledgeAttachment,
    $$KnowledgeAttachmentsTableFilterComposer,
    $$KnowledgeAttachmentsTableOrderingComposer,
    $$KnowledgeAttachmentsTableAnnotationComposer,
    $$KnowledgeAttachmentsTableCreateCompanionBuilder,
    $$KnowledgeAttachmentsTableUpdateCompanionBuilder,
    (KnowledgeAttachment, $$KnowledgeAttachmentsTableReferences),
    KnowledgeAttachment,
    PrefetchHooks Function({bool entryId})> {
  $$KnowledgeAttachmentsTableTableManager(
      _$AppDatabase db, $KnowledgeAttachmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KnowledgeAttachmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KnowledgeAttachmentsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KnowledgeAttachmentsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> entryId = const Value.absent(),
            Value<String> fileName = const Value.absent(),
            Value<String> filePath = const Value.absent(),
            Value<String> fileType = const Value.absent(),
            Value<int> fileSizeBytes = const Value.absent(),
            Value<String?> fileHash = const Value.absent(),
            Value<String?> altText = const Value.absent(),
            Value<String?> caption = const Value.absent(),
            Value<int> displayOrder = const Value.absent(),
            Value<String> attachmentType = const Value.absent(),
            Value<bool> isInline = const Value.absent(),
            Value<DateTime> uploadedAt = const Value.absent(),
            Value<String?> uploadedBy = const Value.absent(),
          }) =>
              KnowledgeAttachmentsCompanion(
            id: id,
            entryId: entryId,
            fileName: fileName,
            filePath: filePath,
            fileType: fileType,
            fileSizeBytes: fileSizeBytes,
            fileHash: fileHash,
            altText: altText,
            caption: caption,
            displayOrder: displayOrder,
            attachmentType: attachmentType,
            isInline: isInline,
            uploadedAt: uploadedAt,
            uploadedBy: uploadedBy,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String entryId,
            required String fileName,
            required String filePath,
            required String fileType,
            required int fileSizeBytes,
            Value<String?> fileHash = const Value.absent(),
            Value<String?> altText = const Value.absent(),
            Value<String?> caption = const Value.absent(),
            Value<int> displayOrder = const Value.absent(),
            required String attachmentType,
            Value<bool> isInline = const Value.absent(),
            required DateTime uploadedAt,
            Value<String?> uploadedBy = const Value.absent(),
          }) =>
              KnowledgeAttachmentsCompanion.insert(
            id: id,
            entryId: entryId,
            fileName: fileName,
            filePath: filePath,
            fileType: fileType,
            fileSizeBytes: fileSizeBytes,
            fileHash: fileHash,
            altText: altText,
            caption: caption,
            displayOrder: displayOrder,
            attachmentType: attachmentType,
            isInline: isInline,
            uploadedAt: uploadedAt,
            uploadedBy: uploadedBy,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KnowledgeAttachmentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({entryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (entryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.entryId,
                    referencedTable:
                        $$KnowledgeAttachmentsTableReferences._entryIdTable(db),
                    referencedColumn: $$KnowledgeAttachmentsTableReferences
                        ._entryIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$KnowledgeAttachmentsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $KnowledgeAttachmentsTable,
        KnowledgeAttachment,
        $$KnowledgeAttachmentsTableFilterComposer,
        $$KnowledgeAttachmentsTableOrderingComposer,
        $$KnowledgeAttachmentsTableAnnotationComposer,
        $$KnowledgeAttachmentsTableCreateCompanionBuilder,
        $$KnowledgeAttachmentsTableUpdateCompanionBuilder,
        (KnowledgeAttachment, $$KnowledgeAttachmentsTableReferences),
        KnowledgeAttachment,
        PrefetchHooks Function({bool entryId})>;
typedef $$KnowledgeHistoryTableCreateCompanionBuilder
    = KnowledgeHistoryCompanion Function({
  Value<int> id,
  required String entryId,
  required String changeType,
  Value<String?> fieldName,
  Value<String?> oldValue,
  Value<String?> newValue,
  Value<String?> changeNotes,
  required String changedBy,
  Value<String?> changedByRole,
  required DateTime changedAt,
  Value<String?> versionBefore,
  Value<String?> versionAfter,
});
typedef $$KnowledgeHistoryTableUpdateCompanionBuilder
    = KnowledgeHistoryCompanion Function({
  Value<int> id,
  Value<String> entryId,
  Value<String> changeType,
  Value<String?> fieldName,
  Value<String?> oldValue,
  Value<String?> newValue,
  Value<String?> changeNotes,
  Value<String> changedBy,
  Value<String?> changedByRole,
  Value<DateTime> changedAt,
  Value<String?> versionBefore,
  Value<String?> versionAfter,
});

final class $$KnowledgeHistoryTableReferences extends BaseReferences<
    _$AppDatabase, $KnowledgeHistoryTable, KnowledgeHistoryData> {
  $$KnowledgeHistoryTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $KnowledgeEntriesTable _entryIdTable(_$AppDatabase db) =>
      db.knowledgeEntries.createAlias($_aliasNameGenerator(
          db.knowledgeHistory.entryId, db.knowledgeEntries.id));

  $$KnowledgeEntriesTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<String>('entry_id')!;

    final manager =
        $$KnowledgeEntriesTableTableManager($_db, $_db.knowledgeEntries)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$KnowledgeHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $KnowledgeHistoryTable> {
  $$KnowledgeHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get changeType => $composableBuilder(
      column: $table.changeType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fieldName => $composableBuilder(
      column: $table.fieldName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get oldValue => $composableBuilder(
      column: $table.oldValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get newValue => $composableBuilder(
      column: $table.newValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get changeNotes => $composableBuilder(
      column: $table.changeNotes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get changedBy => $composableBuilder(
      column: $table.changedBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get changedByRole => $composableBuilder(
      column: $table.changedByRole, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get changedAt => $composableBuilder(
      column: $table.changedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get versionBefore => $composableBuilder(
      column: $table.versionBefore, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get versionAfter => $composableBuilder(
      column: $table.versionAfter, builder: (column) => ColumnFilters(column));

  $$KnowledgeEntriesTableFilterComposer get entryId {
    final $$KnowledgeEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entryId,
        referencedTable: $db.knowledgeEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeEntriesTableFilterComposer(
              $db: $db,
              $table: $db.knowledgeEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KnowledgeHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $KnowledgeHistoryTable> {
  $$KnowledgeHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get changeType => $composableBuilder(
      column: $table.changeType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fieldName => $composableBuilder(
      column: $table.fieldName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get oldValue => $composableBuilder(
      column: $table.oldValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get newValue => $composableBuilder(
      column: $table.newValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get changeNotes => $composableBuilder(
      column: $table.changeNotes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get changedBy => $composableBuilder(
      column: $table.changedBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get changedByRole => $composableBuilder(
      column: $table.changedByRole,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get changedAt => $composableBuilder(
      column: $table.changedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get versionBefore => $composableBuilder(
      column: $table.versionBefore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get versionAfter => $composableBuilder(
      column: $table.versionAfter,
      builder: (column) => ColumnOrderings(column));

  $$KnowledgeEntriesTableOrderingComposer get entryId {
    final $$KnowledgeEntriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entryId,
        referencedTable: $db.knowledgeEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeEntriesTableOrderingComposer(
              $db: $db,
              $table: $db.knowledgeEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KnowledgeHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $KnowledgeHistoryTable> {
  $$KnowledgeHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get changeType => $composableBuilder(
      column: $table.changeType, builder: (column) => column);

  GeneratedColumn<String> get fieldName =>
      $composableBuilder(column: $table.fieldName, builder: (column) => column);

  GeneratedColumn<String> get oldValue =>
      $composableBuilder(column: $table.oldValue, builder: (column) => column);

  GeneratedColumn<String> get newValue =>
      $composableBuilder(column: $table.newValue, builder: (column) => column);

  GeneratedColumn<String> get changeNotes => $composableBuilder(
      column: $table.changeNotes, builder: (column) => column);

  GeneratedColumn<String> get changedBy =>
      $composableBuilder(column: $table.changedBy, builder: (column) => column);

  GeneratedColumn<String> get changedByRole => $composableBuilder(
      column: $table.changedByRole, builder: (column) => column);

  GeneratedColumn<DateTime> get changedAt =>
      $composableBuilder(column: $table.changedAt, builder: (column) => column);

  GeneratedColumn<String> get versionBefore => $composableBuilder(
      column: $table.versionBefore, builder: (column) => column);

  GeneratedColumn<String> get versionAfter => $composableBuilder(
      column: $table.versionAfter, builder: (column) => column);

  $$KnowledgeEntriesTableAnnotationComposer get entryId {
    final $$KnowledgeEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entryId,
        referencedTable: $db.knowledgeEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.knowledgeEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KnowledgeHistoryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $KnowledgeHistoryTable,
    KnowledgeHistoryData,
    $$KnowledgeHistoryTableFilterComposer,
    $$KnowledgeHistoryTableOrderingComposer,
    $$KnowledgeHistoryTableAnnotationComposer,
    $$KnowledgeHistoryTableCreateCompanionBuilder,
    $$KnowledgeHistoryTableUpdateCompanionBuilder,
    (KnowledgeHistoryData, $$KnowledgeHistoryTableReferences),
    KnowledgeHistoryData,
    PrefetchHooks Function({bool entryId})> {
  $$KnowledgeHistoryTableTableManager(
      _$AppDatabase db, $KnowledgeHistoryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KnowledgeHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KnowledgeHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KnowledgeHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> entryId = const Value.absent(),
            Value<String> changeType = const Value.absent(),
            Value<String?> fieldName = const Value.absent(),
            Value<String?> oldValue = const Value.absent(),
            Value<String?> newValue = const Value.absent(),
            Value<String?> changeNotes = const Value.absent(),
            Value<String> changedBy = const Value.absent(),
            Value<String?> changedByRole = const Value.absent(),
            Value<DateTime> changedAt = const Value.absent(),
            Value<String?> versionBefore = const Value.absent(),
            Value<String?> versionAfter = const Value.absent(),
          }) =>
              KnowledgeHistoryCompanion(
            id: id,
            entryId: entryId,
            changeType: changeType,
            fieldName: fieldName,
            oldValue: oldValue,
            newValue: newValue,
            changeNotes: changeNotes,
            changedBy: changedBy,
            changedByRole: changedByRole,
            changedAt: changedAt,
            versionBefore: versionBefore,
            versionAfter: versionAfter,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String entryId,
            required String changeType,
            Value<String?> fieldName = const Value.absent(),
            Value<String?> oldValue = const Value.absent(),
            Value<String?> newValue = const Value.absent(),
            Value<String?> changeNotes = const Value.absent(),
            required String changedBy,
            Value<String?> changedByRole = const Value.absent(),
            required DateTime changedAt,
            Value<String?> versionBefore = const Value.absent(),
            Value<String?> versionAfter = const Value.absent(),
          }) =>
              KnowledgeHistoryCompanion.insert(
            id: id,
            entryId: entryId,
            changeType: changeType,
            fieldName: fieldName,
            oldValue: oldValue,
            newValue: newValue,
            changeNotes: changeNotes,
            changedBy: changedBy,
            changedByRole: changedByRole,
            changedAt: changedAt,
            versionBefore: versionBefore,
            versionAfter: versionAfter,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KnowledgeHistoryTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({entryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (entryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.entryId,
                    referencedTable:
                        $$KnowledgeHistoryTableReferences._entryIdTable(db),
                    referencedColumn:
                        $$KnowledgeHistoryTableReferences._entryIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$KnowledgeHistoryTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $KnowledgeHistoryTable,
    KnowledgeHistoryData,
    $$KnowledgeHistoryTableFilterComposer,
    $$KnowledgeHistoryTableOrderingComposer,
    $$KnowledgeHistoryTableAnnotationComposer,
    $$KnowledgeHistoryTableCreateCompanionBuilder,
    $$KnowledgeHistoryTableUpdateCompanionBuilder,
    (KnowledgeHistoryData, $$KnowledgeHistoryTableReferences),
    KnowledgeHistoryData,
    PrefetchHooks Function({bool entryId})>;
typedef $$KnowledgeRelationsTableCreateCompanionBuilder
    = KnowledgeRelationsCompanion Function({
  Value<int> id,
  required String fromEntryId,
  required String toEntryId,
  required String relationType,
  Value<int> strength,
  required DateTime createdAt,
  Value<String?> createdBy,
});
typedef $$KnowledgeRelationsTableUpdateCompanionBuilder
    = KnowledgeRelationsCompanion Function({
  Value<int> id,
  Value<String> fromEntryId,
  Value<String> toEntryId,
  Value<String> relationType,
  Value<int> strength,
  Value<DateTime> createdAt,
  Value<String?> createdBy,
});

final class $$KnowledgeRelationsTableReferences extends BaseReferences<
    _$AppDatabase, $KnowledgeRelationsTable, KnowledgeRelation> {
  $$KnowledgeRelationsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $KnowledgeEntriesTable _fromEntryIdTable(_$AppDatabase db) =>
      db.knowledgeEntries.createAlias($_aliasNameGenerator(
          db.knowledgeRelations.fromEntryId, db.knowledgeEntries.id));

  $$KnowledgeEntriesTableProcessedTableManager get fromEntryId {
    final $_column = $_itemColumn<String>('from_entry_id')!;

    final manager =
        $$KnowledgeEntriesTableTableManager($_db, $_db.knowledgeEntries)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fromEntryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $KnowledgeEntriesTable _toEntryIdTable(_$AppDatabase db) =>
      db.knowledgeEntries.createAlias($_aliasNameGenerator(
          db.knowledgeRelations.toEntryId, db.knowledgeEntries.id));

  $$KnowledgeEntriesTableProcessedTableManager get toEntryId {
    final $_column = $_itemColumn<String>('to_entry_id')!;

    final manager =
        $$KnowledgeEntriesTableTableManager($_db, $_db.knowledgeEntries)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_toEntryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$KnowledgeRelationsTableFilterComposer
    extends Composer<_$AppDatabase, $KnowledgeRelationsTable> {
  $$KnowledgeRelationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get relationType => $composableBuilder(
      column: $table.relationType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get strength => $composableBuilder(
      column: $table.strength, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnFilters(column));

  $$KnowledgeEntriesTableFilterComposer get fromEntryId {
    final $$KnowledgeEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fromEntryId,
        referencedTable: $db.knowledgeEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeEntriesTableFilterComposer(
              $db: $db,
              $table: $db.knowledgeEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$KnowledgeEntriesTableFilterComposer get toEntryId {
    final $$KnowledgeEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.toEntryId,
        referencedTable: $db.knowledgeEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeEntriesTableFilterComposer(
              $db: $db,
              $table: $db.knowledgeEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KnowledgeRelationsTableOrderingComposer
    extends Composer<_$AppDatabase, $KnowledgeRelationsTable> {
  $$KnowledgeRelationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get relationType => $composableBuilder(
      column: $table.relationType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get strength => $composableBuilder(
      column: $table.strength, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnOrderings(column));

  $$KnowledgeEntriesTableOrderingComposer get fromEntryId {
    final $$KnowledgeEntriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fromEntryId,
        referencedTable: $db.knowledgeEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeEntriesTableOrderingComposer(
              $db: $db,
              $table: $db.knowledgeEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$KnowledgeEntriesTableOrderingComposer get toEntryId {
    final $$KnowledgeEntriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.toEntryId,
        referencedTable: $db.knowledgeEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeEntriesTableOrderingComposer(
              $db: $db,
              $table: $db.knowledgeEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KnowledgeRelationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $KnowledgeRelationsTable> {
  $$KnowledgeRelationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get relationType => $composableBuilder(
      column: $table.relationType, builder: (column) => column);

  GeneratedColumn<int> get strength =>
      $composableBuilder(column: $table.strength, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  $$KnowledgeEntriesTableAnnotationComposer get fromEntryId {
    final $$KnowledgeEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fromEntryId,
        referencedTable: $db.knowledgeEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.knowledgeEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$KnowledgeEntriesTableAnnotationComposer get toEntryId {
    final $$KnowledgeEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.toEntryId,
        referencedTable: $db.knowledgeEntries,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KnowledgeEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.knowledgeEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KnowledgeRelationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $KnowledgeRelationsTable,
    KnowledgeRelation,
    $$KnowledgeRelationsTableFilterComposer,
    $$KnowledgeRelationsTableOrderingComposer,
    $$KnowledgeRelationsTableAnnotationComposer,
    $$KnowledgeRelationsTableCreateCompanionBuilder,
    $$KnowledgeRelationsTableUpdateCompanionBuilder,
    (KnowledgeRelation, $$KnowledgeRelationsTableReferences),
    KnowledgeRelation,
    PrefetchHooks Function({bool fromEntryId, bool toEntryId})> {
  $$KnowledgeRelationsTableTableManager(
      _$AppDatabase db, $KnowledgeRelationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KnowledgeRelationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KnowledgeRelationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KnowledgeRelationsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> fromEntryId = const Value.absent(),
            Value<String> toEntryId = const Value.absent(),
            Value<String> relationType = const Value.absent(),
            Value<int> strength = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
          }) =>
              KnowledgeRelationsCompanion(
            id: id,
            fromEntryId: fromEntryId,
            toEntryId: toEntryId,
            relationType: relationType,
            strength: strength,
            createdAt: createdAt,
            createdBy: createdBy,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String fromEntryId,
            required String toEntryId,
            required String relationType,
            Value<int> strength = const Value.absent(),
            required DateTime createdAt,
            Value<String?> createdBy = const Value.absent(),
          }) =>
              KnowledgeRelationsCompanion.insert(
            id: id,
            fromEntryId: fromEntryId,
            toEntryId: toEntryId,
            relationType: relationType,
            strength: strength,
            createdAt: createdAt,
            createdBy: createdBy,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$KnowledgeRelationsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({fromEntryId = false, toEntryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (fromEntryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.fromEntryId,
                    referencedTable: $$KnowledgeRelationsTableReferences
                        ._fromEntryIdTable(db),
                    referencedColumn: $$KnowledgeRelationsTableReferences
                        ._fromEntryIdTable(db)
                        .id,
                  ) as T;
                }
                if (toEntryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.toEntryId,
                    referencedTable:
                        $$KnowledgeRelationsTableReferences._toEntryIdTable(db),
                    referencedColumn: $$KnowledgeRelationsTableReferences
                        ._toEntryIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$KnowledgeRelationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $KnowledgeRelationsTable,
    KnowledgeRelation,
    $$KnowledgeRelationsTableFilterComposer,
    $$KnowledgeRelationsTableOrderingComposer,
    $$KnowledgeRelationsTableAnnotationComposer,
    $$KnowledgeRelationsTableCreateCompanionBuilder,
    $$KnowledgeRelationsTableUpdateCompanionBuilder,
    (KnowledgeRelation, $$KnowledgeRelationsTableReferences),
    KnowledgeRelation,
    PrefetchHooks Function({bool fromEntryId, bool toEntryId})>;
typedef $$MachineProfilesTableCreateCompanionBuilder = MachineProfilesCompanion
    Function({
  Value<int> id,
  required String equipmentType,
  required String manufacturer,
  required String model,
  Value<String?> aliases,
  Value<String?> searchKeys,
  Value<String?> description,
  Value<String?> imageAsset,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$MachineProfilesTableUpdateCompanionBuilder = MachineProfilesCompanion
    Function({
  Value<int> id,
  Value<String> equipmentType,
  Value<String> manufacturer,
  Value<String> model,
  Value<String?> aliases,
  Value<String?> searchKeys,
  Value<String?> description,
  Value<String?> imageAsset,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$MachineProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $MachineProfilesTable> {
  $$MachineProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get equipmentType => $composableBuilder(
      column: $table.equipmentType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get manufacturer => $composableBuilder(
      column: $table.manufacturer, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get aliases => $composableBuilder(
      column: $table.aliases, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get searchKeys => $composableBuilder(
      column: $table.searchKeys, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageAsset => $composableBuilder(
      column: $table.imageAsset, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$MachineProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $MachineProfilesTable> {
  $$MachineProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get equipmentType => $composableBuilder(
      column: $table.equipmentType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get manufacturer => $composableBuilder(
      column: $table.manufacturer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get aliases => $composableBuilder(
      column: $table.aliases, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get searchKeys => $composableBuilder(
      column: $table.searchKeys, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageAsset => $composableBuilder(
      column: $table.imageAsset, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$MachineProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MachineProfilesTable> {
  $$MachineProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get equipmentType => $composableBuilder(
      column: $table.equipmentType, builder: (column) => column);

  GeneratedColumn<String> get manufacturer => $composableBuilder(
      column: $table.manufacturer, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get aliases =>
      $composableBuilder(column: $table.aliases, builder: (column) => column);

  GeneratedColumn<String> get searchKeys => $composableBuilder(
      column: $table.searchKeys, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get imageAsset => $composableBuilder(
      column: $table.imageAsset, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MachineProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MachineProfilesTable,
    MachineProfile,
    $$MachineProfilesTableFilterComposer,
    $$MachineProfilesTableOrderingComposer,
    $$MachineProfilesTableAnnotationComposer,
    $$MachineProfilesTableCreateCompanionBuilder,
    $$MachineProfilesTableUpdateCompanionBuilder,
    (
      MachineProfile,
      BaseReferences<_$AppDatabase, $MachineProfilesTable, MachineProfile>
    ),
    MachineProfile,
    PrefetchHooks Function()> {
  $$MachineProfilesTableTableManager(
      _$AppDatabase db, $MachineProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MachineProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MachineProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MachineProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> equipmentType = const Value.absent(),
            Value<String> manufacturer = const Value.absent(),
            Value<String> model = const Value.absent(),
            Value<String?> aliases = const Value.absent(),
            Value<String?> searchKeys = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> imageAsset = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              MachineProfilesCompanion(
            id: id,
            equipmentType: equipmentType,
            manufacturer: manufacturer,
            model: model,
            aliases: aliases,
            searchKeys: searchKeys,
            description: description,
            imageAsset: imageAsset,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String equipmentType,
            required String manufacturer,
            required String model,
            Value<String?> aliases = const Value.absent(),
            Value<String?> searchKeys = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> imageAsset = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              MachineProfilesCompanion.insert(
            id: id,
            equipmentType: equipmentType,
            manufacturer: manufacturer,
            model: model,
            aliases: aliases,
            searchKeys: searchKeys,
            description: description,
            imageAsset: imageAsset,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MachineProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MachineProfilesTable,
    MachineProfile,
    $$MachineProfilesTableFilterComposer,
    $$MachineProfilesTableOrderingComposer,
    $$MachineProfilesTableAnnotationComposer,
    $$MachineProfilesTableCreateCompanionBuilder,
    $$MachineProfilesTableUpdateCompanionBuilder,
    (
      MachineProfile,
      BaseReferences<_$AppDatabase, $MachineProfilesTable, MachineProfile>
    ),
    MachineProfile,
    PrefetchHooks Function()>;
typedef $$ContinuingEducationCoursesTableCreateCompanionBuilder
    = ContinuingEducationCoursesCompanion Function({
  Value<int> id,
  required String title,
  required String provider,
  Value<String?> description,
  required String category,
  Value<int?> durationHours,
  Value<String?> externalUrl,
});
typedef $$ContinuingEducationCoursesTableUpdateCompanionBuilder
    = ContinuingEducationCoursesCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> provider,
  Value<String?> description,
  Value<String> category,
  Value<int?> durationHours,
  Value<String?> externalUrl,
});

class $$ContinuingEducationCoursesTableFilterComposer
    extends Composer<_$AppDatabase, $ContinuingEducationCoursesTable> {
  $$ContinuingEducationCoursesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get provider => $composableBuilder(
      column: $table.provider, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationHours => $composableBuilder(
      column: $table.durationHours, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get externalUrl => $composableBuilder(
      column: $table.externalUrl, builder: (column) => ColumnFilters(column));
}

class $$ContinuingEducationCoursesTableOrderingComposer
    extends Composer<_$AppDatabase, $ContinuingEducationCoursesTable> {
  $$ContinuingEducationCoursesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get provider => $composableBuilder(
      column: $table.provider, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationHours => $composableBuilder(
      column: $table.durationHours,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get externalUrl => $composableBuilder(
      column: $table.externalUrl, builder: (column) => ColumnOrderings(column));
}

class $$ContinuingEducationCoursesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContinuingEducationCoursesTable> {
  $$ContinuingEducationCoursesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get durationHours => $composableBuilder(
      column: $table.durationHours, builder: (column) => column);

  GeneratedColumn<String> get externalUrl => $composableBuilder(
      column: $table.externalUrl, builder: (column) => column);
}

class $$ContinuingEducationCoursesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ContinuingEducationCoursesTable,
    ContinuingEducationCourse,
    $$ContinuingEducationCoursesTableFilterComposer,
    $$ContinuingEducationCoursesTableOrderingComposer,
    $$ContinuingEducationCoursesTableAnnotationComposer,
    $$ContinuingEducationCoursesTableCreateCompanionBuilder,
    $$ContinuingEducationCoursesTableUpdateCompanionBuilder,
    (
      ContinuingEducationCourse,
      BaseReferences<_$AppDatabase, $ContinuingEducationCoursesTable,
          ContinuingEducationCourse>
    ),
    ContinuingEducationCourse,
    PrefetchHooks Function()> {
  $$ContinuingEducationCoursesTableTableManager(
      _$AppDatabase db, $ContinuingEducationCoursesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContinuingEducationCoursesTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$ContinuingEducationCoursesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContinuingEducationCoursesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> provider = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<int?> durationHours = const Value.absent(),
            Value<String?> externalUrl = const Value.absent(),
          }) =>
              ContinuingEducationCoursesCompanion(
            id: id,
            title: title,
            provider: provider,
            description: description,
            category: category,
            durationHours: durationHours,
            externalUrl: externalUrl,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String provider,
            Value<String?> description = const Value.absent(),
            required String category,
            Value<int?> durationHours = const Value.absent(),
            Value<String?> externalUrl = const Value.absent(),
          }) =>
              ContinuingEducationCoursesCompanion.insert(
            id: id,
            title: title,
            provider: provider,
            description: description,
            category: category,
            durationHours: durationHours,
            externalUrl: externalUrl,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ContinuingEducationCoursesTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ContinuingEducationCoursesTable,
        ContinuingEducationCourse,
        $$ContinuingEducationCoursesTableFilterComposer,
        $$ContinuingEducationCoursesTableOrderingComposer,
        $$ContinuingEducationCoursesTableAnnotationComposer,
        $$ContinuingEducationCoursesTableCreateCompanionBuilder,
        $$ContinuingEducationCoursesTableUpdateCompanionBuilder,
        (
          ContinuingEducationCourse,
          BaseReferences<_$AppDatabase, $ContinuingEducationCoursesTable,
              ContinuingEducationCourse>
        ),
        ContinuingEducationCourse,
        PrefetchHooks Function()>;
typedef $$UserCourseEnrollmentsTableCreateCompanionBuilder
    = UserCourseEnrollmentsCompanion Function({
  Value<int> id,
  required int userId,
  required int courseId,
  required DateTime enrolledAt,
  Value<DateTime?> completedAt,
  required String status,
});
typedef $$UserCourseEnrollmentsTableUpdateCompanionBuilder
    = UserCourseEnrollmentsCompanion Function({
  Value<int> id,
  Value<int> userId,
  Value<int> courseId,
  Value<DateTime> enrolledAt,
  Value<DateTime?> completedAt,
  Value<String> status,
});

class $$UserCourseEnrollmentsTableFilterComposer
    extends Composer<_$AppDatabase, $UserCourseEnrollmentsTable> {
  $$UserCourseEnrollmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get courseId => $composableBuilder(
      column: $table.courseId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get enrolledAt => $composableBuilder(
      column: $table.enrolledAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));
}

class $$UserCourseEnrollmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserCourseEnrollmentsTable> {
  $$UserCourseEnrollmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get courseId => $composableBuilder(
      column: $table.courseId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get enrolledAt => $composableBuilder(
      column: $table.enrolledAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));
}

class $$UserCourseEnrollmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserCourseEnrollmentsTable> {
  $$UserCourseEnrollmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get courseId =>
      $composableBuilder(column: $table.courseId, builder: (column) => column);

  GeneratedColumn<DateTime> get enrolledAt => $composableBuilder(
      column: $table.enrolledAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$UserCourseEnrollmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserCourseEnrollmentsTable,
    UserCourseEnrollment,
    $$UserCourseEnrollmentsTableFilterComposer,
    $$UserCourseEnrollmentsTableOrderingComposer,
    $$UserCourseEnrollmentsTableAnnotationComposer,
    $$UserCourseEnrollmentsTableCreateCompanionBuilder,
    $$UserCourseEnrollmentsTableUpdateCompanionBuilder,
    (
      UserCourseEnrollment,
      BaseReferences<_$AppDatabase, $UserCourseEnrollmentsTable,
          UserCourseEnrollment>
    ),
    UserCourseEnrollment,
    PrefetchHooks Function()> {
  $$UserCourseEnrollmentsTableTableManager(
      _$AppDatabase db, $UserCourseEnrollmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserCourseEnrollmentsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$UserCourseEnrollmentsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserCourseEnrollmentsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<int> courseId = const Value.absent(),
            Value<DateTime> enrolledAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              UserCourseEnrollmentsCompanion(
            id: id,
            userId: userId,
            courseId: courseId,
            enrolledAt: enrolledAt,
            completedAt: completedAt,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int userId,
            required int courseId,
            required DateTime enrolledAt,
            Value<DateTime?> completedAt = const Value.absent(),
            required String status,
          }) =>
              UserCourseEnrollmentsCompanion.insert(
            id: id,
            userId: userId,
            courseId: courseId,
            enrolledAt: enrolledAt,
            completedAt: completedAt,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserCourseEnrollmentsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $UserCourseEnrollmentsTable,
        UserCourseEnrollment,
        $$UserCourseEnrollmentsTableFilterComposer,
        $$UserCourseEnrollmentsTableOrderingComposer,
        $$UserCourseEnrollmentsTableAnnotationComposer,
        $$UserCourseEnrollmentsTableCreateCompanionBuilder,
        $$UserCourseEnrollmentsTableUpdateCompanionBuilder,
        (
          UserCourseEnrollment,
          BaseReferences<_$AppDatabase, $UserCourseEnrollmentsTable,
              UserCourseEnrollment>
        ),
        UserCourseEnrollment,
        PrefetchHooks Function()>;
typedef $$ExpensesTableCreateCompanionBuilder = ExpensesCompanion Function({
  Value<int> id,
  required int userId,
  required DateTime expenseDate,
  required String category,
  required double amount,
  Value<String?> description,
  Value<String?> receiptPath,
  Value<int?> workOrderId,
});
typedef $$ExpensesTableUpdateCompanionBuilder = ExpensesCompanion Function({
  Value<int> id,
  Value<int> userId,
  Value<DateTime> expenseDate,
  Value<String> category,
  Value<double> amount,
  Value<String?> description,
  Value<String?> receiptPath,
  Value<int?> workOrderId,
});

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get expenseDate => $composableBuilder(
      column: $table.expenseDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get receiptPath => $composableBuilder(
      column: $table.receiptPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get workOrderId => $composableBuilder(
      column: $table.workOrderId, builder: (column) => ColumnFilters(column));
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expenseDate => $composableBuilder(
      column: $table.expenseDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get receiptPath => $composableBuilder(
      column: $table.receiptPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get workOrderId => $composableBuilder(
      column: $table.workOrderId, builder: (column) => ColumnOrderings(column));
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get expenseDate => $composableBuilder(
      column: $table.expenseDate, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get receiptPath => $composableBuilder(
      column: $table.receiptPath, builder: (column) => column);

  GeneratedColumn<int> get workOrderId => $composableBuilder(
      column: $table.workOrderId, builder: (column) => column);
}

class $$ExpensesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExpensesTable,
    Expense,
    $$ExpensesTableFilterComposer,
    $$ExpensesTableOrderingComposer,
    $$ExpensesTableAnnotationComposer,
    $$ExpensesTableCreateCompanionBuilder,
    $$ExpensesTableUpdateCompanionBuilder,
    (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
    Expense,
    PrefetchHooks Function()> {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<DateTime> expenseDate = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> receiptPath = const Value.absent(),
            Value<int?> workOrderId = const Value.absent(),
          }) =>
              ExpensesCompanion(
            id: id,
            userId: userId,
            expenseDate: expenseDate,
            category: category,
            amount: amount,
            description: description,
            receiptPath: receiptPath,
            workOrderId: workOrderId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int userId,
            required DateTime expenseDate,
            required String category,
            required double amount,
            Value<String?> description = const Value.absent(),
            Value<String?> receiptPath = const Value.absent(),
            Value<int?> workOrderId = const Value.absent(),
          }) =>
              ExpensesCompanion.insert(
            id: id,
            userId: userId,
            expenseDate: expenseDate,
            category: category,
            amount: amount,
            description: description,
            receiptPath: receiptPath,
            workOrderId: workOrderId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ExpensesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExpensesTable,
    Expense,
    $$ExpensesTableFilterComposer,
    $$ExpensesTableOrderingComposer,
    $$ExpensesTableAnnotationComposer,
    $$ExpensesTableCreateCompanionBuilder,
    $$ExpensesTableUpdateCompanionBuilder,
    (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
    Expense,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db, _db.clients);
  $$SitesTableTableManager get sites =>
      $$SitesTableTableManager(_db, _db.sites);
  $$StartingPointsTableTableManager get startingPoints =>
      $$StartingPointsTableTableManager(_db, _db.startingPoints);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$WeatherSnapshotTableTableManager get weatherSnapshot =>
      $$WeatherSnapshotTableTableManager(_db, _db.weatherSnapshot);
  $$TrafficSnapshotTableTableManager get trafficSnapshot =>
      $$TrafficSnapshotTableTableManager(_db, _db.trafficSnapshot);
  $$WorkCallsTableTableManager get workCalls =>
      $$WorkCallsTableTableManager(_db, _db.workCalls);
  $$IndustryBriefingTableTableManager get industryBriefing =>
      $$IndustryBriefingTableTableManager(_db, _db.industryBriefing);
  $$CompanyAnnouncementsTableTableManager get companyAnnouncements =>
      $$CompanyAnnouncementsTableTableManager(_db, _db.companyAnnouncements);
  $$WorkOrdersTableTableManager get workOrders =>
      $$WorkOrdersTableTableManager(_db, _db.workOrders);
  $$AppointmentsTableTableManager get appointments =>
      $$AppointmentsTableTableManager(_db, _db.appointments);
  $$EquipmentTableTableManager get equipment =>
      $$EquipmentTableTableManager(_db, _db.equipment);
  $$WorkOrderEquipmentTableTableManager get workOrderEquipment =>
      $$WorkOrderEquipmentTableTableManager(_db, _db.workOrderEquipment);
  $$WorkPerformedTableTableManager get workPerformed =>
      $$WorkPerformedTableTableManager(_db, _db.workPerformed);
  $$PartsUsedTableTableManager get partsUsed =>
      $$PartsUsedTableTableManager(_db, _db.partsUsed);
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db, _db.notes);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db, _db.documents);
  $$KnowledgeEntriesTableTableManager get knowledgeEntries =>
      $$KnowledgeEntriesTableTableManager(_db, _db.knowledgeEntries);
  $$KnowledgeCategoriesTableTableManager get knowledgeCategories =>
      $$KnowledgeCategoriesTableTableManager(_db, _db.knowledgeCategories);
  $$KnowledgeTagsTableTableManager get knowledgeTags =>
      $$KnowledgeTagsTableTableManager(_db, _db.knowledgeTags);
  $$EntryTagsTableTableManager get entryTags =>
      $$EntryTagsTableTableManager(_db, _db.entryTags);
  $$EntryMetadataTableTableManager get entryMetadata =>
      $$EntryMetadataTableTableManager(_db, _db.entryMetadata);
  $$KnowledgeAttachmentsTableTableManager get knowledgeAttachments =>
      $$KnowledgeAttachmentsTableTableManager(_db, _db.knowledgeAttachments);
  $$KnowledgeHistoryTableTableManager get knowledgeHistory =>
      $$KnowledgeHistoryTableTableManager(_db, _db.knowledgeHistory);
  $$KnowledgeRelationsTableTableManager get knowledgeRelations =>
      $$KnowledgeRelationsTableTableManager(_db, _db.knowledgeRelations);
  $$MachineProfilesTableTableManager get machineProfiles =>
      $$MachineProfilesTableTableManager(_db, _db.machineProfiles);
  $$ContinuingEducationCoursesTableTableManager
      get continuingEducationCourses =>
          $$ContinuingEducationCoursesTableTableManager(
              _db, _db.continuingEducationCourses);
  $$UserCourseEnrollmentsTableTableManager get userCourseEnrollments =>
      $$UserCourseEnrollmentsTableTableManager(_db, _db.userCourseEnrollments);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
}
