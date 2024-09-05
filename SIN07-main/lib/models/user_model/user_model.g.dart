// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      mailid: json['mailid'] as String?,
      name: json['name'] as String?,
      issue: json['issue'] as String?,
      id: json['id'] as String?,
      phoneNumber: json['phoneNumber'] as int?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      type: json['type'] as String?,
      date: json['date'] as String?,
      inspectionCategory: json['inspectionCategory'] as String?,
      inspectionmessage: json['inspectionmessage'] as String?,
      image: json['image'] as String?,
      address: json['address'] as String?,
      amount: json['amount'] as String?,
      time: json['time'] as String?,
      paymentmethod: json['paymentmethod'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'mailid': instance.mailid,
      'phoneNumber': instance.phoneNumber,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'type': instance.type,
      'date': instance.date,
      'inspectionCategory': instance.inspectionCategory,
      'inspectionmessage': instance.inspectionmessage,
      'image': instance.image,
      'address': instance.address,
      'amount': instance.amount,
      'paymentmethod': instance.paymentmethod,
      'time': instance.time,
      'issue': instance.issue,
    };
