import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wartec_app/pages/addNewBank.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class ListBankScreen extends StatefulWidget {
  final AppContext? _ctx;
  ListBankScreen(this._ctx, {Key? key}) : super(key: key);

  @override
  _ListBankScreenState createState() => _ListBankScreenState();
}

class _ListBankScreenState extends State<ListBankScreen> {
  final _controller = TextEditingController();

  final Map<String, String> _paymentMethodBank = {
    "Bank Central Asia": 'assets/icons/bca.svg',
    "HSBC Bank": 'assets/icons/hsbc.svg',
    "Bank Nasional Indonesia (BNI)": 'assets/icons/bni.svg',
    "Bank Rakyat Indonesia (BRI)": 'assets/icons/bri.svg',
    "Bank Mandiri": 'assets/icons/mandiri.svg',
    "Bank CIMB Niaga": 'assets/icons/cimb.svg',
    "Bank Danamon": 'assets/icons/danamon.svg',
    "Citibank": 'assets/icons/citi.svg',
    "Bank Syariah Indonesia (BSI)": 'assets/icons/bsi.svg',
    "Bank Jago": 'assets/icons/jago.svg',
    "Bank Mega": 'assets/icons/mega.svg',
  };

  numberCount(String _num) {
    var _db = "0";
    if (_num != "0") {
      _db = (double.tryParse(_num) ?? 0).toStringAsFixed(3);
    }
    this.setState(() {
      _controller.text = _db;
    });
  }

  get _getAppbar {
    return new AppBar(
        title: Text("Bank Accounts",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16)),
        backgroundColor: Colors.white,
        elevation: 1.0,
        leading: new InkWell(
          borderRadius: BorderRadius.circular(30.0),
          child: new Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            Get.back();
          },
        ),
        centerTitle: true);
  }

  Widget bankItemBox(String title, String image) {
    return InkWell(
      onTap: () {
        Get.to(() => AddNewBankScreen(widget._ctx, title, image));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 30,
                  child: SvgPicture.asset(
                    image,
                    width: 30,
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                      color: AppPalette.instance.grey10,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Icon(Icons.chevron_right)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _getAppbar,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: _screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: _controller,
                    style: new TextStyle(
                      color: Colors.black,
                    ),
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        prefixIcon:
                            new Icon(Icons.search, color: Colors.black38),
                        hintText: "Enter Bank Name Here",
                        hintStyle: new TextStyle(color: Colors.black38)),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    width: _screenWidth,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0)),
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: _paymentMethodBank.length,
                          itemBuilder: (_, int index) {
                            String key =
                                _paymentMethodBank.keys.elementAt(index);
                            return bankItemBox(key, _paymentMethodBank[key]!);
                          },
                        ),
                      ],
                    )),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
