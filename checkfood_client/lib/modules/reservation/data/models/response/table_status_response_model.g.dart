// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_status_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TableStatusResponseModelImpl _$$TableStatusResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$TableStatusResponseModelImpl(
  date: json['date'] as String?,
  tables:
      (json['tables'] as List<dynamic>?)
          ?.map((e) => TableStatusItemModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$TableStatusResponseModelImplToJson(
  _$TableStatusResponseModelImpl instance,
) => <String, dynamic>{'date': instance.date, 'tables': instance.tables};

_$TableStatusItemModelImpl _$$TableStatusItemModelImplFromJson(
  Map<String, dynamic> json,
) => _$TableStatusItemModelImpl(
  tableId: json['tableId'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$$TableStatusItemModelImplToJson(
  _$TableStatusItemModelImpl instance,
) => <String, dynamic>{'tableId': instance.tableId, 'status': instance.status};
