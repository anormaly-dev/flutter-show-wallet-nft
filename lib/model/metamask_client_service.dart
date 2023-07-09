import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:walletconnect_qrcode_modal_dart/walletconnect_qrcode_modal_dart.dart';

class MetamaskClientService {
  Future<void> login() async {
    // Create a connector
    final connector = WalletConnect(
      uri: 'wc:f759efd17edb158c361ffd793a741b3518fe85b9c15d36b9483fba033118aaf2',
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
        name: 'WalletConnect',
        description: 'WalletConnect Developer App',
        url: 'https://walletconnect.org',
        icons: ['https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'],
      ),
    );

    // Subscribe to events
    connector.on('connect', (session) => print(session));
    connector.on('session_update', (payload) => print(payload));
    connector.on('disconnect', (session) => print(session));

// Create a new session
    if (!connector.connected) {
      final session = await connector.createSession(
        chainId: 4160,
        onDisplayUri: (uri) async {
          log('asu - $uri');

          await launch(uri);
        },
      );
      log(session.toString());
    }
  }

  Future<String?> loginQRCode(BuildContext context) async {
// Create a connector
    final qrCodeModal = WalletConnectQrCodeModal(
      connector: WalletConnect(
        bridge: 'https://bridge.walletconnect.org',
        clientMeta: const PeerMeta(
          // <-- Meta data of your app appearing in the wallet when connecting
          name: 'QRCodeModalExampleApp',
          description: 'WalletConnect Developer App',
          url: 'https://walletconnect.org',
          icons: ['https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'],
        ),
      ),
    );

    // Subscribe to events
    qrCodeModal.registerListeners(
      onConnect: (session) => print('Connected: $session'),
      onSessionUpdate: (response) => print('Session updated: $response'),
      onDisconnect: () => print('Disconnected'),
    );

// Create QR code modal and connect to a wallet, connector returns WalletConnect
// session which can be saved and restored.
    final session = await qrCodeModal
        .connect(context, chainId: 2)
        // Errors can also be caught from connector, eg. session cancelled
        .catchError((error) {
      // Handle error here
      debugPrint(error);
      return null;
    });

    if (session?.accounts.isNotEmpty ?? false) {
      return session!.accounts[0];
    }

    return null;
  }
}
