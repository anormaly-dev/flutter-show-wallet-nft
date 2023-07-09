
import 'package:flutter/material.dart';
import 'package:flutter_show_wallet_nft/alchemy_client_service.dart';

import 'model/nft_model.dart';

class NftListScreen extends StatefulWidget {
  NftListScreen({Key? key}) : super(key: key);

  @override
  State<NftListScreen> createState() => _NftListScreenState();
}

class _NftListScreenState extends State<NftListScreen> {
  String? walletAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFT list'),
      ),
      body: _future(context),
    );
  }

  Widget _future(BuildContext context) {
    return FutureBuilder(
      future: AlchemyClientService().request(context, walletAddress!),
      builder: (
          BuildContext context,
          AsyncSnapshot<List<Nft>> snapshot,
          ) {
        if (snapshot.hasData) {
          // return _nftList(snapshot.data as List<Nft>);
        }
        return const Text('No NFT');
      },
    );
  }
}