import 'package:flutter/material.dart';
import 'package:flutter_show_wallet_nft/alchemy_client_service.dart';
import 'package:flutter_show_wallet_nft/model/metamask_client_service.dart';

import 'model/nft_model.dart';

class NftListScreen extends StatefulWidget {
  NftListScreen({Key? key}) : super(key: key);

  @override
  State<NftListScreen> createState() => _NftListScreenState();
}

class _NftListScreenState extends State<NftListScreen> {
  String? walletAddress;
  final walletAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFT list'),
      ),
      body: walletAddress == null ? _setWalletId() : _future(context),
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
          return _nftList(snapshot.data as List<Nft>);
        }
        return const Text('No NFT');
      },
    );
  }

  Widget _nftList(List<Nft> nfts) {
    return ListView.builder(
        itemCount: nfts.length,
        itemBuilder: (BuildContext context, int index) {
          return _downloadImageAndLoad(nfts[index].media[0].raw);
        });
  }

  Widget _downloadImageAndLoad(String imageUrl) {
    return Image.network(
      imageUrl,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(
          child: Text('loading...'),
        );
      },
    );
  }

  Widget _setWalletId() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            controller: walletAddressController,
            decoration: const InputDecoration(filled: true, fillColor: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  setState(() {
                    walletAddress = walletAddressController.text;
                  });
                },
                child: const Text('Connect Wallet'),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () async {
                  String? walletAddressSignedIn = await MetamaskClientService().loginQRCode(context);
                  setState(() {
                    walletAddress = walletAddressSignedIn;
                  });
                },
                child: const Text('Select Wallet'),
              )
            ],
          ),
        ],
      ),
    );
  }
}