use v6;
use Test;
use WebService::Justcoin;

plan 6;

my $j := WebService::Justcoin.new(:url-get(sub ($) { }));
dies_ok { $j.balances() }, "method requires API key";

$j := WebService::Justcoin.new(
        :api-key("wow-so-nice-key"),
        :url-get(sub ($) { balances-response() }));

my @balances = $j.balances();
ok @balances.elems > 1, "got balances";
my $b = @balances[1];
ok $b{'currency'}:exists, "has currency";
ok $b{'balance'}:exists, "has balance";
ok $b{'hold'}:exists, "has hold";
ok $b{'available'}:exists, "available";

sub balances-response() {
    q:to/EOR/;
[

    {
        "currency": "USD",
        "balance": "0.00000",
        "hold": "0.00000",
        "available": "0.00000"
    },
    {
        "currency": "NOK",
        "balance": "0.28835",
        "hold": "0.00000",
        "available": "0.28835"
    },
    {
        "currency": "LTC",
        "balance": "0.00000000",
        "hold": "0.00000000",
        "available": "0.00000000"
    },
    {
        "currency": "XRP",
        "balance": "0.000000",
        "hold": "0.000000",
        "available": "0.000000"
    },
    {
        "currency": "BTC",
        "balance": "0.00000000",
        "hold": "0.00000000",
        "available": "0.00000000"
    },
    {
        "currency": "EUR",
        "balance": "0.00000",
        "hold": "0.00000",
        "available": "0.00000"
    }

]
EOR

}

# vim: ft=perl6
