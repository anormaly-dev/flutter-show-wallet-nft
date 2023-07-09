// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nft _$NftFromJson(Map<String, dynamic> json) => Nft(
      json['title'] as String,
      (json['media'] as List<dynamic>)
          .map((e) => Media.fromJson(e as Map<String, dynamic>))
          .toList(),
      Contract.fromJson(json['contract'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NftToJson(Nft instance) => <String, dynamic>{
      'title': instance.title,
      'media': instance.media,
      'contract': instance.contract,
    };
