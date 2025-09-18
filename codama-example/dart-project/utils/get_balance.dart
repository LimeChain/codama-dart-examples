import 'package:solana/solana.dart';

Future getSolBalance(RpcClient client, String publicKey) async {
  try {
    final balance = await client.getBalance(publicKey);
    print(
      'Balance for $publicKey: ${balance.value / 1_000_000_000} SOL',
    ); // Convert lamports to SOL
    return balance.value / 1_000_000_000; // Convert lamports to SOL
  } catch (e) {
    print('Error fetching balance: $e');
    return null;
  }
}
