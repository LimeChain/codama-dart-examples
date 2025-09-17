import 'dart:async';

import 'package:solana/solana.dart';

Future<void> waitForConfirmation(
  RpcClient client,
  String signature, {
  Duration pollInterval = const Duration(seconds: 1),
  Duration timeout = const Duration(seconds: 40),
}) async {
  final start = DateTime.now();
  int counter = 0;

  while (true) {
    final result = await client.getSignatureStatuses([signature]);
    final status = result?.value?.first;
    if (status != null && status.confirmations == null) {
      // Transaction is finalized
      break;
    }
    if (DateTime.now().difference(start) > timeout) {
      throw TimeoutException('Transaction was not confirmed within $timeout');
    }
    if (counter % 5 == 0 && counter != 0) {
      print('Waiting for transaction finalization ...');
    }
    counter++;
    await Future.delayed(pollInterval);
  }
}