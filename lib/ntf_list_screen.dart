
import 'package:flutter/material.dart';

class NftListScreen extends StatefulWidget {
  NftListScreen({Key? key}) : super(key: key);

  @override
  State<NftListScreen> createState() => _NftListScreenState();
}

class _NftListScreenState extends State<NftListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFT list'),
      ),
      body: const SizedBox(),

    );
  }
}