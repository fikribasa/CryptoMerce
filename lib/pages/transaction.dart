import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wartec_app/components/primaryButton.dart';
import 'package:wartec_app/components/textList.dart';
import 'package:wartec_app/style.dart';

class TransactionScreen extends StatefulWidget {
  TransactionScreen({Key? key}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final _vaNumber = "1911085246562277";
  final timerStyle = TextStyle(
      color: AppPalette.instance.downtrend,
      fontSize: 18,
      fontWeight: FontWeight.w200);
  get _getAppbar {
    return new AppBar(
      title: Text("Transaction",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16)),
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
      centerTitle: true,
      actions: [
        Icon(
          Icons.info_outline,
          size: 24,
          color: AppPalette.instance.grey10,
        ),
        SizedBox(width: 16)
      ],
    );
  }

  final List<String> _transferAtmStep = [
    'Masukkan Kartu ATM BCA & Pin',
    'Pilih menu Transaksi Lainnya > Transfer > ke rekening BCA Virtual Account.',
    'Masukkan 5 angka kode perusahaan untuk Wartec (00000) dan Nomor Hp yang terdaftar di akun FansNya FKBN Anda (Contoh: 807770812345678)',
    'Di halaman konfirmaasi, pastikan detail pembayaran sudah sesuai seperti No. VA, Nama, Produk dan Total Tagihan.',
    'Masukkan jumlah transfer sesuai dengan total tagihan.',
    'Ikuti instruksi untuk menyelesaikan transaksi.',
    'Simpan struk transaksi sebagai bukti pembayaran.'
  ];

  Widget _timerItem(String _time, String _context) {
    return Column(
      children: [
        Text(_time, style: timerStyle),
        SizedBox(height: 6),
        Text(_context, style: timerStyle)
      ],
    );
  }

  Widget _divider() {
    return Column(
      children: [
        SizedBox(width: 16),
        Text(":"),
        SizedBox(height: 12),
        Text(""),
        SizedBox(width: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _getAppbar,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                width: _screenWidth,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: Column(
                  children: [
                    Container(
                        width: _screenWidth,
                        child: Image.asset('assets/icons/logomark-wartec.png',
                            height: 40)),
                    Text("Payment Method", style: TextStyle(fontSize: 18)),
                    SizedBox(height: 8),
                    Image.asset('assets/icons/bca.png', height: 40),
                    SizedBox(height: 8),
                    Text(
                      "Bank Central Asia",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 20),
                    Container(
                        width: _screenWidth,
                        child: Text("Transaction Limit",
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center)),
                    SizedBox(height: 10),
                    Text(
                      "09:56, 19 Jan 2022",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: _screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _timerItem("00", "hrs"),
                          _divider(),
                          _timerItem("14", "min"),
                          _divider(),
                          _timerItem("59", "sec"),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(color: Colors.black12, thickness: 1.0),
                    SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Virtual Account Number",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black38)),
                              SizedBox(height: 6),
                              Text(_vaNumber,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                          Container(
                            width: 60,
                            child: PrimaryOutline(
                              label: "Copy",
                              onPressed: () {
                                final snackBar = SnackBar(
                                    content: const Text('Berhasil disalin'),
                                    action: SnackBarAction(
                                      label: 'OK',
                                      onPressed: () {},
                                    ));
                                Clipboard.setData(
                                    ClipboardData(text: _vaNumber));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              textStyle: TextStyle(
                                  fontSize: 11,
                                  color: AppPalette.instance.accent5,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ]),
                    SizedBox(height: 20),
                    Container(
                      width: _screenWidth,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppPalette.instance.natural10,
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Transfer Amount",
                                style: TextStyle(fontSize: 12)),
                            SizedBox(height: 8),
                            Text("Rp 1,007,199",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppPalette.instance.primary09)),
                          ]),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                  width: _screenWidth,
                  child: Text("How to Deposit",
                      style: TextStyle(fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start)),
              Theme(
                data: AppPalette.instance.themeExpansionTile,
                child: ListTileTheme(
                  contentPadding: EdgeInsets.all(0),
                  child: ExpansionTile(
                    title: Text("ATM BCA"),
                    children: _transferAtmStep
                        .asMap()
                        .map((index, value) => MapEntry(
                            index, listBuilder((index + 1).toString(), value)))
                        .values
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
