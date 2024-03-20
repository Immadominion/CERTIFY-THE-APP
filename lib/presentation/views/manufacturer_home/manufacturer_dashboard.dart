import 'package:certify/data/controllers/certify_dashboard_controller.dart';
import 'package:certify/presentation/views/home/home.dart';
import 'package:certify/presentation/views/manufacturer_home/components/nav_bar_item.dart';
import 'package:certify/presentation/views/manufacturer_home/manufacturer_home.dart';
import 'package:certify/presentation/views/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ManufacturerHome extends HookConsumerWidget {
  const ManufacturerHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<NavigatorState> homeKey = GlobalKey<NavigatorState>();
    final GlobalKey<NavigatorState> certifyKey = GlobalKey<NavigatorState>();
    final GlobalKey<NavigatorState> profileKey = GlobalKey<NavigatorState>();
    debugPrint('Consumer Home rebuilt: ${DateTime.now()}');
    List<String> listOfString = [
      "Home",
      "All Products",
      "Profile",
    ];
    // List<IconData> listOfIcons = [
    //   Icons.home_filled,
    //   Icons.playlist_add_check_circle_rounded,
    //   Icons.person,
    // ];
    final dashboardController = ref.watch(dashBoardControllerProvider);
    final selectedPageIndex = dashboardController.myPage;
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: selectedPageIndex,
        onTap: (value) {
          dashboardController.switchPage(value);
          HapticFeedback.lightImpact();
        },
        height: 60.h,
        activeColor: Theme.of(context).colorScheme.primary,
        inactiveColor: Theme.of(context).unselectedWidgetColor,
        backgroundColor: Theme.of(context).colorScheme.background,
        items: <BottomNavigationBarItem>[
          buildBottomNavigationBarItem(
            ref,
            context,
            iconPath: 'Home',
            label: listOfString[0],
            index: 0,
          ),
          buildBottomNavigationBarItem(
            ref,
            context,
            iconPath: 'Order-History',
            label: listOfString[1],
            index: 1,
          ),
          buildBottomNavigationBarItem(
            ref,
            context,
            iconPath: 'Profile',
            label: listOfString[2],
            index: 2,
          ),
        ],
      ),
      tabBuilder: ((context, index) {
        switch (index) {
          case 0:
            homeKey.currentState?.popUntil(
              (route) => route.isFirst,
            );
            return CupertinoTabView(
              key: homeKey,
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: Home(),
                );
              },
            );
          case 1:
            certifyKey.currentState?.popUntil(
              (route) => route.isFirst,
            );
            //TODO: Return Key ASAP
            return CupertinoTabView(
              // key: certifyKey,
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: CertifiedHome(),
                );
              },
            );
          case 2:
            profileKey.currentState?.popUntil(
              (route) => route.isFirst,
            );
            return CupertinoTabView(
              key: profileKey,
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: Profile(),
                );
              },
            );

          default:
            return CupertinoTabView(
              key: homeKey,
              builder: (context) {
                return const CupertinoPageScaffold(
                  child: Home(),
                );
              },
            );
        }
      }),
    );
  }
}
