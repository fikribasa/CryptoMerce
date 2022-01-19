import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wartec_app/components/CoinCard.dart';
import 'package:wartec_app/components/basicLoading.dart';
import 'package:wartec_app/components/profileWidget.dart';
import 'package:wartec_app/components/rightSlider.dart';
import 'package:wartec_app/models/tokenList.dart';
import 'package:wartec_app/services/appContext.dart';
import 'package:wartec_app/style.dart';

class MarketScreen extends StatefulWidget {
  final AppContext _ctx;
  MarketScreen(AppContext ctx, {Key? key})
      : _ctx = ctx,
        super(key: key);

  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final TextEditingController _controller = new TextEditingController();
  bool _loser = false;
  bool _isLoading = true;

  bool _isRadioSelected = false;
  TokenList? _tokenList;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final _tl = await widget._ctx.api.getTokenList();
      this.setState(() {
        _isLoading = false;
        _tokenList = _tl;
      });
    });
  }

  Widget _renderHeader(double _screenWidth) {
    return Container(
      width: _screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RightSliderWidget(widget._ctx, icon: ProfileWidget(widget._ctx)),
          Container(
            width: _screenWidth * 0.6,
            decoration: BoxDecoration(
              color: AppPalette.instance.grey05,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              controller: _controller,
              style: new TextStyle(
                color: Colors.black,
              ),
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: new Icon(Icons.search, color: Colors.black38),
                  hintText: "Search Crypto",
                  hintStyle: new TextStyle(color: Colors.black38)),
            ),
          ),
          InkWell(
            child: Container(
                decoration: BoxDecoration(
                    color: AppPalette.instance.grey05,
                    borderRadius: BorderRadius.circular(6)),
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                child: SvgPicture.asset("assets/icons/sort.svg")),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text("Sort",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700)),
                        SizedBox(height: 10),
                        LabeledRadio(
                          label: 'Recomended',
                          value: true,
                          groupValue: _isRadioSelected,
                          onChanged: (bool newValue) {
                            setState(() {
                              _isRadioSelected = newValue;
                            });
                          },
                        ),
                        LabeledRadio(
                          label: 'Newest First',
                          value: true,
                          groupValue: _isRadioSelected,
                          onChanged: (bool newValue) {
                            setState(() {
                              _isRadioSelected = newValue;
                            });
                          },
                        ),
                        LabeledRadio(
                          label: 'Lowest Price',
                          value: true,
                          groupValue: _isRadioSelected,
                          onChanged: (bool newValue) {
                            setState(() {
                              _isRadioSelected = newValue;
                            });
                          },
                        ),
                        LabeledRadio(
                          label: 'Highest Price',
                          value: true,
                          groupValue: _isRadioSelected,
                          onChanged: (bool newValue) {
                            setState(() {
                              _isRadioSelected = newValue;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        Text("Show",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700)),
                        SizedBox(height: 10),
                        LabeledCheck(
                          label: 'Losers',
                          value: _loser,
                          groupValue: _loser,
                          onChanged: (bool newValue) {
                            setState(() {
                              _loser = newValue;
                            });
                          },
                        ),
                        LabeledCheck(
                          label: 'Gainers',
                          value: _loser,
                          groupValue: _loser,
                          onChanged: (bool newValue) {
                            setState(() {
                              _loser = newValue;
                            });
                          },
                        ),
                        LabeledCheck(
                          label: 'Watchlist',
                          value: _loser,
                          groupValue: _loser,
                          onChanged: (bool newValue) {
                            setState(() {
                              _loser = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _renderHeader(_screenWidth),
              Container(
                width: _screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [],
                ),
              ),
              SizedBox(height: 20.0),
              _isLoading
                  ? BasicLoading()
                  : _tokenList != null && _tokenList!.item != null
                      ? ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: _tokenList!.item!.length,
                          itemBuilder: (_, int index) {
                            return CoinCard(
                                widget._ctx, _tokenList!.item![index],
                                showChart: false);
                          },
                        )
                      : Center(child: Text("Loading"))
            ],
          ),
        )),
      ),
    );
  }
}

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    Key? key,
    required this.label,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final bool groupValue;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Row(
        children: <Widget>[
          Radio<bool>(
            groupValue: groupValue,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            value: value,
            onChanged: (bool? newValue) {
              onChanged(newValue!);
            },
          ),
          SizedBox(width: 4),
          Text(label),
        ],
      ),
    );
  }
}

class LabeledCheck extends StatelessWidget {
  const LabeledCheck({
    Key? key,
    required this.label,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final bool groupValue;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Row(
        children: <Widget>[
          Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            value: value,
            onChanged: (bool? newValue) {
              onChanged(newValue!);
            },
          ),
          SizedBox(width: 4),
          Text(label),
        ],
      ),
    );
  }
}
