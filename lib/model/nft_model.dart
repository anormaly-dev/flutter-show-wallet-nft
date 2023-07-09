
import 'package:flutter_show_wallet_nft/model/contract_model.dart';
import 'package:flutter_show_wallet_nft/model/media_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nft_model.g.dart';

@JsonSerializable()
class Nft {
  final String title;
  final List<Media> media;
  final Contract contract;

  Nft(this.title, this.media, this.contract);

  factory Nft.fromJson(Map<String, dynamic> json) => _$NftFromJson(json);
  Map<String, dynamic> toJson() => _$NftToJson(this);
}