import 'package:solana/solana.dart';
import 'dart:convert';

import '../../../clients/dart/generated/anchor_program/lib.dart';

void getGambleState(RpcClient client, Ed25519HDPublicKey programId) async {
  try {
    final configSeeds = [utf8.encode('config')];

    final configAcc = await Ed25519HDPublicKey.findProgramAddress(
      seeds: configSeeds,
      programId: programId,
    );

    final gamleAccount = await Config.fetch(client, configAcc);
    print('\n ======== Gamble State: ========');
    print('Admin: ${gamleAccount.admin}');
    print('Gamble Cost: ${gamleAccount.gamble_cost}');
    print('Config Bump: ${gamleAccount.config_bump}');
    print('Reward Pool Bump: ${gamleAccount.reward_pool_bump}');

  } catch (e) {
    print('Error fetching Gamble State: $e');
  }
}
