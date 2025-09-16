import 'dart:io';

final BasePath ='${Directory.current.path}/bin/data_structures/wallets';
final KeypairPath = '${Directory.current.path}/keypairs';

final String payerMnemonic = File('${KeypairPath}/wallet.mnemonic',).readAsStringSync();
final String arrayMnemonic = File('${BasePath}/array.mnemonic',).readAsStringSync();
final String structMnemonic = File('${BasePath}/struct.mnemonic',).readAsStringSync();
final String enumMnemonic = File('${BasePath}/enum.mnemonic',).readAsStringSync();

const int oneSolInLamports = 1000000000; // 1 SOL in lamports