import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

final news = """{
    "data": [
        {
            "news_url": "https://news.bitcoin.com/canadian-regulator-binance-unauthorized-crypto-exchanges-letter-to-users-unacceptable/",
            "image_url": "https://crypto.snapi.dev/images/v1/o/n/ontario-94510.jpg",
            "title": "Canadian Regulator Insists Binance Is Unauthorized, Calls the Crypto Exchange's Letter to Users ‘Unacceptable'",
            "text": "The Ontario Securities Commission (OSC) claims that Binance has rescinded its commitment to comply with previously agreed requirements. The crypto exchange told the regulator that there would be no new transactions involving Ontario residents after Dec. 31. However, Binance recently informed its Ontario users that they no longer have to close their accounts by year-end. […]",
            "source_name": "Bitcoin",
            "date": "Fri, 31 Dec 2021 19:30:04 -0500",
            "topics": [
                "regulations"
            ],
            "sentiment": "Negative",
            "type": "Article"
        },
        {
            "news_url": "https://u.today/top-crypto-predictions-made-by-billionaires-in-2021",
            "image_url": "https://crypto.snapi.dev/images/v1/1/1/11742-94508.jpg",
            "title": "Top Crypto Predictions Made by Billionaires in 2021",
            "text": "These billionaires nailed their cryptocurrency predictions",
            "source_name": "UToday",
            "date": "Fri, 31 Dec 2021 19:05:00 -0500",
            "topics": [],
            "sentiment": "Positive",
            "type": "Article"
        },
        {
            "news_url": "https://cryptopotato.com/bank-of-mexico-to-launch-its-cbdc-by-2024/",
            "image_url": "https://crypto.snapi.dev/images/v1/n/d/mexico-94500.jpg",
            "title": "Bank of Mexico to Launch Its CBDC by 2024",
            "text": "The central bank of Mexico would roll out a central bank digital currency by the end of 2024.",
            "source_name": "CryptoPotato",
            "date": "Fri, 31 Dec 2021 18:45:01 -0500",
            "topics": [],
            "sentiment": "Neutral",
            "type": "Article"
        },
        {
            "news_url": "https://cryptopotato.com/the-sec-appoints-new-senior-advisor-for-cryptocurrency-oversight/",
            "image_url": "https://crypto.snapi.dev/images/v1/e/d/thesec-94490.jpg",
            "title": "The SEC Appoints New Senior Advisor for Cryptocurrency Oversight",
            "text": "The SEC continues its strives in terms of regulating the cryptocurrency space by appointing a new designated senior advisor.",
            "source_name": "CryptoPotato",
            "date": "Fri, 31 Dec 2021 16:15:59 -0500",
            "topics": [
                "regulations"
            ],
            "sentiment": "Neutral",
            "type": "Article"
        },
        {
            "news_url": "https://www.youtube.com/watch?v=Iadc1xoz_Ss",
            "image_url": "https://crypto.snapi.dev/images/v1/e/p/ava-labs-john-wu-predicts-crypto-asset-market-could-hit-5-trillion-in-2022-94482.jpg",
            "title": "Ava Labs' John Wu predicts crypto asset market could hit \$5 trillion in 2022",
            "text": "John Wu, Ava Labs president, joins 'The Exchange' to discuss the year ahead for cryptocurrencies, why Wu's bullish on the space and how mainstream cryptocurrencies will perform.",
            "source_name": "CNBC Television",
            "date": "Fri, 31 Dec 2021 14:53:14 -0500",
            "topics": [],
            "sentiment": "Positive",
            "type": "Video"
        },
        {
            "news_url": "https://cointelegraph.com/news/cointelegraph-consulting-crypto-events-of-2021-in-retrospect",
            "image_url": "https://crypto.snapi.dev/images/v1/8/4/840-ahr0chm6ly9zmy5jb2ludgvszwdyyxbolmnvbs91cgxvywrzlziwmjetmtivmgqxmjdknzetndcxnc00otnllwi1ztgtmjm1mzuxmdi3mjm0lmpwzw-94484.jpg",
            "title": "Cointelegraph Consulting: Crypto events of 2021 in retrospect",
            "text": "With 2021 coming to a close, it might go down as the year that brought the most mainstream attention to cryptocurrencies.",
            "source_name": "Cointelegraph",
            "date": "Fri, 31 Dec 2021 14:00:00 -0500",
            "topics": [],
            "sentiment": "Neutral",
            "type": "Article"
        },
        {
            "news_url": "https://u.today/shib-devs-teasing-big-surprise-for-2022-ripple-cto-admits-optimizing-btc-code-brock-pierce-sees-btc",
            "image_url": "https://crypto.snapi.dev/images/v1/1/1/11737-94486.jpg",
            "title": "SHIB Devs Teasing Big Surprise for 2022, Ripple CTO Admits Optimizing BTC Code, Brock Pierce Sees BTC Soar to \$200,000: Crypto News Digest by U.Today",
            "text": "Check out U.Today's New Year's Eve news digest!",
            "source_name": "UToday",
            "date": "Fri, 31 Dec 2021 14:00:00 -0500",
            "topics": [],
            "sentiment": "Positive",
            "type": "Article"
        },
        {
            "news_url": "https://news.bitcoin.com/sec-chairman-gary-gensler-crypto-adviser-executive-staff/",
            "image_url": "https://crypto.snapi.dev/images/v1/s/e/sec-advisor-94472.jpg",
            "title": "SEC Chairman Gary Gensler Adds Crypto Adviser to Executive Staff",
            "text": "The U.S. Securities and Exchange Commission (SEC) has added a number of advisers to Chairman Gary Gensler's executive staff. Among them is Corey Frayer, who advises Gensler on “SEC policymaking and interagency work relating to the oversight of crypto assets.” SEC Has New Adviser for the Oversight of Crypto Assets The U.S. Securities and Exchange […]",
            "source_name": "Bitcoin",
            "date": "Fri, 31 Dec 2021 13:30:31 -0500",
            "topics": [
                "regulations"
            ],
            "sentiment": "Neutral",
            "type": "Article"
        }
    ]
}""";

