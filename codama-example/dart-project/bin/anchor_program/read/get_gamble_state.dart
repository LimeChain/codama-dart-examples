import 'package:solana/solana.dart';
import 'dart:convert';

import '../../../clients/dart/generated/lib.dart';

Future<Config> getGambleState(RpcClient client, Ed25519HDPublicKey programId) async {
  try {
    final configSeeds = [utf8.encode('config')];

    final configAcc = await Ed25519HDPublicKey.findProgramAddress(
      seeds: configSeeds,
      programId: programId,
    );

    final gamleAccount = await Config.fetch(client, configAcc);

    return gamleAccount;
  } catch (e) {
    throw Exception('Failed to fetch gamble state: $e');
  }
}
