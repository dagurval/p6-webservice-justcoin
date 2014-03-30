use v6;
use Test;
use WebService::Justcoin;

plan 18;

# markets()
{
    my $j := WebService::Justcoin.new(
            :url-fetcher(sub ($url) { response_markets() }));

    my @markets = $j.markets();
    ok @markets.elems > 1, "got markets";

    my Hash $f = @markets[1];
    ok $f{"id"}.elems, "got string id";
    ok +$f{"last"}, "got last";
    ok +$f{"high"}, "got high";
    ok +$f{"low"}, "got low";
    ok +$f{"bid"}, "got bid";
    ok +$f{"ask"}, "got ask";
    ok +$f{"volume"}, "got volume";
    ok +$f{"scale"}, "got scale";
}

# market-depth($market-id)
{
    my $j := WebService::Justcoin.new(
            :url-fetcher(sub ($url) { response-depth() }));
    my %depth = $j.market-depth("BTCNOK");
    ok %depth{'bids'}:exists, "has bids in response";
    ok %depth{'asks'}:exists, "has asks in response";

    ok +%depth{'bids'}[0][0], "has BTC/NOK bid";
    ok +%depth{'bids'}[0][1], "has amount of BTC in bid";

    # empty order book
    $j := WebService::Justcoin.new(
            :url-fetcher(sub ($url) { response-no-depth() }));
    %depth = $j.market-depth("NON-EXISTING-MARKET");
    ok %depth{'bids'}:exists, "has bids in response";
    ok %depth{'asks'}:exists, "has asks in response";

    is %depth{'bids'}.elems, 0, "no bids";
    is %depth{'asks'}.elems, 0, "no asks";
}

# TODO: market-vohlc
ok WebService::Justcoin.new.market-vohlc("") ~~ X::NYI, "vohlc NYI";

sub response_markets() { q:to/EOR/;
[

    {
        "id": "BTCEUR",
        "last": "356.000",
        "high": "383.849",
        "low": "356.000",
        "bid": "356.447",
        "ask": "365.000",
        "volume": "18.39337",
        "scale": 3
    },
    {
        "id": "BTCLTC",
        "last": "36.450",
        "high": "36.476",
        "low": "35.500",
        "bid": "35.500",
        "ask": "36.450",
        "volume": "0.88762",
        "scale": 3
    },
    {
        "id": "BTCNOK",
        "last": "3029.000",
        "high": "3350.000",
        "low": "3014.000",
        "bid": "2981.000",
        "ask": "3111.000",
        "volume": "16.14318",
        "scale": 3
    },
    {
        "id": "BTCUSD",
        "last": "475.840",
        "high": "525.000",
        "low": "473.502",
        "bid": "475.000",
        "ask": "525.000",
        "volume": "7.74006",
        "scale": 3
    },
    {
        "id": "BTCXRP",
        "last": "48000.000",
        "high": "48450.000",
        "low": "46160.420",
        "bid": "47550.000",
        "ask": "48000.000",
        "volume": "17.18599",
        "scale": 3
    }

]
EOR
}

