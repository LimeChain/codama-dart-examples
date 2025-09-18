import 'dart:io';
import 'package:bip39/bip39.dart' as bip39;

/*
Functionality to generate all required mnemonics to test the example project.
*/

Future<String> generateAndSaveMnemonic(String mnemonicName) async {
  final dir = 'keypairs';
  // Ensure the directory exists
  final directory = Directory(dir);
  if (!await directory.exists()) {
    await directory.create(recursive: true);
  }
  // Generates a new mnemonic and saves it to a file named by mnemonicName inside dir
  final mnemonic = bip39.generateMnemonic();
  final path = '$dir/$mnemonicName';
  await File(path).writeAsString(mnemonic);
  print('Mnemonic saved to $path');
  return mnemonic;
}
