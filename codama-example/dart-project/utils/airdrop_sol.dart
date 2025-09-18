import 'package:solana/solana.dart';

Future<String> airdropSol(RpcClient client, Ed25519HDKeyPair user) async {
  final lamports = 1_000_000_000; // 1 SOL in lamports

  try {
    final signature = await client.requestAirdrop(
      user.publicKey.toBase58(),
      lamports * 50,
    );

    return signature;
  } catch (e) {
    print('Error fetching balance: $e');
    throw Exception('Failed to fetch balance: $e');
  }
}
