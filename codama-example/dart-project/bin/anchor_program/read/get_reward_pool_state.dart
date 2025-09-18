import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'dart:convert';

Future<int?> getRewardPoolState(RpcClient client, Ed25519HDPublicKey programId) async {
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
    return lamports;
  } catch (e) {
    throw Exception('Failed to fetch reward pool state: $e');
  }
}
