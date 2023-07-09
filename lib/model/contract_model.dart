import 'package:json_annotation/json_annotation.dart';

part 'contract_model.g.dart';

@JsonSerializable()
class Contract {
  final String address;

  Contract(this.address);

  factory Contract.fromJson(Map<String, dynamic> json) => _$ContractFromJson(json);
  Map<String, dynamic> toJson() => _$ContractToJson(this);
}