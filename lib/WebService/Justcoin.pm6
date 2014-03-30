use v6;
use JSON::Tiny;

class WebService::Justcoin {

    has Callable $!url-fetcher;
    has Str $!base-url = "https://justcoin.com/api/v1";

    method markets() {
        my $json = $!url-fetcher($!base-url ~ "/markets");

        # .flat is workaround, so we don't get array in array (for some reason?)
        return from-json($json).flat;
    }

    method market-depth(Str $market-id) {
        my $json = $!url-fetcher($!base-url ~ "/markets/$market-id/depth");
        return from-json($json);

    }

    method market-vohlc(Str $market-id) {
        X::NYI.new;
    }

    submethod BUILD(*%args) {
        $!url-fetcher = %args{"url-fetcher"} 
            or die "url-fetcher not implemented";
    }

}
