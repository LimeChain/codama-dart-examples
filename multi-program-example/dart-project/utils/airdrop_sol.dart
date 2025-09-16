import 'package:solana/solana.dart';

Future airdropSol(RpcClient client, Ed25519HDKeyPair user) async {
  final lamports = 1_000_000_000; // 1 SOL in lamports

  try {
    final signature = await client.requestAirdrop(
      user.publicKey.toBase58(),
      lamports * 50,
    );
    print('Airdrop transaction signature: $signature');
  } catch (e) {
    print('Error fetching balance: $e');
    return null;
  }
}
