{ pkgs, ... }:

let
  symbols = [
    # etfs
    "SPY"
    "QQQ"
    "VTI"

    # big tech
    "AAPL"
    "MSFT"
    "AMZN"
    "GOOGL"
    "META"
    "NFLX"
    "CRM"

    # semis
    "AVGO"
    "NVDA"
    "AMD"
    "TSM"
    "ASML"

    # ai / momentum / high growth
    "SPCX"
    "PLTR"
    "CBRS"
    "TSLA"
    "OPEN"
    "HOOD"
    "SOFI"
    "Z"
    "OPAD"
    "UPST"

    # financials / payments
    "JPM"
    "V"
    "GS"

    # consumer / staples
    "WMT"
    "PEP"
    "COST"
    "KO"
    "PG"
    "HD"
    "NKE"
    "SBUX"
    "MCD"

    # streaming
    "DIS"
    "WBD"
    "CMCSA"
    "PARA"
    "SPOT"

    # oil and gas
    "XOM"
    "CVX"
    "COP"
    "SLB"

    # healthcare / pharma
    "LLY"
    "UNH"
    "MRK"

    # crypto
    "BTC-USD"
    "COIN"
  ];

  settings = {
    inherit symbols;

    # use specified time frame when starting program and when new stocks are added
    # fyi: default is 1D; possible values: 1D, 1W, 1M, 3M, 6M, 1Y, 5Y
    time_frame = "1M";
    update_interval = 10;
    show_volumes = true;
    show_x_labels = true;
    summary = true;
  };
in
{
  home.file.".config/tickrs/config.yml".source =
    (pkgs.formats.yaml { }).generate "tickrs-config.yml" settings;
}