sub response-depth {
    q:to/EOR/;
{

    "bids": [
        [
            "2950.000",
            "2.17052"
        ],
        [
            "2900.000",
            "0.28281"
        ],
        [
            "2865.000",
            "0.31000"
        ],
        [
            "2800.000",
            "0.37850"
        ],
        [
            "2781.000",
            "0.00195"
        ],
        [
            "2725.284",
            "0.14000"
        ],
        [
            "2710.000",
            "0.10000"
        ],
        [
            "2706.170",
            "0.09000"
        ],
        [
            "2705.384",
            "0.14000"
        ],
        [
            "2703.248",
            "0.06000"
        ],
        [
            "2700.017",
            "0.08000"
        ],
        [
            "2700.000",
            "0.20000"
        ],
        [
            "2698.220",
            "0.15000"
        ],
        [
            "2694.310",
            "0.15000"
        ],
        [
            "2691.840",
            "0.08000"
        ],
        [
            "2690.978",
            "0.08000"
        ],
        [
            "2690.156",
            "0.14000"
        ],
        [
            "2689.024",
            "0.08000"
        ],
        [
            "2687.942",
            "0.10000"
        ],
        [
            "2684.181",
            "0.12000"
        ],
        [
            "2683.071",
            "0.08000"
        ],
        [
            "2682.549",
            "0.07000"
        ],
        [
            "2674.749",
            "0.12000"
        ],
        [
            "2672.045",
            "0.10000"
        ],
        [
            "2666.366",
            "0.09000"
        ],
        [
            "2657.550",
            "0.08000"
        ],
        [
            "2650.000",
            "0.30000"
        ],
        [
            "2649.891",
            "0.08000"
        ],
        [
            "2649.482",
            "0.06000"
        ],
        [
            "2645.101",
            "0.15000"
        ],
        [
            "2635.967",
            "0.05000"
        ],
        [
            "2602.261",
            "0.15000"
        ],
        [
            "2600.000",
            "0.40000"
        ],
        [
            "2594.000",
            "1.00000"
        ],
        [
            "2559.420",
            "0.13000"
        ],
        [
            "2552.000",
            "0.30000"
        ],
        [
            "2500.000",
            "20.35050"
        ],
        [
            "2435.000",
            "0.30000"
        ],
        [
            "2405.000",
            "5.00000"
        ],
        [
            "2400.000",
            "29.17000"
        ],
        [
            "2300.000",
            "0.20000"
        ],
        [
            "2222.000",
            "1.00000"
        ],
        [
            "2214.100",
            "0.02500"
        ],
        [
            "2200.000",
            "0.40000"
        ],
        [
            "2100.000",
            "0.30000"
        ],
        [
            "2015.000",
            "3.00000"
        ],
        [
            "2014.000",
            "0.99400"
        ],
        [
            "2013.000",
            "5.00000"
        ],
        [
            "2000.000",
            "5.70000"
        ],
        [
            "1900.000",
            "0.10000"
        ],
        [
            "1888.000",
            "1.10000"
        ],
        [
            "1850.000",
            "0.10000"
        ],
        [
            "1800.000",
            "0.10000"
        ],
        [
            "1750.000",
            "0.10000"
        ],
        [
            "1700.000",
            "0.10000"
        ],
        [
            "1650.000",
            "0.10000"
        ],
        [
            "1600.000",
            "0.10000"
        ],
        [
            "1550.000",
            "0.10000"
        ],
        [
            "1500.000",
            "0.57400"
        ],
        [
            "1450.000",
            "0.15000"
        ],
        [
            "1350.000",
            "0.15000"
        ],
        [
            "1250.000",
            "0.20000"
        ],
        [
            "1231.000",
            "1.00000"
        ],
        [
            "1150.000",
            "0.25000"
        ],
        [
            "1050.000",
            "3.10000"
        ],
        [
            "1046.000",
            "1.00000"
        ],
        [
            "1000.000",
            "0.10000"
        ],
        [
            "995.024",
            "1.00000"
        ],
        [
            "923.000",
            "2.00000"
        ],
        [
            "861.000",
            "2.00000"
        ],
        [
            "800.000",
            "2.00000"
        ],
        [
            "738.000",
            "2.00000"
        ],
        [
            "677.000",
            "2.00000"
        ],
        [
            "615.000",
            "2.00000"
        ],
        [
            "500.000",
            "0.90000"
        ],
        [
            "429.000",
            "0.90000"
        ],
        [
            "100.000",
            "10.00000"
        ],
        [
            "99.000",
            "10.00000"
        ],
        [
            "10.000",
            "19.00000"
        ],
        [
            "1.000",
            "24590.00000"
        ],
        [
            "0.497",
            "2000.00000"
        ],
        [
            "0.050",
            "6.61000"
        ],
        [
            "0.027",
            "1.00000"
        ],
        [
            "0.015",
            "1.00000"
        ],
        [
            "0.010",
            "0.40000"
        ],
        [
            "0.001",
            "10.00458"
        ]
    ],
    "asks": [
        [
            "3244.943",
            "1.56332"
        ],
        [
            "3245.123",
            "1.00000"
        ],
        [
            "3375.123",
            "1.00000"
        ],
        [
            "3398.000",
            "4.00000"
        ],
        [
            "3399.000",
            "0.99740"
        ],
        [
            "3400.000",
            "0.39571"
        ],
        [
            "3410.000",
            "0.15000"
        ],
        [
            "3430.000",
            "0.30000"
        ],
        [
            "3500.000",
            "1.00000"
        ],
        [
            "3580.000",
            "0.50000"
        ],
        [
            "3598.800",
            "0.99500"
        ],
        [
            "3600.123",
            "4.00000"
        ],
        [
            "3680.000",
            "0.01224"
        ],
        [
            "3690.000",
            "0.01237"
        ],
        [
            "3699.000",
            "0.08300"
        ],
        [
            "3700.000",
            "0.08540"
        ],
        [
            "3799.000",
            "0.10000"
        ],
        [
            "3899.000",
            "0.09900"
        ],
        [
            "3900.000",
            "19.93553"
        ],
        [
            "3900.010",
            "0.02029"
        ],
        [
            "3925.000",
            "0.01396"
        ],
        [
            "3930.000",
            "0.04000"
        ],
        [
            "3940.000",
            "4.84434"
        ],
        [
            "3994.376",
            "0.01509"
        ],
        [
            "3999.000",
            "0.05373"
        ],
        [
            "4000.000",
            "1.27719"
        ],
        [
            "4027.000",
            "0.12351"
        ],
        [
            "4044.000",
            "2.27002"
        ],
        [
            "4050.000",
            "3.71208"
        ],
        [
            "4065.000",
            "0.01025"
        ],
        [
            "4138.000",
            "0.01492"
        ],
        [
            "4138.960",
            "0.02554"
        ],
        [
            "4139.830",
            "0.05000"
        ],
        [
            "4200.000",
            "0.40000"
        ],
        [
            "4217.208",
            "0.02500"
        ],
        [
            "4220.000",
            "0.01692"
        ],
        [
            "4299.000",
            "5.00000"
        ],
        [
            "4333.000",
            "0.03000"
        ],
        [
            "4335.000",
            "3.00000"
        ],
        [
            "4380.000",
            "0.39801"
        ],
        [
            "4399.000",
            "5.00000"
        ],
        [
            "4400.000",
            "0.78277"
        ],
        [
            "4450.000",
            "0.22500"
        ],
        [
            "4477.000",
            "0.49741"
        ],
        [
            "4499.000",
            "10.13516"
        ],
        [
            "4500.000",
            "3.02475"
        ],
        [
            "4599.000",
            "5.00000"
        ],
        [
            "4600.000",
            "2.19500"
        ],
        [
            "4650.000",
            "5.00000"
        ],
        [
            "4695.000",
            "0.05200"
        ],
        [
            "4699.000",
            "5.00000"
        ],
        [
            "4700.000",
            "1.00000"
        ],
        [
            "4799.000",
            "5.00000"
        ],
        [
            "4800.000",
            "1.20000"
        ],
        [
            "4899.000",
            "5.00000"
        ],
        [
            "4900.000",
            "1.00000"
        ],
        [
            "4950.000",
            "0.05300"
        ],
        [
            "4995.000",
            "6.00000"
        ],
        [
            "4999.000",
            "5.00000"
        ],
        [
            "5000.000",
            "2.00000"
        ],
        [
            "5050.000",
            "0.20000"
        ],
        [
            "5070.000",
            "0.50000"
        ],
        [
            "5080.000",
            "0.53840"
        ],
        [
            "5099.000",
            "0.25000"
        ],
        [
            "5100.000",
            "0.07242"
        ],
        [
            "5114.000",
            "0.25000"
        ],
        [
            "5170.000",
            "0.20000"
        ],
        [
            "5184.000",
            "0.25000"
        ],
        [
            "5200.000",
            "1.34387"
        ],
        [
            "5250.000",
            "0.20000"
        ],
        [
            "5342.000",
            "0.00759"
        ],
        [
            "5349.000",
            "0.75100"
        ],
        [
            "5377.000",
            "0.70000"
        ],
        [
            "5395.000",
            "0.05565"
        ],
        [
            "5400.000",
            "0.19376"
        ],
        [
            "5444.000",
            "4.04000"
        ],
        [
            "5493.600",
            "0.00221"
        ],
        [
            "5498.000",
            "10.00000"
        ],
        [
            "5500.000",
            "2.77772"
        ],
        [
            "5597.000",
            "1.11190"
        ],
        [
            "5600.000",
            "0.50000"
        ],
        [
            "5650.000",
            "1.00000"
        ],
        [
            "5696.000",
            "1.12000"
        ],
        [
            "5700.000",
            "0.00100"
        ],
        [
            "5740.000",
            "0.72271"
        ],
        [
            "5750.000",
            "1.00000"
        ],
        [
            "5760.000",
            "1.00000"
        ],
        [
            "5770.000",
            "1.00000"
        ],
        [
            "5780.000",
            "1.00000"
        ],
        [
            "5790.000",
            "1.00000"
        ],
        [
            "5795.700",
            "0.31110"
        ],
        [
            "5800.000",
            "1.24700"
        ],
        [
            "5810.000",
            "1.00000"
        ],
        [
            "5820.000",
            "1.00000"
        ],
        [
            "5830.000",
            "1.00000"
        ],
        [
            "5840.000",
            "1.00000"
        ],
        [
            "5848.000",
            "0.02860"
        ],
        [
            "5850.000",
            "1.00000"
        ],
        [
            "5860.000",
            "1.00000"
        ],
        [
            "5870.000",
            "1.00000"
        ],
        [
            "5900.000",
            "1.00000"
        ],
        [
            "6000.000",
            "1.63068"
        ],
        [
            "6100.000",
            "2.60800"
        ],
        [
            "6262.000",
            "0.50000"
        ],
        [
            "6297.000",
            "1.61580"
        ],
        [
            "6300.000",
            "0.20000"
        ],
        [
            "6380.000",
            "6.34300"
        ],
        [
            "6498.000",
            "0.03131"
        ],
        [
            "6500.000",
            "6.03283"
        ],
        [
            "6599.700",
            "0.02060"
        ],
        [
            "6600.000",
            "0.20000"
        ],
        [
            "6881.060",
            "1.18876"
        ],
        [
            "6999.000",
            "0.08000"
        ],
        [
            "7000.000",
            "0.20725"
        ],
        [
            "7300.000",
            "0.50000"
        ],
        [
            "7445.000",
            "0.03700"
        ],
        [
            "7500.000",
            "5.00000"
        ],
        [
            "7544.100",
            "0.03690"
        ],
        [
            "7777.000",
            "2.44752"
        ],
        [
            "8000.000",
            "1.00000"
        ],
        [
            "9000.000",
            "1.98510"
        ],
        [
            "9567.000",
            "0.34336"
        ],
        [
            "9860.000",
            "1.00000"
        ],
        [
            "33000.000",
            "1.00000"
        ],
        [
            "88000.000",
            "1.00000"
        ],
        [
            "99000.000",
            "1.00000"
        ],
        [
            "10000000.000",
            "0.10000"
        ],
        [
            "30171550.000",
            "0.09985"
        ],
        [
            "100000000.000",
            "0.01010"
        ],
        [
            "999999999999.000",
            "0.00100"
        ],
        [
            "99999999999999.000",
            "0.00001"
        ],
        [
            "1000000000000000.000",
            "0.00010"
        ]
    ]

}
EOR
}

sub response-no-depth { 
q:to/EOR/;
{

    "bids": [ ],
    "asks": [ ]

}
EOR
}

# vim: ft=perl6