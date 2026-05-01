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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mainContactMeta = const VerificationMeta(
    'mainContact',
  );
  @override
  late final GeneratedColumn<String> mainContact = GeneratedColumn<String>(
    'main_contact',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contractStatusMeta = const VerificationMeta(
    'contractStatus',
  );
  @override
  late final GeneratedColumn<String> contractStatus = GeneratedColumn<String>(
    'contract_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _themeColorMeta = const VerificationMeta(
    'themeColor',
  );
  @override
  late final GeneratedColumn<String> themeColor = GeneratedColumn<String>(
    'theme_color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    mainContact,
    contractStatus,
    themeColor,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clients';
  @override
  VerificationContext validateIntegrity(
    Insertable<Client> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('main_contact')) {
      context.handle(
        _mainContactMeta,
        mainContact.isAcceptableOrUnknown(
          data['main_contact']!,
          _mainContactMeta,
        ),
      );
    }
    if (data.containsKey('contract_status')) {
      context.handle(
        _contractStatusMeta,
        contractStatus.isAcceptableOrUnknown(
          data['contract_status']!,
          _contractStatusMeta,
        ),
      );
    }
    if (data.containsKey('theme_color')) {
      context.handle(
        _themeColorMeta,
        themeColor.isAcceptableOrUnknown(data['theme_color']!, _themeColorMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Client map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Client(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      mainContact: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}main_contact'],
      ),
      contractStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contract_status'],
      ),
      themeColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_color'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ClientsTable createAlias(String alias) {
    return $ClientsTable(attachedDatabase, alias);
  }
}

class Client extends DataClass implements Insertable<Client> {
  final String id;
  final String name;
  final String? mainContact;
  final String? contractStatus;
  final String? themeColor;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Client({
    required this.id,
    required this.name,
    this.mainContact,
    this.contractStatus,
    this.themeColor,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || mainContact != null) {
      map['main_contact'] = Variable<String>(mainContact);
    }
    if (!nullToAbsent || contractStatus != null) {
      map['contract_status'] = Variable<String>(contractStatus);
    }
    if (!nullToAbsent || themeColor != null) {
      map['theme_color'] = Variable<String>(themeColor);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ClientsCompanion toCompanion(bool nullToAbsent) {
    return ClientsCompanion(
      id: Value(id),
      name: Value(name),
      mainContact: mainContact == null && nullToAbsent
          ? const Value.absent()
          : Value(mainContact),
      contractStatus: contractStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(contractStatus),
      themeColor: themeColor == null && nullToAbsent
          ? const Value.absent()
          : Value(themeColor),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Client.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Client(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      mainContact: serializer.fromJson<String?>(json['mainContact']),
      contractStatus: serializer.fromJson<String?>(json['contractStatus']),
      themeColor: serializer.fromJson<String?>(json['themeColor']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'mainContact': serializer.toJson<String?>(mainContact),
      'contractStatus': serializer.toJson<String?>(contractStatus),
      'themeColor': serializer.toJson<String?>(themeColor),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Client copyWith({
    String? id,
    String? name,
    Value<String?> mainContact = const Value.absent(),
    Value<String?> contractStatus = const Value.absent(),
    Value<String?> themeColor = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Client(
    id: id ?? this.id,
    name: name ?? this.name,
    mainContact: mainContact.present ? mainContact.value : this.mainContact,
    contractStatus: contractStatus.present
        ? contractStatus.value
        : this.contractStatus,
    themeColor: themeColor.present ? themeColor.value : this.themeColor,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Client copyWithCompanion(ClientsCompanion data) {
    return Client(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      mainContact: data.mainContact.present
          ? data.mainContact.value
          : this.mainContact,
      contractStatus: data.contractStatus.present
          ? data.contractStatus.value
          : this.contractStatus,
      themeColor: data.themeColor.present
          ? data.themeColor.value
          : this.themeColor,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Client(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('mainContact: $mainContact, ')
          ..write('contractStatus: $contractStatus, ')
          ..write('themeColor: $themeColor, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    mainContact,
    contractStatus,
    themeColor,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Client &&
          other.id == this.id &&
          other.name == this.name &&
          other.mainContact == this.mainContact &&
          other.contractStatus == this.contractStatus &&
          other.themeColor == this.themeColor &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ClientsCompanion extends UpdateCompanion<Client> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> mainContact;
  final Value<String?> contractStatus;
  final Value<String?> themeColor;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ClientsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.mainContact = const Value.absent(),
    this.contractStatus = const Value.absent(),
    this.themeColor = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClientsCompanion.insert({
    required String id,
    required String name,
    this.mainContact = const Value.absent(),
    this.contractStatus = const Value.absent(),
    this.themeColor = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<Client> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? mainContact,
    Expression<String>? contractStatus,
    Expression<String>? themeColor,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (mainContact != null) 'main_contact': mainContact,
      if (contractStatus != null) 'contract_status': contractStatus,
      if (themeColor != null) 'theme_color': themeColor,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClientsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? mainContact,
    Value<String?>? contractStatus,
    Value<String?>? themeColor,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ClientsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      mainContact: mainContact ?? this.mainContact,
      contractStatus: contractStatus ?? this.contractStatus,
      themeColor: themeColor ?? this.themeColor,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (mainContact.present) {
      map['main_contact'] = Variable<String>(mainContact.value);
    }
    if (contractStatus.present) {
      map['contract_status'] = Variable<String>(contractStatus.value);
    }
    if (themeColor.present) {
      map['theme_color'] = Variable<String>(themeColor.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('mainContact: $mainContact, ')
          ..write('contractStatus: $contractStatus, ')
          ..write('themeColor: $themeColor, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocationsTable extends Locations
    with TableInfo<$LocationsTable, Location> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientNameMeta = const VerificationMeta(
    'clientName',
  );
  @override
  late final GeneratedColumn<String> clientName = GeneratedColumn<String>(
    'client_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchNameMeta = const VerificationMeta(
    'branchName',
  );
  @override
  late final GeneratedColumn<String> branchName = GeneratedColumn<String>(
    'branch_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressLine1Meta = const VerificationMeta(
    'addressLine1',
  );
  @override
  late final GeneratedColumn<String> addressLine1 = GeneratedColumn<String>(
    'address_line1',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressLine2Meta = const VerificationMeta(
    'addressLine2',
  );
  @override
  late final GeneratedColumn<String> addressLine2 = GeneratedColumn<String>(
    'address_line2',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _zipMeta = const VerificationMeta('zip');
  @override
  late final GeneratedColumn<String> zip = GeneratedColumn<String>(
    'zip',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressFullMeta = const VerificationMeta(
    'addressFull',
  );
  @override
  late final GeneratedColumn<String> addressFull = GeneratedColumn<String>(
    'address_full',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _googlePlaceIdMeta = const VerificationMeta(
    'googlePlaceId',
  );
  @override
  late final GeneratedColumn<String> googlePlaceId = GeneratedColumn<String>(
    'google_place_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _regionIdMeta = const VerificationMeta(
    'regionId',
  );
  @override
  late final GeneratedColumn<String> regionId = GeneratedColumn<String>(
    'region_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _operatingHoursMeta = const VerificationMeta(
    'operatingHours',
  );
  @override
  late final GeneratedColumn<String> operatingHours = GeneratedColumn<String>(
    'operating_hours',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _restrictionsMeta = const VerificationMeta(
    'restrictions',
  );
  @override
  late final GeneratedColumn<String> restrictions = GeneratedColumn<String>(
    'restrictions',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timezoneMeta = const VerificationMeta(
    'timezone',
  );
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
    'timezone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pinColorMeta = const VerificationMeta(
    'pinColor',
  );
  @override
  late final GeneratedColumn<String> pinColor = GeneratedColumn<String>(
    'pin_color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('green'),
  );
  static const VerificationMeta _lastVisitDateMeta = const VerificationMeta(
    'lastVisitDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastVisitDate =
      GeneratedColumn<DateTime>(
        'last_visit_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nextPMDateMeta = const VerificationMeta(
    'nextPMDate',
  );
  @override
  late final GeneratedColumn<DateTime> nextPMDate = GeneratedColumn<DateTime>(
    'next_p_m_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    clientName,
    branchName,
    addressLine1,
    addressLine2,
    city,
    state,
    zip,
    addressFull,
    latitude,
    longitude,
    googlePlaceId,
    regionId,
    operatingHours,
    restrictions,
    notes,
    timezone,
    pinColor,
    status,
    lastVisitDate,
    nextPMDate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'locations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Location> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('client_name')) {
      context.handle(
        _clientNameMeta,
        clientName.isAcceptableOrUnknown(data['client_name']!, _clientNameMeta),
      );
    } else if (isInserting) {
      context.missing(_clientNameMeta);
    }
    if (data.containsKey('branch_name')) {
      context.handle(
        _branchNameMeta,
        branchName.isAcceptableOrUnknown(data['branch_name']!, _branchNameMeta),
      );
    } else if (isInserting) {
      context.missing(_branchNameMeta);
    }
    if (data.containsKey('address_line1')) {
      context.handle(
        _addressLine1Meta,
        addressLine1.isAcceptableOrUnknown(
          data['address_line1']!,
          _addressLine1Meta,
        ),
      );
    } else if (isInserting) {
      context.missing(_addressLine1Meta);
    }
    if (data.containsKey('address_line2')) {
      context.handle(
        _addressLine2Meta,
        addressLine2.isAcceptableOrUnknown(
          data['address_line2']!,
          _addressLine2Meta,
        ),
      );
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('zip')) {
      context.handle(
        _zipMeta,
        zip.isAcceptableOrUnknown(data['zip']!, _zipMeta),
      );
    } else if (isInserting) {
      context.missing(_zipMeta);
    }
    if (data.containsKey('address_full')) {
      context.handle(
        _addressFullMeta,
        addressFull.isAcceptableOrUnknown(
          data['address_full']!,
          _addressFullMeta,
        ),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('google_place_id')) {
      context.handle(
        _googlePlaceIdMeta,
        googlePlaceId.isAcceptableOrUnknown(
          data['google_place_id']!,
          _googlePlaceIdMeta,
        ),
      );
    }
    if (data.containsKey('region_id')) {
      context.handle(
        _regionIdMeta,
        regionId.isAcceptableOrUnknown(data['region_id']!, _regionIdMeta),
      );
    }
    if (data.containsKey('operating_hours')) {
      context.handle(
        _operatingHoursMeta,
        operatingHours.isAcceptableOrUnknown(
          data['operating_hours']!,
          _operatingHoursMeta,
        ),
      );
    }
    if (data.containsKey('restrictions')) {
      context.handle(
        _restrictionsMeta,
        restrictions.isAcceptableOrUnknown(
          data['restrictions']!,
          _restrictionsMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('timezone')) {
      context.handle(
        _timezoneMeta,
        timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta),
      );
    }
    if (data.containsKey('pin_color')) {
      context.handle(
        _pinColorMeta,
        pinColor.isAcceptableOrUnknown(data['pin_color']!, _pinColorMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('last_visit_date')) {
      context.handle(
        _lastVisitDateMeta,
        lastVisitDate.isAcceptableOrUnknown(
          data['last_visit_date']!,
          _lastVisitDateMeta,
        ),
      );
    }
    if (data.containsKey('next_p_m_date')) {
      context.handle(
        _nextPMDateMeta,
        nextPMDate.isAcceptableOrUnknown(
          data['next_p_m_date']!,
          _nextPMDateMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Location map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Location(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      clientName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_name'],
      )!,
      branchName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_name'],
      )!,
      addressLine1: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_line1'],
      )!,
      addressLine2: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_line2'],
      ),
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      zip: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}zip'],
      )!,
      addressFull: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_full'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      googlePlaceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}google_place_id'],
      ),
      regionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region_id'],
      ),
      operatingHours: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operating_hours'],
      ),
      restrictions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}restrictions'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      timezone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}timezone'],
      ),
      pinColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pin_color'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      lastVisitDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_visit_date'],
      ),
      nextPMDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_p_m_date'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LocationsTable createAlias(String alias) {
    return $LocationsTable(attachedDatabase, alias);
  }
}

class Location extends DataClass implements Insertable<Location> {
  final String id;
  final String clientId;
  final String clientName;
  final String branchName;
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String state;
  final String zip;
  final String? addressFull;
  final double? latitude;
  final double? longitude;
  final String? googlePlaceId;
  final String? regionId;
  final String? operatingHours;
  final String? restrictions;
  final String? notes;
  final String? timezone;
  final String? pinColor;
  final String status;
  final DateTime? lastVisitDate;
  final DateTime? nextPMDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Location({
    required this.id,
    required this.clientId,
    required this.clientName,
    required this.branchName,
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    required this.state,
    required this.zip,
    this.addressFull,
    this.latitude,
    this.longitude,
    this.googlePlaceId,
    this.regionId,
    this.operatingHours,
    this.restrictions,
    this.notes,
    this.timezone,
    this.pinColor,
    required this.status,
    this.lastVisitDate,
    this.nextPMDate,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['client_id'] = Variable<String>(clientId);
    map['client_name'] = Variable<String>(clientName);
    map['branch_name'] = Variable<String>(branchName);
    map['address_line1'] = Variable<String>(addressLine1);
    if (!nullToAbsent || addressLine2 != null) {
      map['address_line2'] = Variable<String>(addressLine2);
    }
    map['city'] = Variable<String>(city);
    map['state'] = Variable<String>(state);
    map['zip'] = Variable<String>(zip);
    if (!nullToAbsent || addressFull != null) {
      map['address_full'] = Variable<String>(addressFull);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || googlePlaceId != null) {
      map['google_place_id'] = Variable<String>(googlePlaceId);
    }
    if (!nullToAbsent || regionId != null) {
      map['region_id'] = Variable<String>(regionId);
    }
    if (!nullToAbsent || operatingHours != null) {
      map['operating_hours'] = Variable<String>(operatingHours);
    }
    if (!nullToAbsent || restrictions != null) {
      map['restrictions'] = Variable<String>(restrictions);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || timezone != null) {
      map['timezone'] = Variable<String>(timezone);
    }
    if (!nullToAbsent || pinColor != null) {
      map['pin_color'] = Variable<String>(pinColor);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || lastVisitDate != null) {
      map['last_visit_date'] = Variable<DateTime>(lastVisitDate);
    }
    if (!nullToAbsent || nextPMDate != null) {
      map['next_p_m_date'] = Variable<DateTime>(nextPMDate);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocationsCompanion toCompanion(bool nullToAbsent) {
    return LocationsCompanion(
      id: Value(id),
      clientId: Value(clientId),
      clientName: Value(clientName),
      branchName: Value(branchName),
      addressLine1: Value(addressLine1),
      addressLine2: addressLine2 == null && nullToAbsent
          ? const Value.absent()
          : Value(addressLine2),
      city: Value(city),
      state: Value(state),
      zip: Value(zip),
      addressFull: addressFull == null && nullToAbsent
          ? const Value.absent()
          : Value(addressFull),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      googlePlaceId: googlePlaceId == null && nullToAbsent
          ? const Value.absent()
          : Value(googlePlaceId),
      regionId: regionId == null && nullToAbsent
          ? const Value.absent()
          : Value(regionId),
      operatingHours: operatingHours == null && nullToAbsent
          ? const Value.absent()
          : Value(operatingHours),
      restrictions: restrictions == null && nullToAbsent
          ? const Value.absent()
          : Value(restrictions),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      timezone: timezone == null && nullToAbsent
          ? const Value.absent()
          : Value(timezone),
      pinColor: pinColor == null && nullToAbsent
          ? const Value.absent()
          : Value(pinColor),
      status: Value(status),
      lastVisitDate: lastVisitDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastVisitDate),
      nextPMDate: nextPMDate == null && nullToAbsent
          ? const Value.absent()
          : Value(nextPMDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Location.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Location(
      id: serializer.fromJson<String>(json['id']),
      clientId: serializer.fromJson<String>(json['clientId']),
      clientName: serializer.fromJson<String>(json['clientName']),
      branchName: serializer.fromJson<String>(json['branchName']),
      addressLine1: serializer.fromJson<String>(json['addressLine1']),
      addressLine2: serializer.fromJson<String?>(json['addressLine2']),
      city: serializer.fromJson<String>(json['city']),
      state: serializer.fromJson<String>(json['state']),
      zip: serializer.fromJson<String>(json['zip']),
      addressFull: serializer.fromJson<String?>(json['addressFull']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      googlePlaceId: serializer.fromJson<String?>(json['googlePlaceId']),
      regionId: serializer.fromJson<String?>(json['regionId']),
      operatingHours: serializer.fromJson<String?>(json['operatingHours']),
      restrictions: serializer.fromJson<String?>(json['restrictions']),
      notes: serializer.fromJson<String?>(json['notes']),
      timezone: serializer.fromJson<String?>(json['timezone']),
      pinColor: serializer.fromJson<String?>(json['pinColor']),
      status: serializer.fromJson<String>(json['status']),
      lastVisitDate: serializer.fromJson<DateTime?>(json['lastVisitDate']),
      nextPMDate: serializer.fromJson<DateTime?>(json['nextPMDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'clientId': serializer.toJson<String>(clientId),
      'clientName': serializer.toJson<String>(clientName),
      'branchName': serializer.toJson<String>(branchName),
      'addressLine1': serializer.toJson<String>(addressLine1),
      'addressLine2': serializer.toJson<String?>(addressLine2),
      'city': serializer.toJson<String>(city),
      'state': serializer.toJson<String>(state),
      'zip': serializer.toJson<String>(zip),
      'addressFull': serializer.toJson<String?>(addressFull),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'googlePlaceId': serializer.toJson<String?>(googlePlaceId),
      'regionId': serializer.toJson<String?>(regionId),
      'operatingHours': serializer.toJson<String?>(operatingHours),
      'restrictions': serializer.toJson<String?>(restrictions),
      'notes': serializer.toJson<String?>(notes),
      'timezone': serializer.toJson<String?>(timezone),
      'pinColor': serializer.toJson<String?>(pinColor),
      'status': serializer.toJson<String>(status),
      'lastVisitDate': serializer.toJson<DateTime?>(lastVisitDate),
      'nextPMDate': serializer.toJson<DateTime?>(nextPMDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Location copyWith({
    String? id,
    String? clientId,
    String? clientName,
    String? branchName,
    String? addressLine1,
    Value<String?> addressLine2 = const Value.absent(),
    String? city,
    String? state,
    String? zip,
    Value<String?> addressFull = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<String?> googlePlaceId = const Value.absent(),
    Value<String?> regionId = const Value.absent(),
    Value<String?> operatingHours = const Value.absent(),
    Value<String?> restrictions = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> timezone = const Value.absent(),
    Value<String?> pinColor = const Value.absent(),
    String? status,
    Value<DateTime?> lastVisitDate = const Value.absent(),
    Value<DateTime?> nextPMDate = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Location(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    clientName: clientName ?? this.clientName,
    branchName: branchName ?? this.branchName,
    addressLine1: addressLine1 ?? this.addressLine1,
    addressLine2: addressLine2.present ? addressLine2.value : this.addressLine2,
    city: city ?? this.city,
    state: state ?? this.state,
    zip: zip ?? this.zip,
    addressFull: addressFull.present ? addressFull.value : this.addressFull,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    googlePlaceId: googlePlaceId.present
        ? googlePlaceId.value
        : this.googlePlaceId,
    regionId: regionId.present ? regionId.value : this.regionId,
    operatingHours: operatingHours.present
        ? operatingHours.value
        : this.operatingHours,
    restrictions: restrictions.present ? restrictions.value : this.restrictions,
    notes: notes.present ? notes.value : this.notes,
    timezone: timezone.present ? timezone.value : this.timezone,
    pinColor: pinColor.present ? pinColor.value : this.pinColor,
    status: status ?? this.status,
    lastVisitDate: lastVisitDate.present
        ? lastVisitDate.value
        : this.lastVisitDate,
    nextPMDate: nextPMDate.present ? nextPMDate.value : this.nextPMDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Location copyWithCompanion(LocationsCompanion data) {
    return Location(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      clientName: data.clientName.present
          ? data.clientName.value
          : this.clientName,
      branchName: data.branchName.present
          ? data.branchName.value
          : this.branchName,
      addressLine1: data.addressLine1.present
          ? data.addressLine1.value
          : this.addressLine1,
      addressLine2: data.addressLine2.present
          ? data.addressLine2.value
          : this.addressLine2,
      city: data.city.present ? data.city.value : this.city,
      state: data.state.present ? data.state.value : this.state,
      zip: data.zip.present ? data.zip.value : this.zip,
      addressFull: data.addressFull.present
          ? data.addressFull.value
          : this.addressFull,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      googlePlaceId: data.googlePlaceId.present
          ? data.googlePlaceId.value
          : this.googlePlaceId,
      regionId: data.regionId.present ? data.regionId.value : this.regionId,
      operatingHours: data.operatingHours.present
          ? data.operatingHours.value
          : this.operatingHours,
      restrictions: data.restrictions.present
          ? data.restrictions.value
          : this.restrictions,
      notes: data.notes.present ? data.notes.value : this.notes,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      pinColor: data.pinColor.present ? data.pinColor.value : this.pinColor,
      status: data.status.present ? data.status.value : this.status,
      lastVisitDate: data.lastVisitDate.present
          ? data.lastVisitDate.value
          : this.lastVisitDate,
      nextPMDate: data.nextPMDate.present
          ? data.nextPMDate.value
          : this.nextPMDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Location(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('clientName: $clientName, ')
          ..write('branchName: $branchName, ')
          ..write('addressLine1: $addressLine1, ')
          ..write('addressLine2: $addressLine2, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('zip: $zip, ')
          ..write('addressFull: $addressFull, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('googlePlaceId: $googlePlaceId, ')
          ..write('regionId: $regionId, ')
          ..write('operatingHours: $operatingHours, ')
          ..write('restrictions: $restrictions, ')
          ..write('notes: $notes, ')
          ..write('timezone: $timezone, ')
          ..write('pinColor: $pinColor, ')
          ..write('status: $status, ')
          ..write('lastVisitDate: $lastVisitDate, ')
          ..write('nextPMDate: $nextPMDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    clientId,
    clientName,
    branchName,
    addressLine1,
    addressLine2,
    city,
    state,
    zip,
    addressFull,
    latitude,
    longitude,
    googlePlaceId,
    regionId,
    operatingHours,
    restrictions,
    notes,
    timezone,
    pinColor,
    status,
    lastVisitDate,
    nextPMDate,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Location &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.clientName == this.clientName &&
          other.branchName == this.branchName &&
          other.addressLine1 == this.addressLine1 &&
          other.addressLine2 == this.addressLine2 &&
          other.city == this.city &&
          other.state == this.state &&
          other.zip == this.zip &&
          other.addressFull == this.addressFull &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.googlePlaceId == this.googlePlaceId &&
          other.regionId == this.regionId &&
          other.operatingHours == this.operatingHours &&
          other.restrictions == this.restrictions &&
          other.notes == this.notes &&
          other.timezone == this.timezone &&
          other.pinColor == this.pinColor &&
          other.status == this.status &&
          other.lastVisitDate == this.lastVisitDate &&
          other.nextPMDate == this.nextPMDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocationsCompanion extends UpdateCompanion<Location> {
  final Value<String> id;
  final Value<String> clientId;
  final Value<String> clientName;
  final Value<String> branchName;
  final Value<String> addressLine1;
  final Value<String?> addressLine2;
  final Value<String> city;
  final Value<String> state;
  final Value<String> zip;
  final Value<String?> addressFull;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> googlePlaceId;
  final Value<String?> regionId;
  final Value<String?> operatingHours;
  final Value<String?> restrictions;
  final Value<String?> notes;
  final Value<String?> timezone;
  final Value<String?> pinColor;
  final Value<String> status;
  final Value<DateTime?> lastVisitDate;
  final Value<DateTime?> nextPMDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LocationsCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.clientName = const Value.absent(),
    this.branchName = const Value.absent(),
    this.addressLine1 = const Value.absent(),
    this.addressLine2 = const Value.absent(),
    this.city = const Value.absent(),
    this.state = const Value.absent(),
    this.zip = const Value.absent(),
    this.addressFull = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.googlePlaceId = const Value.absent(),
    this.regionId = const Value.absent(),
    this.operatingHours = const Value.absent(),
    this.restrictions = const Value.absent(),
    this.notes = const Value.absent(),
    this.timezone = const Value.absent(),
    this.pinColor = const Value.absent(),
    this.status = const Value.absent(),
    this.lastVisitDate = const Value.absent(),
    this.nextPMDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocationsCompanion.insert({
    required String id,
    required String clientId,
    required String clientName,
    required String branchName,
    required String addressLine1,
    this.addressLine2 = const Value.absent(),
    required String city,
    required String state,
    required String zip,
    this.addressFull = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.googlePlaceId = const Value.absent(),
    this.regionId = const Value.absent(),
    this.operatingHours = const Value.absent(),
    this.restrictions = const Value.absent(),
    this.notes = const Value.absent(),
    this.timezone = const Value.absent(),
    this.pinColor = const Value.absent(),
    this.status = const Value.absent(),
    this.lastVisitDate = const Value.absent(),
    this.nextPMDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       clientId = Value(clientId),
       clientName = Value(clientName),
       branchName = Value(branchName),
       addressLine1 = Value(addressLine1),
       city = Value(city),
       state = Value(state),
       zip = Value(zip);
  static Insertable<Location> custom({
    Expression<String>? id,
    Expression<String>? clientId,
    Expression<String>? clientName,
    Expression<String>? branchName,
    Expression<String>? addressLine1,
    Expression<String>? addressLine2,
    Expression<String>? city,
    Expression<String>? state,
    Expression<String>? zip,
    Expression<String>? addressFull,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? googlePlaceId,
    Expression<String>? regionId,
    Expression<String>? operatingHours,
    Expression<String>? restrictions,
    Expression<String>? notes,
    Expression<String>? timezone,
    Expression<String>? pinColor,
    Expression<String>? status,
    Expression<DateTime>? lastVisitDate,
    Expression<DateTime>? nextPMDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (clientName != null) 'client_name': clientName,
      if (branchName != null) 'branch_name': branchName,
      if (addressLine1 != null) 'address_line1': addressLine1,
      if (addressLine2 != null) 'address_line2': addressLine2,
      if (city != null) 'city': city,
      if (state != null) 'state': state,
      if (zip != null) 'zip': zip,
      if (addressFull != null) 'address_full': addressFull,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (googlePlaceId != null) 'google_place_id': googlePlaceId,
      if (regionId != null) 'region_id': regionId,
      if (operatingHours != null) 'operating_hours': operatingHours,
      if (restrictions != null) 'restrictions': restrictions,
      if (notes != null) 'notes': notes,
      if (timezone != null) 'timezone': timezone,
      if (pinColor != null) 'pin_color': pinColor,
      if (status != null) 'status': status,
      if (lastVisitDate != null) 'last_visit_date': lastVisitDate,
      if (nextPMDate != null) 'next_p_m_date': nextPMDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocationsCompanion copyWith({
    Value<String>? id,
    Value<String>? clientId,
    Value<String>? clientName,
    Value<String>? branchName,
    Value<String>? addressLine1,
    Value<String?>? addressLine2,
    Value<String>? city,
    Value<String>? state,
    Value<String>? zip,
    Value<String?>? addressFull,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<String?>? googlePlaceId,
    Value<String?>? regionId,
    Value<String?>? operatingHours,
    Value<String?>? restrictions,
    Value<String?>? notes,
    Value<String?>? timezone,
    Value<String?>? pinColor,
    Value<String>? status,
    Value<DateTime?>? lastVisitDate,
    Value<DateTime?>? nextPMDate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return LocationsCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      branchName: branchName ?? this.branchName,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      city: city ?? this.city,
      state: state ?? this.state,
      zip: zip ?? this.zip,
      addressFull: addressFull ?? this.addressFull,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      googlePlaceId: googlePlaceId ?? this.googlePlaceId,
      regionId: regionId ?? this.regionId,
      operatingHours: operatingHours ?? this.operatingHours,
      restrictions: restrictions ?? this.restrictions,
      notes: notes ?? this.notes,
      timezone: timezone ?? this.timezone,
      pinColor: pinColor ?? this.pinColor,
      status: status ?? this.status,
      lastVisitDate: lastVisitDate ?? this.lastVisitDate,
      nextPMDate: nextPMDate ?? this.nextPMDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (clientName.present) {
      map['client_name'] = Variable<String>(clientName.value);
    }
    if (branchName.present) {
      map['branch_name'] = Variable<String>(branchName.value);
    }
    if (addressLine1.present) {
      map['address_line1'] = Variable<String>(addressLine1.value);
    }
    if (addressLine2.present) {
      map['address_line2'] = Variable<String>(addressLine2.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (zip.present) {
      map['zip'] = Variable<String>(zip.value);
    }
    if (addressFull.present) {
      map['address_full'] = Variable<String>(addressFull.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (googlePlaceId.present) {
      map['google_place_id'] = Variable<String>(googlePlaceId.value);
    }
    if (regionId.present) {
      map['region_id'] = Variable<String>(regionId.value);
    }
    if (operatingHours.present) {
      map['operating_hours'] = Variable<String>(operatingHours.value);
    }
    if (restrictions.present) {
      map['restrictions'] = Variable<String>(restrictions.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (pinColor.present) {
      map['pin_color'] = Variable<String>(pinColor.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (lastVisitDate.present) {
      map['last_visit_date'] = Variable<DateTime>(lastVisitDate.value);
    }
    if (nextPMDate.present) {
      map['next_p_m_date'] = Variable<DateTime>(nextPMDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationsCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('clientName: $clientName, ')
          ..write('branchName: $branchName, ')
          ..write('addressLine1: $addressLine1, ')
          ..write('addressLine2: $addressLine2, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('zip: $zip, ')
          ..write('addressFull: $addressFull, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('googlePlaceId: $googlePlaceId, ')
          ..write('regionId: $regionId, ')
          ..write('operatingHours: $operatingHours, ')
          ..write('restrictions: $restrictions, ')
          ..write('notes: $notes, ')
          ..write('timezone: $timezone, ')
          ..write('pinColor: $pinColor, ')
          ..write('status: $status, ')
          ..write('lastVisitDate: $lastVisitDate, ')
          ..write('nextPMDate: $nextPMDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serialNumberMeta = const VerificationMeta(
    'serialNumber',
  );
  @override
  late final GeneratedColumn<String> serialNumber = GeneratedColumn<String>(
    'serial_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _equipmentTypeMeta = const VerificationMeta(
    'equipmentType',
  );
  @override
  late final GeneratedColumn<String> equipmentType = GeneratedColumn<String>(
    'equipment_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('operational'),
  );
  static const VerificationMeta _locationIdMeta = const VerificationMeta(
    'locationId',
  );
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
    'location_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _installDateMeta = const VerificationMeta(
    'installDate',
  );
  @override
  late final GeneratedColumn<DateTime> installDate = GeneratedColumn<DateTime>(
    'install_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastServiceDateMeta = const VerificationMeta(
    'lastServiceDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastServiceDate =
      GeneratedColumn<DateTime>(
        'last_service_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nextServiceDateMeta = const VerificationMeta(
    'nextServiceDate',
  );
  @override
  late final GeneratedColumn<DateTime> nextServiceDate =
      GeneratedColumn<DateTime>(
        'next_service_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _warrantyInfoMeta = const VerificationMeta(
    'warrantyInfo',
  );
  @override
  late final GeneratedColumn<String> warrantyInfo = GeneratedColumn<String>(
    'warranty_info',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _vendorMeta = const VerificationMeta('vendor');
  @override
  late final GeneratedColumn<String> vendor = GeneratedColumn<String>(
    'vendor',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchaseOrderIdMeta = const VerificationMeta(
    'purchaseOrderId',
  );
  @override
  late final GeneratedColumn<String> purchaseOrderId = GeneratedColumn<String>(
    'purchase_order_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _assetTagMeta = const VerificationMeta(
    'assetTag',
  );
  @override
  late final GeneratedColumn<String> assetTag = GeneratedColumn<String>(
    'asset_tag',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serialNumber,
    model,
    equipmentType,
    status,
    locationId,
    clientId,
    branchId,
    installDate,
    lastServiceDate,
    nextServiceDate,
    notes,
    warrantyInfo,
    vendor,
    purchaseOrderId,
    assetTag,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'equipment';
  @override
  VerificationContext validateIntegrity(
    Insertable<EquipmentData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('serial_number')) {
      context.handle(
        _serialNumberMeta,
        serialNumber.isAcceptableOrUnknown(
          data['serial_number']!,
          _serialNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serialNumberMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('equipment_type')) {
      context.handle(
        _equipmentTypeMeta,
        equipmentType.isAcceptableOrUnknown(
          data['equipment_type']!,
          _equipmentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_equipmentTypeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('location_id')) {
      context.handle(
        _locationIdMeta,
        locationId.isAcceptableOrUnknown(data['location_id']!, _locationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_locationIdMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    }
    if (data.containsKey('install_date')) {
      context.handle(
        _installDateMeta,
        installDate.isAcceptableOrUnknown(
          data['install_date']!,
          _installDateMeta,
        ),
      );
    }
    if (data.containsKey('last_service_date')) {
      context.handle(
        _lastServiceDateMeta,
        lastServiceDate.isAcceptableOrUnknown(
          data['last_service_date']!,
          _lastServiceDateMeta,
        ),
      );
    }
    if (data.containsKey('next_service_date')) {
      context.handle(
        _nextServiceDateMeta,
        nextServiceDate.isAcceptableOrUnknown(
          data['next_service_date']!,
          _nextServiceDateMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('warranty_info')) {
      context.handle(
        _warrantyInfoMeta,
        warrantyInfo.isAcceptableOrUnknown(
          data['warranty_info']!,
          _warrantyInfoMeta,
        ),
      );
    }
    if (data.containsKey('vendor')) {
      context.handle(
        _vendorMeta,
        vendor.isAcceptableOrUnknown(data['vendor']!, _vendorMeta),
      );
    }
    if (data.containsKey('purchase_order_id')) {
      context.handle(
        _purchaseOrderIdMeta,
        purchaseOrderId.isAcceptableOrUnknown(
          data['purchase_order_id']!,
          _purchaseOrderIdMeta,
        ),
      );
    }
    if (data.containsKey('asset_tag')) {
      context.handle(
        _assetTagMeta,
        assetTag.isAcceptableOrUnknown(data['asset_tag']!, _assetTagMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EquipmentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EquipmentData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      serialNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}serial_number'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      equipmentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}equipment_type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      locationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      ),
      installDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}install_date'],
      ),
      lastServiceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_service_date'],
      ),
      nextServiceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_service_date'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      warrantyInfo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}warranty_info'],
      ),
      vendor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vendor'],
      ),
      purchaseOrderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_order_id'],
      ),
      assetTag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_tag'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $EquipmentTable createAlias(String alias) {
    return $EquipmentTable(attachedDatabase, alias);
  }
}

class EquipmentData extends DataClass implements Insertable<EquipmentData> {
  final String id;
  final String serialNumber;
  final String model;
  final String equipmentType;
  final String status;
  final String locationId;
  final String clientId;
  final String? branchId;
  final DateTime? installDate;
  final DateTime? lastServiceDate;
  final DateTime? nextServiceDate;
  final String? notes;
  final String? warrantyInfo;
  final String? vendor;
  final String? purchaseOrderId;
  final String? assetTag;
  final DateTime createdAt;
  final DateTime updatedAt;
  const EquipmentData({
    required this.id,
    required this.serialNumber,
    required this.model,
    required this.equipmentType,
    required this.status,
    required this.locationId,
    required this.clientId,
    this.branchId,
    this.installDate,
    this.lastServiceDate,
    this.nextServiceDate,
    this.notes,
    this.warrantyInfo,
    this.vendor,
    this.purchaseOrderId,
    this.assetTag,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['serial_number'] = Variable<String>(serialNumber);
    map['model'] = Variable<String>(model);
    map['equipment_type'] = Variable<String>(equipmentType);
    map['status'] = Variable<String>(status);
    map['location_id'] = Variable<String>(locationId);
    map['client_id'] = Variable<String>(clientId);
    if (!nullToAbsent || branchId != null) {
      map['branch_id'] = Variable<String>(branchId);
    }
    if (!nullToAbsent || installDate != null) {
      map['install_date'] = Variable<DateTime>(installDate);
    }
    if (!nullToAbsent || lastServiceDate != null) {
      map['last_service_date'] = Variable<DateTime>(lastServiceDate);
    }
    if (!nullToAbsent || nextServiceDate != null) {
      map['next_service_date'] = Variable<DateTime>(nextServiceDate);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || warrantyInfo != null) {
      map['warranty_info'] = Variable<String>(warrantyInfo);
    }
    if (!nullToAbsent || vendor != null) {
      map['vendor'] = Variable<String>(vendor);
    }
    if (!nullToAbsent || purchaseOrderId != null) {
      map['purchase_order_id'] = Variable<String>(purchaseOrderId);
    }
    if (!nullToAbsent || assetTag != null) {
      map['asset_tag'] = Variable<String>(assetTag);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  EquipmentCompanion toCompanion(bool nullToAbsent) {
    return EquipmentCompanion(
      id: Value(id),
      serialNumber: Value(serialNumber),
      model: Value(model),
      equipmentType: Value(equipmentType),
      status: Value(status),
      locationId: Value(locationId),
      clientId: Value(clientId),
      branchId: branchId == null && nullToAbsent
          ? const Value.absent()
          : Value(branchId),
      installDate: installDate == null && nullToAbsent
          ? const Value.absent()
          : Value(installDate),
      lastServiceDate: lastServiceDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastServiceDate),
      nextServiceDate: nextServiceDate == null && nullToAbsent
          ? const Value.absent()
          : Value(nextServiceDate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      warrantyInfo: warrantyInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(warrantyInfo),
      vendor: vendor == null && nullToAbsent
          ? const Value.absent()
          : Value(vendor),
      purchaseOrderId: purchaseOrderId == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseOrderId),
      assetTag: assetTag == null && nullToAbsent
          ? const Value.absent()
          : Value(assetTag),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory EquipmentData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EquipmentData(
      id: serializer.fromJson<String>(json['id']),
      serialNumber: serializer.fromJson<String>(json['serialNumber']),
      model: serializer.fromJson<String>(json['model']),
      equipmentType: serializer.fromJson<String>(json['equipmentType']),
      status: serializer.fromJson<String>(json['status']),
      locationId: serializer.fromJson<String>(json['locationId']),
      clientId: serializer.fromJson<String>(json['clientId']),
      branchId: serializer.fromJson<String?>(json['branchId']),
      installDate: serializer.fromJson<DateTime?>(json['installDate']),
      lastServiceDate: serializer.fromJson<DateTime?>(json['lastServiceDate']),
      nextServiceDate: serializer.fromJson<DateTime?>(json['nextServiceDate']),
      notes: serializer.fromJson<String?>(json['notes']),
      warrantyInfo: serializer.fromJson<String?>(json['warrantyInfo']),
      vendor: serializer.fromJson<String?>(json['vendor']),
      purchaseOrderId: serializer.fromJson<String?>(json['purchaseOrderId']),
      assetTag: serializer.fromJson<String?>(json['assetTag']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'serialNumber': serializer.toJson<String>(serialNumber),
      'model': serializer.toJson<String>(model),
      'equipmentType': serializer.toJson<String>(equipmentType),
      'status': serializer.toJson<String>(status),
      'locationId': serializer.toJson<String>(locationId),
      'clientId': serializer.toJson<String>(clientId),
      'branchId': serializer.toJson<String?>(branchId),
      'installDate': serializer.toJson<DateTime?>(installDate),
      'lastServiceDate': serializer.toJson<DateTime?>(lastServiceDate),
      'nextServiceDate': serializer.toJson<DateTime?>(nextServiceDate),
      'notes': serializer.toJson<String?>(notes),
      'warrantyInfo': serializer.toJson<String?>(warrantyInfo),
      'vendor': serializer.toJson<String?>(vendor),
      'purchaseOrderId': serializer.toJson<String?>(purchaseOrderId),
      'assetTag': serializer.toJson<String?>(assetTag),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  EquipmentData copyWith({
    String? id,
    String? serialNumber,
    String? model,
    String? equipmentType,
    String? status,
    String? locationId,
    String? clientId,
    Value<String?> branchId = const Value.absent(),
    Value<DateTime?> installDate = const Value.absent(),
    Value<DateTime?> lastServiceDate = const Value.absent(),
    Value<DateTime?> nextServiceDate = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> warrantyInfo = const Value.absent(),
    Value<String?> vendor = const Value.absent(),
    Value<String?> purchaseOrderId = const Value.absent(),
    Value<String?> assetTag = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => EquipmentData(
    id: id ?? this.id,
    serialNumber: serialNumber ?? this.serialNumber,
    model: model ?? this.model,
    equipmentType: equipmentType ?? this.equipmentType,
    status: status ?? this.status,
    locationId: locationId ?? this.locationId,
    clientId: clientId ?? this.clientId,
    branchId: branchId.present ? branchId.value : this.branchId,
    installDate: installDate.present ? installDate.value : this.installDate,
    lastServiceDate: lastServiceDate.present
        ? lastServiceDate.value
        : this.lastServiceDate,
    nextServiceDate: nextServiceDate.present
        ? nextServiceDate.value
        : this.nextServiceDate,
    notes: notes.present ? notes.value : this.notes,
    warrantyInfo: warrantyInfo.present ? warrantyInfo.value : this.warrantyInfo,
    vendor: vendor.present ? vendor.value : this.vendor,
    purchaseOrderId: purchaseOrderId.present
        ? purchaseOrderId.value
        : this.purchaseOrderId,
    assetTag: assetTag.present ? assetTag.value : this.assetTag,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  EquipmentData copyWithCompanion(EquipmentCompanion data) {
    return EquipmentData(
      id: data.id.present ? data.id.value : this.id,
      serialNumber: data.serialNumber.present
          ? data.serialNumber.value
          : this.serialNumber,
      model: data.model.present ? data.model.value : this.model,
      equipmentType: data.equipmentType.present
          ? data.equipmentType.value
          : this.equipmentType,
      status: data.status.present ? data.status.value : this.status,
      locationId: data.locationId.present
          ? data.locationId.value
          : this.locationId,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      installDate: data.installDate.present
          ? data.installDate.value
          : this.installDate,
      lastServiceDate: data.lastServiceDate.present
          ? data.lastServiceDate.value
          : this.lastServiceDate,
      nextServiceDate: data.nextServiceDate.present
          ? data.nextServiceDate.value
          : this.nextServiceDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      warrantyInfo: data.warrantyInfo.present
          ? data.warrantyInfo.value
          : this.warrantyInfo,
      vendor: data.vendor.present ? data.vendor.value : this.vendor,
      purchaseOrderId: data.purchaseOrderId.present
          ? data.purchaseOrderId.value
          : this.purchaseOrderId,
      assetTag: data.assetTag.present ? data.assetTag.value : this.assetTag,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentData(')
          ..write('id: $id, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('model: $model, ')
          ..write('equipmentType: $equipmentType, ')
          ..write('status: $status, ')
          ..write('locationId: $locationId, ')
          ..write('clientId: $clientId, ')
          ..write('branchId: $branchId, ')
          ..write('installDate: $installDate, ')
          ..write('lastServiceDate: $lastServiceDate, ')
          ..write('nextServiceDate: $nextServiceDate, ')
          ..write('notes: $notes, ')
          ..write('warrantyInfo: $warrantyInfo, ')
          ..write('vendor: $vendor, ')
          ..write('purchaseOrderId: $purchaseOrderId, ')
          ..write('assetTag: $assetTag, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serialNumber,
    model,
    equipmentType,
    status,
    locationId,
    clientId,
    branchId,
    installDate,
    lastServiceDate,
    nextServiceDate,
    notes,
    warrantyInfo,
    vendor,
    purchaseOrderId,
    assetTag,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EquipmentData &&
          other.id == this.id &&
          other.serialNumber == this.serialNumber &&
          other.model == this.model &&
          other.equipmentType == this.equipmentType &&
          other.status == this.status &&
          other.locationId == this.locationId &&
          other.clientId == this.clientId &&
          other.branchId == this.branchId &&
          other.installDate == this.installDate &&
          other.lastServiceDate == this.lastServiceDate &&
          other.nextServiceDate == this.nextServiceDate &&
          other.notes == this.notes &&
          other.warrantyInfo == this.warrantyInfo &&
          other.vendor == this.vendor &&
          other.purchaseOrderId == this.purchaseOrderId &&
          other.assetTag == this.assetTag &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class EquipmentCompanion extends UpdateCompanion<EquipmentData> {
  final Value<String> id;
  final Value<String> serialNumber;
  final Value<String> model;
  final Value<String> equipmentType;
  final Value<String> status;
  final Value<String> locationId;
  final Value<String> clientId;
  final Value<String?> branchId;
  final Value<DateTime?> installDate;
  final Value<DateTime?> lastServiceDate;
  final Value<DateTime?> nextServiceDate;
  final Value<String?> notes;
  final Value<String?> warrantyInfo;
  final Value<String?> vendor;
  final Value<String?> purchaseOrderId;
  final Value<String?> assetTag;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const EquipmentCompanion({
    this.id = const Value.absent(),
    this.serialNumber = const Value.absent(),
    this.model = const Value.absent(),
    this.equipmentType = const Value.absent(),
    this.status = const Value.absent(),
    this.locationId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.installDate = const Value.absent(),
    this.lastServiceDate = const Value.absent(),
    this.nextServiceDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.warrantyInfo = const Value.absent(),
    this.vendor = const Value.absent(),
    this.purchaseOrderId = const Value.absent(),
    this.assetTag = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EquipmentCompanion.insert({
    required String id,
    required String serialNumber,
    required String model,
    required String equipmentType,
    this.status = const Value.absent(),
    required String locationId,
    required String clientId,
    this.branchId = const Value.absent(),
    this.installDate = const Value.absent(),
    this.lastServiceDate = const Value.absent(),
    this.nextServiceDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.warrantyInfo = const Value.absent(),
    this.vendor = const Value.absent(),
    this.purchaseOrderId = const Value.absent(),
    this.assetTag = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       serialNumber = Value(serialNumber),
       model = Value(model),
       equipmentType = Value(equipmentType),
       locationId = Value(locationId),
       clientId = Value(clientId);
  static Insertable<EquipmentData> custom({
    Expression<String>? id,
    Expression<String>? serialNumber,
    Expression<String>? model,
    Expression<String>? equipmentType,
    Expression<String>? status,
    Expression<String>? locationId,
    Expression<String>? clientId,
    Expression<String>? branchId,
    Expression<DateTime>? installDate,
    Expression<DateTime>? lastServiceDate,
    Expression<DateTime>? nextServiceDate,
    Expression<String>? notes,
    Expression<String>? warrantyInfo,
    Expression<String>? vendor,
    Expression<String>? purchaseOrderId,
    Expression<String>? assetTag,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serialNumber != null) 'serial_number': serialNumber,
      if (model != null) 'model': model,
      if (equipmentType != null) 'equipment_type': equipmentType,
      if (status != null) 'status': status,
      if (locationId != null) 'location_id': locationId,
      if (clientId != null) 'client_id': clientId,
      if (branchId != null) 'branch_id': branchId,
      if (installDate != null) 'install_date': installDate,
      if (lastServiceDate != null) 'last_service_date': lastServiceDate,
      if (nextServiceDate != null) 'next_service_date': nextServiceDate,
      if (notes != null) 'notes': notes,
      if (warrantyInfo != null) 'warranty_info': warrantyInfo,
      if (vendor != null) 'vendor': vendor,
      if (purchaseOrderId != null) 'purchase_order_id': purchaseOrderId,
      if (assetTag != null) 'asset_tag': assetTag,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EquipmentCompanion copyWith({
    Value<String>? id,
    Value<String>? serialNumber,
    Value<String>? model,
    Value<String>? equipmentType,
    Value<String>? status,
    Value<String>? locationId,
    Value<String>? clientId,
    Value<String?>? branchId,
    Value<DateTime?>? installDate,
    Value<DateTime?>? lastServiceDate,
    Value<DateTime?>? nextServiceDate,
    Value<String?>? notes,
    Value<String?>? warrantyInfo,
    Value<String?>? vendor,
    Value<String?>? purchaseOrderId,
    Value<String?>? assetTag,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return EquipmentCompanion(
      id: id ?? this.id,
      serialNumber: serialNumber ?? this.serialNumber,
      model: model ?? this.model,
      equipmentType: equipmentType ?? this.equipmentType,
      status: status ?? this.status,
      locationId: locationId ?? this.locationId,
      clientId: clientId ?? this.clientId,
      branchId: branchId ?? this.branchId,
      installDate: installDate ?? this.installDate,
      lastServiceDate: lastServiceDate ?? this.lastServiceDate,
      nextServiceDate: nextServiceDate ?? this.nextServiceDate,
      notes: notes ?? this.notes,
      warrantyInfo: warrantyInfo ?? this.warrantyInfo,
      vendor: vendor ?? this.vendor,
      purchaseOrderId: purchaseOrderId ?? this.purchaseOrderId,
      assetTag: assetTag ?? this.assetTag,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (serialNumber.present) {
      map['serial_number'] = Variable<String>(serialNumber.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (equipmentType.present) {
      map['equipment_type'] = Variable<String>(equipmentType.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (installDate.present) {
      map['install_date'] = Variable<DateTime>(installDate.value);
    }
    if (lastServiceDate.present) {
      map['last_service_date'] = Variable<DateTime>(lastServiceDate.value);
    }
    if (nextServiceDate.present) {
      map['next_service_date'] = Variable<DateTime>(nextServiceDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (warrantyInfo.present) {
      map['warranty_info'] = Variable<String>(warrantyInfo.value);
    }
    if (vendor.present) {
      map['vendor'] = Variable<String>(vendor.value);
    }
    if (purchaseOrderId.present) {
      map['purchase_order_id'] = Variable<String>(purchaseOrderId.value);
    }
    if (assetTag.present) {
      map['asset_tag'] = Variable<String>(assetTag.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentCompanion(')
          ..write('id: $id, ')
          ..write('serialNumber: $serialNumber, ')
          ..write('model: $model, ')
          ..write('equipmentType: $equipmentType, ')
          ..write('status: $status, ')
          ..write('locationId: $locationId, ')
          ..write('clientId: $clientId, ')
          ..write('branchId: $branchId, ')
          ..write('installDate: $installDate, ')
          ..write('lastServiceDate: $lastServiceDate, ')
          ..write('nextServiceDate: $nextServiceDate, ')
          ..write('notes: $notes, ')
          ..write('warrantyInfo: $warrantyInfo, ')
          ..write('vendor: $vendor, ')
          ..write('purchaseOrderId: $purchaseOrderId, ')
          ..write('assetTag: $assetTag, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
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
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchNameMeta = const VerificationMeta(
    'branchName',
  );
  @override
  late final GeneratedColumn<String> branchName = GeneratedColumn<String>(
    'branch_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lobbyHoursMeta = const VerificationMeta(
    'lobbyHours',
  );
  @override
  late final GeneratedColumn<String> lobbyHours = GeneratedColumn<String>(
    'lobby_hours',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('South_Texas'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    branchName,
    address,
    latitude,
    longitude,
    lobbyHours,
    region,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sites';
  @override
  VerificationContext validateIntegrity(
    Insertable<Site> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('branch_name')) {
      context.handle(
        _branchNameMeta,
        branchName.isAcceptableOrUnknown(data['branch_name']!, _branchNameMeta),
      );
    } else if (isInserting) {
      context.missing(_branchNameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('lobby_hours')) {
      context.handle(
        _lobbyHoursMeta,
        lobbyHours.isAcceptableOrUnknown(data['lobby_hours']!, _lobbyHoursMeta),
      );
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Site map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Site(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      branchName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      lobbyHours: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lobby_hours'],
      ),
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      )!,
    );
  }

  @override
  $SitesTable createAlias(String alias) {
    return $SitesTable(attachedDatabase, alias);
  }
}

class Site extends DataClass implements Insertable<Site> {
  final int id;
  final String clientId;
  final String branchName;
  final String address;
  final double latitude;
  final double longitude;
  final String? lobbyHours;
  final String region;
  const Site({
    required this.id,
    required this.clientId,
    required this.branchName,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.lobbyHours,
    required this.region,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_id'] = Variable<String>(clientId);
    map['branch_name'] = Variable<String>(branchName);
    map['address'] = Variable<String>(address);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    if (!nullToAbsent || lobbyHours != null) {
      map['lobby_hours'] = Variable<String>(lobbyHours);
    }
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
      lobbyHours: lobbyHours == null && nullToAbsent
          ? const Value.absent()
          : Value(lobbyHours),
      region: Value(region),
    );
  }

  factory Site.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Site(
      id: serializer.fromJson<int>(json['id']),
      clientId: serializer.fromJson<String>(json['clientId']),
      branchName: serializer.fromJson<String>(json['branchName']),
      address: serializer.fromJson<String>(json['address']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      lobbyHours: serializer.fromJson<String?>(json['lobbyHours']),
      region: serializer.fromJson<String>(json['region']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientId': serializer.toJson<String>(clientId),
      'branchName': serializer.toJson<String>(branchName),
      'address': serializer.toJson<String>(address),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'lobbyHours': serializer.toJson<String?>(lobbyHours),
      'region': serializer.toJson<String>(region),
    };
  }

  Site copyWith({
    int? id,
    String? clientId,
    String? branchName,
    String? address,
    double? latitude,
    double? longitude,
    Value<String?> lobbyHours = const Value.absent(),
    String? region,
  }) => Site(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    branchName: branchName ?? this.branchName,
    address: address ?? this.address,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    lobbyHours: lobbyHours.present ? lobbyHours.value : this.lobbyHours,
    region: region ?? this.region,
  );
  Site copyWithCompanion(SitesCompanion data) {
    return Site(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      branchName: data.branchName.present
          ? data.branchName.value
          : this.branchName,
      address: data.address.present ? data.address.value : this.address,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      lobbyHours: data.lobbyHours.present
          ? data.lobbyHours.value
          : this.lobbyHours,
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
          ..write('lobbyHours: $lobbyHours, ')
          ..write('region: $region')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientId,
    branchName,
    address,
    latitude,
    longitude,
    lobbyHours,
    region,
  );
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
          other.lobbyHours == this.lobbyHours &&
          other.region == this.region);
}

class SitesCompanion extends UpdateCompanion<Site> {
  final Value<int> id;
  final Value<String> clientId;
  final Value<String> branchName;
  final Value<String> address;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<String?> lobbyHours;
  final Value<String> region;
  const SitesCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.branchName = const Value.absent(),
    this.address = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.lobbyHours = const Value.absent(),
    this.region = const Value.absent(),
  });
  SitesCompanion.insert({
    this.id = const Value.absent(),
    required String clientId,
    required String branchName,
    required String address,
    required double latitude,
    required double longitude,
    this.lobbyHours = const Value.absent(),
    this.region = const Value.absent(),
  }) : clientId = Value(clientId),
       branchName = Value(branchName),
       address = Value(address),
       latitude = Value(latitude),
       longitude = Value(longitude);
  static Insertable<Site> custom({
    Expression<int>? id,
    Expression<String>? clientId,
    Expression<String>? branchName,
    Expression<String>? address,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? lobbyHours,
    Expression<String>? region,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (branchName != null) 'branch_name': branchName,
      if (address != null) 'address': address,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (lobbyHours != null) 'lobby_hours': lobbyHours,
      if (region != null) 'region': region,
    });
  }

  SitesCompanion copyWith({
    Value<int>? id,
    Value<String>? clientId,
    Value<String>? branchName,
    Value<String>? address,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<String?>? lobbyHours,
    Value<String>? region,
  }) {
    return SitesCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      branchName: branchName ?? this.branchName,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      lobbyHours: lobbyHours ?? this.lobbyHours,
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
      map['client_id'] = Variable<String>(clientId.value);
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
    if (lobbyHours.present) {
      map['lobby_hours'] = Variable<String>(lobbyHours.value);
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
          ..write('lobbyHours: $lobbyHours, ')
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
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, latitude, longitude];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'starting_points';
  @override
  VerificationContext validateIntegrity(
    Insertable<StartingPoint> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
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
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
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
  const StartingPoint({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });
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

  factory StartingPoint.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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

  StartingPoint copyWith({
    int? id,
    String? name,
    double? latitude,
    double? longitude,
  }) => StartingPoint(
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
  }) : name = Value(name),
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

  StartingPointsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<double>? latitude,
    Value<double>? longitude,
  }) {
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClientsTable clients = $ClientsTable(this);
  late final $LocationsTable locations = $LocationsTable(this);
  late final $EquipmentTable equipment = $EquipmentTable(this);
  late final $SitesTable sites = $SitesTable(this);
  late final $StartingPointsTable startingPoints = $StartingPointsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    clients,
    locations,
    equipment,
    sites,
    startingPoints,
  ];
}

typedef $$ClientsTableCreateCompanionBuilder =
    ClientsCompanion Function({
      required String id,
      required String name,
      Value<String?> mainContact,
      Value<String?> contractStatus,
      Value<String?> themeColor,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$ClientsTableUpdateCompanionBuilder =
    ClientsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> mainContact,
      Value<String?> contractStatus,
      Value<String?> themeColor,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ClientsTableFilterComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mainContact => $composableBuilder(
    column: $table.mainContact,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contractStatus => $composableBuilder(
    column: $table.contractStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeColor => $composableBuilder(
    column: $table.themeColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
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
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mainContact => $composableBuilder(
    column: $table.mainContact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contractStatus => $composableBuilder(
    column: $table.contractStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeColor => $composableBuilder(
    column: $table.themeColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get mainContact => $composableBuilder(
    column: $table.mainContact,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contractStatus => $composableBuilder(
    column: $table.contractStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeColor => $composableBuilder(
    column: $table.themeColor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ClientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientsTable,
          Client,
          $$ClientsTableFilterComposer,
          $$ClientsTableOrderingComposer,
          $$ClientsTableAnnotationComposer,
          $$ClientsTableCreateCompanionBuilder,
          $$ClientsTableUpdateCompanionBuilder,
          (Client, BaseReferences<_$AppDatabase, $ClientsTable, Client>),
          Client,
          PrefetchHooks Function()
        > {
  $$ClientsTableTableManager(_$AppDatabase db, $ClientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> mainContact = const Value.absent(),
                Value<String?> contractStatus = const Value.absent(),
                Value<String?> themeColor = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClientsCompanion(
                id: id,
                name: name,
                mainContact: mainContact,
                contractStatus: contractStatus,
                themeColor: themeColor,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> mainContact = const Value.absent(),
                Value<String?> contractStatus = const Value.absent(),
                Value<String?> themeColor = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClientsCompanion.insert(
                id: id,
                name: name,
                mainContact: mainContact,
                contractStatus: contractStatus,
                themeColor: themeColor,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ClientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientsTable,
      Client,
      $$ClientsTableFilterComposer,
      $$ClientsTableOrderingComposer,
      $$ClientsTableAnnotationComposer,
      $$ClientsTableCreateCompanionBuilder,
      $$ClientsTableUpdateCompanionBuilder,
      (Client, BaseReferences<_$AppDatabase, $ClientsTable, Client>),
      Client,
      PrefetchHooks Function()
    >;
typedef $$LocationsTableCreateCompanionBuilder =
    LocationsCompanion Function({
      required String id,
      required String clientId,
      required String clientName,
      required String branchName,
      required String addressLine1,
      Value<String?> addressLine2,
      required String city,
      required String state,
      required String zip,
      Value<String?> addressFull,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> googlePlaceId,
      Value<String?> regionId,
      Value<String?> operatingHours,
      Value<String?> restrictions,
      Value<String?> notes,
      Value<String?> timezone,
      Value<String?> pinColor,
      Value<String> status,
      Value<DateTime?> lastVisitDate,
      Value<DateTime?> nextPMDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$LocationsTableUpdateCompanionBuilder =
    LocationsCompanion Function({
      Value<String> id,
      Value<String> clientId,
      Value<String> clientName,
      Value<String> branchName,
      Value<String> addressLine1,
      Value<String?> addressLine2,
      Value<String> city,
      Value<String> state,
      Value<String> zip,
      Value<String?> addressFull,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> googlePlaceId,
      Value<String?> regionId,
      Value<String?> operatingHours,
      Value<String?> restrictions,
      Value<String?> notes,
      Value<String?> timezone,
      Value<String?> pinColor,
      Value<String> status,
      Value<DateTime?> lastVisitDate,
      Value<DateTime?> nextPMDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$LocationsTableFilterComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressLine1 => $composableBuilder(
    column: $table.addressLine1,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressLine2 => $composableBuilder(
    column: $table.addressLine2,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get zip => $composableBuilder(
    column: $table.zip,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressFull => $composableBuilder(
    column: $table.addressFull,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get googlePlaceId => $composableBuilder(
    column: $table.googlePlaceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get regionId => $composableBuilder(
    column: $table.regionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operatingHours => $composableBuilder(
    column: $table.operatingHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get restrictions => $composableBuilder(
    column: $table.restrictions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pinColor => $composableBuilder(
    column: $table.pinColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastVisitDate => $composableBuilder(
    column: $table.lastVisitDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextPMDate => $composableBuilder(
    column: $table.nextPMDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressLine1 => $composableBuilder(
    column: $table.addressLine1,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressLine2 => $composableBuilder(
    column: $table.addressLine2,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get zip => $composableBuilder(
    column: $table.zip,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressFull => $composableBuilder(
    column: $table.addressFull,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get googlePlaceId => $composableBuilder(
    column: $table.googlePlaceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get regionId => $composableBuilder(
    column: $table.regionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operatingHours => $composableBuilder(
    column: $table.operatingHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get restrictions => $composableBuilder(
    column: $table.restrictions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timezone => $composableBuilder(
    column: $table.timezone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pinColor => $composableBuilder(
    column: $table.pinColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastVisitDate => $composableBuilder(
    column: $table.lastVisitDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextPMDate => $composableBuilder(
    column: $table.nextPMDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get clientName => $composableBuilder(
    column: $table.clientName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get addressLine1 => $composableBuilder(
    column: $table.addressLine1,
    builder: (column) => column,
  );

  GeneratedColumn<String> get addressLine2 => $composableBuilder(
    column: $table.addressLine2,
    builder: (column) => column,
  );

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get zip =>
      $composableBuilder(column: $table.zip, builder: (column) => column);

  GeneratedColumn<String> get addressFull => $composableBuilder(
    column: $table.addressFull,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get googlePlaceId => $composableBuilder(
    column: $table.googlePlaceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get regionId =>
      $composableBuilder(column: $table.regionId, builder: (column) => column);

  GeneratedColumn<String> get operatingHours => $composableBuilder(
    column: $table.operatingHours,
    builder: (column) => column,
  );

  GeneratedColumn<String> get restrictions => $composableBuilder(
    column: $table.restrictions,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<String> get pinColor =>
      $composableBuilder(column: $table.pinColor, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get lastVisitDate => $composableBuilder(
    column: $table.lastVisitDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextPMDate => $composableBuilder(
    column: $table.nextPMDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocationsTable,
          Location,
          $$LocationsTableFilterComposer,
          $$LocationsTableOrderingComposer,
          $$LocationsTableAnnotationComposer,
          $$LocationsTableCreateCompanionBuilder,
          $$LocationsTableUpdateCompanionBuilder,
          (Location, BaseReferences<_$AppDatabase, $LocationsTable, Location>),
          Location,
          PrefetchHooks Function()
        > {
  $$LocationsTableTableManager(_$AppDatabase db, $LocationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String> clientName = const Value.absent(),
                Value<String> branchName = const Value.absent(),
                Value<String> addressLine1 = const Value.absent(),
                Value<String?> addressLine2 = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<String> zip = const Value.absent(),
                Value<String?> addressFull = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> googlePlaceId = const Value.absent(),
                Value<String?> regionId = const Value.absent(),
                Value<String?> operatingHours = const Value.absent(),
                Value<String?> restrictions = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> timezone = const Value.absent(),
                Value<String?> pinColor = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> lastVisitDate = const Value.absent(),
                Value<DateTime?> nextPMDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocationsCompanion(
                id: id,
                clientId: clientId,
                clientName: clientName,
                branchName: branchName,
                addressLine1: addressLine1,
                addressLine2: addressLine2,
                city: city,
                state: state,
                zip: zip,
                addressFull: addressFull,
                latitude: latitude,
                longitude: longitude,
                googlePlaceId: googlePlaceId,
                regionId: regionId,
                operatingHours: operatingHours,
                restrictions: restrictions,
                notes: notes,
                timezone: timezone,
                pinColor: pinColor,
                status: status,
                lastVisitDate: lastVisitDate,
                nextPMDate: nextPMDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String clientId,
                required String clientName,
                required String branchName,
                required String addressLine1,
                Value<String?> addressLine2 = const Value.absent(),
                required String city,
                required String state,
                required String zip,
                Value<String?> addressFull = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> googlePlaceId = const Value.absent(),
                Value<String?> regionId = const Value.absent(),
                Value<String?> operatingHours = const Value.absent(),
                Value<String?> restrictions = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> timezone = const Value.absent(),
                Value<String?> pinColor = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> lastVisitDate = const Value.absent(),
                Value<DateTime?> nextPMDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocationsCompanion.insert(
                id: id,
                clientId: clientId,
                clientName: clientName,
                branchName: branchName,
                addressLine1: addressLine1,
                addressLine2: addressLine2,
                city: city,
                state: state,
                zip: zip,
                addressFull: addressFull,
                latitude: latitude,
                longitude: longitude,
                googlePlaceId: googlePlaceId,
                regionId: regionId,
                operatingHours: operatingHours,
                restrictions: restrictions,
                notes: notes,
                timezone: timezone,
                pinColor: pinColor,
                status: status,
                lastVisitDate: lastVisitDate,
                nextPMDate: nextPMDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocationsTable,
      Location,
      $$LocationsTableFilterComposer,
      $$LocationsTableOrderingComposer,
      $$LocationsTableAnnotationComposer,
      $$LocationsTableCreateCompanionBuilder,
      $$LocationsTableUpdateCompanionBuilder,
      (Location, BaseReferences<_$AppDatabase, $LocationsTable, Location>),
      Location,
      PrefetchHooks Function()
    >;
typedef $$EquipmentTableCreateCompanionBuilder =
    EquipmentCompanion Function({
      required String id,
      required String serialNumber,
      required String model,
      required String equipmentType,
      Value<String> status,
      required String locationId,
      required String clientId,
      Value<String?> branchId,
      Value<DateTime?> installDate,
      Value<DateTime?> lastServiceDate,
      Value<DateTime?> nextServiceDate,
      Value<String?> notes,
      Value<String?> warrantyInfo,
      Value<String?> vendor,
      Value<String?> purchaseOrderId,
      Value<String?> assetTag,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$EquipmentTableUpdateCompanionBuilder =
    EquipmentCompanion Function({
      Value<String> id,
      Value<String> serialNumber,
      Value<String> model,
      Value<String> equipmentType,
      Value<String> status,
      Value<String> locationId,
      Value<String> clientId,
      Value<String?> branchId,
      Value<DateTime?> installDate,
      Value<DateTime?> lastServiceDate,
      Value<DateTime?> nextServiceDate,
      Value<String?> notes,
      Value<String?> warrantyInfo,
      Value<String?> vendor,
      Value<String?> purchaseOrderId,
      Value<String?> assetTag,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
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
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get equipmentType => $composableBuilder(
    column: $table.equipmentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get installDate => $composableBuilder(
    column: $table.installDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastServiceDate => $composableBuilder(
    column: $table.lastServiceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextServiceDate => $composableBuilder(
    column: $table.nextServiceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get warrantyInfo => $composableBuilder(
    column: $table.warrantyInfo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vendor => $composableBuilder(
    column: $table.vendor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get purchaseOrderId => $composableBuilder(
    column: $table.purchaseOrderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetTag => $composableBuilder(
    column: $table.assetTag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
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
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get equipmentType => $composableBuilder(
    column: $table.equipmentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get installDate => $composableBuilder(
    column: $table.installDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastServiceDate => $composableBuilder(
    column: $table.lastServiceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextServiceDate => $composableBuilder(
    column: $table.nextServiceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get warrantyInfo => $composableBuilder(
    column: $table.warrantyInfo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vendor => $composableBuilder(
    column: $table.vendor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get purchaseOrderId => $composableBuilder(
    column: $table.purchaseOrderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetTag => $composableBuilder(
    column: $table.assetTag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serialNumber => $composableBuilder(
    column: $table.serialNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get equipmentType => $composableBuilder(
    column: $table.equipmentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get locationId => $composableBuilder(
    column: $table.locationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<DateTime> get installDate => $composableBuilder(
    column: $table.installDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastServiceDate => $composableBuilder(
    column: $table.lastServiceDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextServiceDate => $composableBuilder(
    column: $table.nextServiceDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get warrantyInfo => $composableBuilder(
    column: $table.warrantyInfo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get vendor =>
      $composableBuilder(column: $table.vendor, builder: (column) => column);

  GeneratedColumn<String> get purchaseOrderId => $composableBuilder(
    column: $table.purchaseOrderId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get assetTag =>
      $composableBuilder(column: $table.assetTag, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$EquipmentTableTableManager
    extends
        RootTableManager<
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
            BaseReferences<_$AppDatabase, $EquipmentTable, EquipmentData>,
          ),
          EquipmentData,
          PrefetchHooks Function()
        > {
  $$EquipmentTableTableManager(_$AppDatabase db, $EquipmentTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EquipmentTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EquipmentTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EquipmentTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> serialNumber = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<String> equipmentType = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> locationId = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String?> branchId = const Value.absent(),
                Value<DateTime?> installDate = const Value.absent(),
                Value<DateTime?> lastServiceDate = const Value.absent(),
                Value<DateTime?> nextServiceDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> warrantyInfo = const Value.absent(),
                Value<String?> vendor = const Value.absent(),
                Value<String?> purchaseOrderId = const Value.absent(),
                Value<String?> assetTag = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EquipmentCompanion(
                id: id,
                serialNumber: serialNumber,
                model: model,
                equipmentType: equipmentType,
                status: status,
                locationId: locationId,
                clientId: clientId,
                branchId: branchId,
                installDate: installDate,
                lastServiceDate: lastServiceDate,
                nextServiceDate: nextServiceDate,
                notes: notes,
                warrantyInfo: warrantyInfo,
                vendor: vendor,
                purchaseOrderId: purchaseOrderId,
                assetTag: assetTag,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String serialNumber,
                required String model,
                required String equipmentType,
                Value<String> status = const Value.absent(),
                required String locationId,
                required String clientId,
                Value<String?> branchId = const Value.absent(),
                Value<DateTime?> installDate = const Value.absent(),
                Value<DateTime?> lastServiceDate = const Value.absent(),
                Value<DateTime?> nextServiceDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> warrantyInfo = const Value.absent(),
                Value<String?> vendor = const Value.absent(),
                Value<String?> purchaseOrderId = const Value.absent(),
                Value<String?> assetTag = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EquipmentCompanion.insert(
                id: id,
                serialNumber: serialNumber,
                model: model,
                equipmentType: equipmentType,
                status: status,
                locationId: locationId,
                clientId: clientId,
                branchId: branchId,
                installDate: installDate,
                lastServiceDate: lastServiceDate,
                nextServiceDate: nextServiceDate,
                notes: notes,
                warrantyInfo: warrantyInfo,
                vendor: vendor,
                purchaseOrderId: purchaseOrderId,
                assetTag: assetTag,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EquipmentTableProcessedTableManager =
    ProcessedTableManager<
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
        BaseReferences<_$AppDatabase, $EquipmentTable, EquipmentData>,
      ),
      EquipmentData,
      PrefetchHooks Function()
    >;
typedef $$SitesTableCreateCompanionBuilder =
    SitesCompanion Function({
      Value<int> id,
      required String clientId,
      required String branchName,
      required String address,
      required double latitude,
      required double longitude,
      Value<String?> lobbyHours,
      Value<String> region,
    });
typedef $$SitesTableUpdateCompanionBuilder =
    SitesCompanion Function({
      Value<int> id,
      Value<String> clientId,
      Value<String> branchName,
      Value<String> address,
      Value<double> latitude,
      Value<double> longitude,
      Value<String?> lobbyHours,
      Value<String> region,
    });

class $$SitesTableFilterComposer extends Composer<_$AppDatabase, $SitesTable> {
  $$SitesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lobbyHours => $composableBuilder(
    column: $table.lobbyHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );
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
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lobbyHours => $composableBuilder(
    column: $table.lobbyHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );
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

  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get branchName => $composableBuilder(
    column: $table.branchName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get lobbyHours => $composableBuilder(
    column: $table.lobbyHours,
    builder: (column) => column,
  );

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);
}

class $$SitesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SitesTable,
          Site,
          $$SitesTableFilterComposer,
          $$SitesTableOrderingComposer,
          $$SitesTableAnnotationComposer,
          $$SitesTableCreateCompanionBuilder,
          $$SitesTableUpdateCompanionBuilder,
          (Site, BaseReferences<_$AppDatabase, $SitesTable, Site>),
          Site,
          PrefetchHooks Function()
        > {
  $$SitesTableTableManager(_$AppDatabase db, $SitesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SitesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SitesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SitesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String> branchName = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<String?> lobbyHours = const Value.absent(),
                Value<String> region = const Value.absent(),
              }) => SitesCompanion(
                id: id,
                clientId: clientId,
                branchName: branchName,
                address: address,
                latitude: latitude,
                longitude: longitude,
                lobbyHours: lobbyHours,
                region: region,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String clientId,
                required String branchName,
                required String address,
                required double latitude,
                required double longitude,
                Value<String?> lobbyHours = const Value.absent(),
                Value<String> region = const Value.absent(),
              }) => SitesCompanion.insert(
                id: id,
                clientId: clientId,
                branchName: branchName,
                address: address,
                latitude: latitude,
                longitude: longitude,
                lobbyHours: lobbyHours,
                region: region,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SitesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SitesTable,
      Site,
      $$SitesTableFilterComposer,
      $$SitesTableOrderingComposer,
      $$SitesTableAnnotationComposer,
      $$SitesTableCreateCompanionBuilder,
      $$SitesTableUpdateCompanionBuilder,
      (Site, BaseReferences<_$AppDatabase, $SitesTable, Site>),
      Site,
      PrefetchHooks Function()
    >;
typedef $$StartingPointsTableCreateCompanionBuilder =
    StartingPointsCompanion Function({
      Value<int> id,
      required String name,
      required double latitude,
      required double longitude,
    });
typedef $$StartingPointsTableUpdateCompanionBuilder =
    StartingPointsCompanion Function({
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
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );
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
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );
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

class $$StartingPointsTableTableManager
    extends
        RootTableManager<
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
            BaseReferences<_$AppDatabase, $StartingPointsTable, StartingPoint>,
          ),
          StartingPoint,
          PrefetchHooks Function()
        > {
  $$StartingPointsTableTableManager(
    _$AppDatabase db,
    $StartingPointsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StartingPointsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StartingPointsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StartingPointsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
              }) => StartingPointsCompanion(
                id: id,
                name: name,
                latitude: latitude,
                longitude: longitude,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required double latitude,
                required double longitude,
              }) => StartingPointsCompanion.insert(
                id: id,
                name: name,
                latitude: latitude,
                longitude: longitude,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StartingPointsTableProcessedTableManager =
    ProcessedTableManager<
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
        BaseReferences<_$AppDatabase, $StartingPointsTable, StartingPoint>,
      ),
      StartingPoint,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db, _db.clients);
  $$LocationsTableTableManager get locations =>
      $$LocationsTableTableManager(_db, _db.locations);
  $$EquipmentTableTableManager get equipment =>
      $$EquipmentTableTableManager(_db, _db.equipment);
  $$SitesTableTableManager get sites =>
      $$SitesTableTableManager(_db, _db.sites);
  $$StartingPointsTableTableManager get startingPoints =>
      $$StartingPointsTableTableManager(_db, _db.startingPoints);
}
