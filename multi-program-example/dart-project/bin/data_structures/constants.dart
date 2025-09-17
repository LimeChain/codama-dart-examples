import 'dart:io';

final KeypairPath = '${Directory.current.path}/keypairs';

final String payerMnemonic = File('${KeypairPath}/wallet.mnemonic',).readAsStringSync();
final String arrayMnemonic = File('${KeypairPath}/array.mnemonic',).readAsStringSync();
final String structMnemonic = File('${KeypairPath}/struct.mnemonic',).readAsStringSync();
final String enumMnemonic = File('${KeypairPath}/enum.mnemonic',).readAsStringSync();

const int oneSolInLamports = 1000000000; // 1 SOL in lamports