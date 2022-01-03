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
  get _getAppbar {
    return new AppBar(
      title: Text("Transaction",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      backgroundColor: Colors.white,
      elevation: 0.0,
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

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _getAppbar,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Rp 1,000,000",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/icons/bca.png', height: 24),
                  SizedBox(width: 12),
                  Text("Bank Central Asia"),
                ],
              ),
              SizedBox(height: 20),
              Text("Virtual Account Number",
                  style: TextStyle(fontSize: 12, color: Colors.black38)),
              SizedBox(height: 10),
              Text(_vaNumber,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  final snackBar = SnackBar(
                      content: const Text('Berhasil disalin'),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ));
                  Clipboard.setData(ClipboardData(text: _vaNumber));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.0, color: AppPalette.instance.accent5)),
                  child: Text(
                    "Copy VA Number",
                    style: TextStyle(
                        color: AppPalette.instance.accent5, fontSize: 12),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text("Transaction Limit",
                  style: TextStyle(fontSize: 12, color: Colors.black38)),
              SizedBox(height: 10),
              Text("00:59:59",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppPalette.instance.downtrend)),
              SizedBox(height: 40),
              Container(
                  width: _screenWidth,
                  child: Text("Cara Melakukan transfer",
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
