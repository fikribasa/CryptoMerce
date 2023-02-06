import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/pages/channel.dart';
import 'package:wartec_app/pages/landing.dart';
import 'package:wartec_app/pages/ledger.dart';
import 'package:wartec_app/pages/market.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class BottomBarItem extends StatelessWidget {
  final String label;
  final Widget icon;
  final Function()? onTap;

  BottomBarItem(this.label, this.icon, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: this.onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  final AppContext ctx;

  BottomBar(this.ctx);

  @override
  Widget build(BuildContext context) {
    final currentPath = ModalRoute.of(context)!.settings.name;
    print('currentPath: $currentPath');
    return Container(
      color: Colors.transparent,
      child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(width: 0, color: Colors.transparent),
              color: AppPalette.instance.white),
          child: Container(
            width: double.infinity,
            height: 64,
            child: Row(
              children: [
                BottomBarItem(
                  'Home',
                  SvgPicture.asset('assets/icons/home.svg'),
                  onTap: () {
                    Get.to(() => LandingPage(ctx));
                  },
                ),
                BottomBarItem(
                  'Channel',
                  SvgPicture.asset('assets/icons/monitor.svg'),
                  onTap: () {
                    Get.to(() => ChannelScreen(ctx));
                  },
                ),
                BottomBarItem(
                  'Market',
                  SvgPicture.asset('assets/icons/graph-bar.svg'),
                  onTap: () {
                    Get.to(() => MarketScreen(ctx));
                  },
                ),
                BottomBarItem(
                  'Ledger',
                  SvgPicture.asset('assets/icons/receipt.svg'),
                  onTap: () {
                    Get.to(() => LedgerScreen(ctx));
                  },
                )
              ],
            ),
          )),
    );
  }
}

class BasicBottomNavBar extends StatefulWidget {
  const BasicBottomNavBar(this.ctx, {Key? key, this.index}) : super(key: key);
  final int? index;
  final AppContext ctx;
  @override
  _BasicBottomNavBarState createState() => _BasicBottomNavBarState();
}

class _BasicBottomNavBarState extends State<BasicBottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.index != null) {
        _onItemTapped(widget.index!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _pages = <Widget>[
      LandingPage(widget.ctx),
      ChannelScreen(widget.ctx),
      MarketScreen(widget.ctx),
      LedgerScreen(widget.ctx)
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        fixedColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(color: Colors.black),
        unselectedLabelStyle: TextStyle(color: Colors.black),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? SvgPicture.asset('assets/icons/home-alt.svg')
                : SvgPicture.asset('assets/icons/home.svg'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? SvgPicture.asset('assets/icons/monitor-alt.svg')
                : SvgPicture.asset('assets/icons/monitor.svg'),
            label: 'Channel',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? SvgPicture.asset('assets/icons/graph-bar-alt.svg')
                : SvgPicture.asset('assets/icons/graph-bar.svg'),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? SvgPicture.asset('assets/icons/receipt-alt.svg')
                : SvgPicture.asset('assets/icons/receipt.svg'),
            label: 'Ledger',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
