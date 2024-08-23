import 'package:almas_gemelas_app/features/home/presentation/screens/screens.dart';
import 'package:almas_gemelas_app/features/shared/presentation/providers/bottom_nav_bar_provider.dart';
import 'package:almas_gemelas_app/features/shared/presentation/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    const List screens = [
      HomeScreen(),
      CartScreen(),
      ProfileScreen(),
      ChatScreen(),
    ];

    final icons = [
      Image.asset('public/icons/home.png'),
      Image.asset('public/icons/shopping-basket.png'),
      Image.asset('public/icons/user.png'),
      Image.asset('public/icons/chat.png'),
    ];
    final activeIcons = [
      Image.asset('public/icons/active-home.png'),
      Image.asset('public/icons/active-shopping-basket.png'),
      Image.asset('public/icons/active-user.png'),
      Image.asset('public/icons/active-chat.png'),
    ];

    int currentTab = ref.watch(selectedTabProvider);

    return Scaffold(
      body: SafeArea(child: screens[currentTab]),
      bottomNavigationBar: (!kIsWeb)
          ? CustomBottomNavBar(
              height: 80,
              items: [
                CustomBottomNavItem(
                  icon: icons[0],
                  activeIcon: activeIcons[0],
                ),
                CustomBottomNavItem(
                  icon: icons[1],
                  activeIcon: activeIcons[1],
                ),
                CustomBottomNavItem(
                  icon: icons[2],
                  activeIcon: activeIcons[2],
                ),
                CustomBottomNavItem(
                  icon: icons[3],
                  activeIcon: activeIcons[3],
                ),
              ],
              onTap: (index) {
                ref.read(selectedTabProvider.notifier).update((state) => index);
                setState(() {});
              },
            )
          : null,
    );
  }
}
