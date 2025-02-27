import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:reown_appkit/reown_appkit.dart';

class AppProvider with ChangeNotifier {
  ReownAppKitModal? _appKitModal;
  bool _isConnected = false;
  String _userAddress = '';
  String _currentChain = '';
  String _balance = '';

  ReownAppKitModal? get appKitModal => _appKitModal;
  bool get isConnected => _isConnected;
  String get userAddress => _userAddress;
  String get currentChain => _currentChain;
  String get balance => _balance;

  Future<void> initializeAppKitModal(BuildContext context) async {
    ReownAppKitModalNetworks.removeSupportedNetworks('solana');

    _appKitModal = ReownAppKitModal(
      context: context,
      logLevel: LogLevel.all,
      projectId: dotenv.env['PROJECT_ID'] ?? '',
      metadata: const PairingMetadata(
        name: 'Celo Composer',
        description: 'Memecoin trading made easy',
        url: 'https://celo-composer.com/',
        icons: ['assets/images/logo.png'],
      ),
      featuresConfig: FeaturesConfig(
        email: true,
        socials: [AppKitSocialOption.X, AppKitSocialOption.Farcaster],
        showMainWallets: true,
      ),
    );

    await _appKitModal?.init();

    _appKitModal?.addListener(_updateState);
    _updateState();
  }

  void _updateState() async {
    _isConnected = _appKitModal?.isConnected ?? false;

    if (_isConnected) {
      // Get address using the selected chain's namespace
      final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
          _appKitModal!.selectedChain?.chainId ?? "");

      _userAddress = _appKitModal?.session?.getAddress(namespace) ?? '';
      _currentChain = _appKitModal?.selectedChain?.name ?? 'Unknown';
      _balance = _appKitModal?.balanceNotifier.value ?? '0';
    } else {
      _userAddress = '';
      _currentChain = '';
      _balance = '0';
    }
    notifyListeners();
  }

  /// Sends a basic transaction on the Celo network
  /// [amount] should be in CELO (e.g., 0.1 for 0.1 CELO)
  Future<String?> sendBasicTransaction({required double amount}) async {
    if (!_isConnected || _appKitModal == null) {
      throw Exception('Wallet not connected');
    }

    try {
      // First launch the wallet to prepare for the approval
      _appKitModal!.launchConnectedWallet();

      // Convert amount to wei (1 CELO = 10^18 wei)
      final BigInt amountInWei = BigInt.from(amount * 1e18);

      // Get the current wallet address
      final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
          _appKitModal!.selectedChain?.chainId ?? "");
      final fromAddress = _appKitModal?.session?.getAddress(namespace) ?? '';

      // Create transaction parameters
      final transactionParams = {
        'from': fromAddress, // Required - sender address
        'to': fromAddress, // Sending to self
        'value': '0x${amountInWei.toRadixString(16)}', // Convert to hex
        'data': '0x', // No specific data for basic transfer
      };

      // Request transaction signature and send
      final txHash = await _appKitModal!.request(
        topic: _appKitModal!.session!.topic,
        chainId: _appKitModal!.selectedChain!.chainId,
        request: SessionRequestParams(
          method: 'eth_sendTransaction',
          params: [transactionParams],
        ),
      );

      return txHash as String?;
    } catch (e) {
      throw Exception('Transaction failed: ${e.toString()}');
    }
  }

  @override
  void dispose() {
    _appKitModal?.removeListener(_updateState);
    super.dispose();
  }
}
