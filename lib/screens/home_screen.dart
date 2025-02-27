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
  final _amountController = TextEditingController();
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _initializationFuture = Provider.of<AppProvider>(context, listen: false)
        .initializeAppKitModal(context);
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
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
                          return GestureDetector(
                            onTap: () {
                              // Dismiss keyboard when tapping outside
                              FocusScope.of(context).unfocus();
                            },
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const SizedBox(height: 24),
                                    const Text(
                                      'Wallet connected!',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    AppKitModalAccountButton(
                                        appKitModal: appProvider.appKitModal!),
                                    const SizedBox(height: 16),
                                    ElevatedButton(
                                      onPressed: () {
                                        appProvider.appKitModal!.disconnect();
                                      },
                                      child: const Text('Disconnect Wallet'),
                                    ),
                                    const SizedBox(height: 32),

                                    //Transaction section with disclaimer
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Colors.grey.shade300),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Test Transaction',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          // Disclaimer box
                                          Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: Colors.amber.shade50,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: Colors.amber.shade200),
                                            ),
                                            child: const Row(
                                              children: [
                                                Icon(Icons.info_outline,
                                                    color: Colors.amber),
                                                SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    'This is a test transaction that will send CELO back to your own wallet address.',
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          TextField(
                                            controller: _amountController,
                                            keyboardType: const TextInputType
                                                .numberWithOptions(
                                                decimal: true),
                                            decoration: InputDecoration(
                                              labelText: 'Amount in CELO',
                                              hintText:
                                                  'Enter amount (e.g., 0.1)',
                                              prefixIcon: const Icon(
                                                  Icons.attach_money),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton.icon(
                                              onPressed: _isProcessing
                                                  ? null
                                                  : () async {
                                                      if (_amountController
                                                          .text.isEmpty) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                            content: Text(
                                                                'Please enter an amount'),
                                                          ),
                                                        );
                                                        return;
                                                      }

                                                      setState(() {
                                                        _isProcessing = true;
                                                      });

                                                      try {
                                                        final amount =
                                                            double.parse(
                                                                _amountController
                                                                    .text);
                                                        final txHash = await context
                                                            .read<AppProvider>()
                                                            .sendBasicTransaction(
                                                                amount: amount);

                                                        if (txHash != null) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                                content: Text(
                                                                    'Transaction sent: $txHash')),
                                                          );
                                                        }
                                                      } catch (e) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                              content: Text(
                                                                  'Error: ${e.toString()}')),
                                                        );
                                                      } finally {
                                                        setState(() {
                                                          _isProcessing = false;
                                                        });
                                                      }
                                                    },
                                              style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12),
                                                backgroundColor:
                                                    Colors.green.shade600,
                                                foregroundColor: Colors.white,
                                              ),
                                              icon: _isProcessing
                                                  ? const SizedBox(
                                                      width: 20,
                                                      height: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  : const Icon(Icons.send),
                                              label: Text(_isProcessing
                                                  ? 'Processing...'
                                                  : 'Send CELO to Yourself'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 24),
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: const Color.fromRGBO(
                                            71, 101, 32, .6),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Wallet Information',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'User Address: ${appProvider.userAddress}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'User Balance: ${appProvider.balance}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Current connected chain: ${appProvider.currentChain}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          log('Wallet has not been connected.');
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Wallet not connected!',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 24),
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
