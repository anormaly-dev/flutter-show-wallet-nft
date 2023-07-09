import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'model/nft_model.dart';

class AlchemyClientService{

  Future<List<Nft>> request(BuildContext context, String walletAddress) async {
    log("Start download nft...");
    final dio = Dio();
    //ex: https://eth-mainnet.g.alchemy.com/nft/v2/xxxxxxxxxxxxxxxxxx/getNFTs
    var response = await dio.get('<your alchemy endpoint>?owner=$walletAddress');
    log("Nft metadata downloaded...");
    var ntfsOwned = response.data['ownedNfts'] as List;
    return ntfsOwned.map((ntf) => Nft.fromJson(ntf)).toList();
  }
}