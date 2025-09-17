import 'package:solana/solana.dart';
import '../../../clients/dart/generated/anchor_data_structures/lib.dart';
import '../constants.dart';

// Result: Reading of the array from Blockchain State works as expected for these fields -> Proof Of Deserialization 
Future<StructAccount> readStruct(RpcClient client, Ed25519HDKeyPair payer) async {
  final systemProgram = Ed25519HDPublicKey.fromBase58(SystemProgram.programId);

  final Ed25519HDKeyPair structAcc = await Ed25519HDKeyPair.fromMnemonic(
    structMnemonic,
  );

  final structAccount = await StructAccount.fetch(client, structAcc.publicKey);
  // Same you can just access the struct fields directly
  return structAccount;
}