final userinfo = """{
    "id":"c07383e4-8034-4acb-b314-b5474d0ca956", 
    "full_name":"Wartec User Full Name",
    "image_url":"https://randomuser.me/api/portraits/men/75.jpg",
    "email":"rommyp@gmail.com",
    "ktp_number":"19558370566684785",
    "phone_number":"6281234567899",
    "wallet_id":"c07383e4-8034-4acb-b314-b5474d0ca956"
}""";

final tokenList = """{
  "data": [
    {
      "id": "110",
      "code": "ZAC",
      "name": "ZACoin",
      "image": "assets/icons/zaq.png",
      "price": "77199",
      "change": "9.77"
    },
    {
      "id": "111",
      "code": "BTC",
      "name": "Bitcoin",
      "image": "assets/icons/btc.png",
      "price": "709290630",
      "change": "-3.02"
    },
    {
      "id": "112",
      "code": "ETH",
      "name": "Ethereum",
      "image": "assets/icons/eth.png",
      "price": "61246164",
      "change": "9.77"
    },
    {
      "id": "113",
      "code": "GT",
      "name": "Dash",
      "image": "assets/icons/dash.png",
      "price": "1979877",
      "change": "9.77"
    },
    {
      "id": "114",
      "code": "XMR",
      "name": "Monero",
      "image": "assets/icons/xmr.png",
      "price": "2923354",
      "change": "-9.77"
    }
  ]
}
""";
final credential = """{"email":"rommyp@gmail.com","password":"12345678"}""";

responseHandler(String url) {
  switch (url) {
    case "api/news":
      return Response(news, 200, headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      });
    case "api/user-info":
      return Response(userinfo, 200, headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      });
    case "api/token-list":
      return Response(tokenList, 200, headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
      });
    default:
      null;
  }
}
