import 'package:flutter/material.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HeaderState extends State<Header> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(229, 212, 99, 1),
      title: const Text('Celo Composer dApp'),
    );
  }
}
