# Codama Example: Anchor & Dart Codama Renderer Integration

This repository demonstrates how our dart renderer is used within Codama IDL.
The workflow showcases generating Dart clients from your Anchor program and rendering output in the terminal.

## Project Structure

- [`anchor-program/`](anchor-program/): Solana Anchor smart contract + script that generates the `codama-dart` client.
- [`dart-project/`](dart-project/): Dart CLI app using codama-dart renderer

## Quick Start

### 1. Compile & Deploy Anchor Program Locally

Navigate to the Anchor program directory and build/deploy to your local Solana validator:

```sh
cd anchor-program
anchor build
anchor deploy
```

Make sure your local validator is running (`solana-test-validator`).

### 2. Generate Dart Clients

From the `anchor-program` directory, run the client generator script:

```sh
pnpm install codama
pnpm install @codama/renderers-dart
codama init
```
The `codama init` command will prompt you for settings and create a `codama.json` file, which you can further customize.

Inside the `codama.json` file, add the Dart renderer under `scripts`. You can specify the output location and other options as needed.

```json
{
    "scripts": {
        "dart": {
            "from": "@codama/renderers-dart",
            "args": [
                "../dart-project/clients/dart/generated",
                {
                    "crateFolder": "clients/dart",
                    "formatCode": true
                }
            ]
        }
    }
}
```

To generate the clients with Codama, simply run the following command in your terminal:

```sh
codama run dart
```

### 3. Set Up Dart Project

1. Navigate to the Dart project and install dependencies:

```sh
cd ../dart-project
dart pub get
```

2. Before running the Dart CLI, you must generate the required mnemonic files for the test wallets. Run the following command to automatically create all necessary mnemonics in the keypairs/ directory:


```sh
dart run scripts/generate_all_mnemonics.dart
```

### 4. Run the Dart CLI

Read the comments in the entrypoint file ([`bin/dart_project.dart`](dart-project/bin/dart_project.dart)) for usage instructions, then run:

```sh
dart run
```

You can now interact with your Anchor program from Dart, with terminal output rendered by codama-dart.

---

Feel free to explore and modify both the Anchor and Dart projects to fit your needs!