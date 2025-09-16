import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'dart:convert';

void getRewardPoolState(RpcClient client, Ed25519HDPublicKey programId) async {
  try {
    final rewardPoolSeeds = [utf8.encode('reward_pool')];

    final rewardPool = await Ed25519HDPublicKey.findProgramAddress(
      seeds: rewardPoolSeeds,
      programId: programId,
    );

    // Since reward pool is a system account, we fetch its balance directly, because it doesn't create an account with custom data structure to use a `fetch` method.
    final accountInfo = await client.getAccountInfo(
      rewardPool.toBase58(),
      commitment: Commitment.finalized,
      encoding: Encoding.base58,
    );

    final lamports = accountInfo.value?.lamports;
    print(
      'Reward pool SOL: ${lamports != null ? lamports / 1_000_000_000 : 'Account not found'}',
    );
  } catch (e) {
    print('Error fetching Gamble State: $e');
  }
}
