import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reown_appkit/reown_appkit.dart';

import '../providers/app_provider.dart';
import '../widgets/footer.dart';
import '../widgets/header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> _initializationFuture;

  @override
  void initState() {
    super.initState();
    _initializationFuture = Provider.of<AppProvider>(context, listen: false)
        .initializeAppKitModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: FutureBuilder<void>(
                future: _initializationFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Consumer<AppProvider>(
                      builder: (context, appProvider, _) {
                        if (appProvider.isConnected) {
                          log('Wallet connected!');
                          log('Selected Chain: ${appProvider.appKitModal!.selectedChain}');
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                'Wallet connected!',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              AppKitModalAccountButton(
                                  appKitModal: appProvider.appKitModal!),
                              ElevatedButton(
                                onPressed: () {
                                  appProvider.appKitModal!.disconnect();
                                },
                                child: const Text('Disconnect Wallet'),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'User Address: ${appProvider.userAddress}'),
                                  Text('User Balance: ${appProvider.balance}'),
                                  Text(
                                      'Current connected chain: ${appProvider.currentChain}'),
                                ],
                              )
                            ],
                          );
                        } else {
                          log('Wallet has not been connected.');
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                'Wallet not connected!',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              AppKitModalNetworkSelectButton(
                                appKit: appProvider.appKitModal!,
                              ),
                            ],
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}
