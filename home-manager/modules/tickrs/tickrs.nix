{ pkgs, ... }:

let
  # List of ticker symbols to start app with, grouped for reference
  # (tickrs itself doesn't group the watchlist, order below is just for readability)
  symbols = [
    # The market itself
    "SPY"
    "QQQ"

    # Mega-cap tech (familiar consumer brands)
    "AAPL"
    "MSFT"
    "AMZN"
    "GOOGL"

    # AI / semis bellwether
    "NVDA"

    # Financials
    "JPM"

    # Steady / low-volatility staple (good contrast to tech)
    "KO"

    # High-volatility name (good for learning what volatility looks like)
    "TSLA"

    # Crypto (behaves very differently from stocks)
    "BTC-USD"
  ];

  settings = {
    inherit symbols;

    # Use specified time frame when starting program and when new stocks are added
    # Default is 1D. Possible values: 1D, 1W, 1M, 3M, 6M, 1Y, 5Y
    # 1M shows a smoother trend line than 1D — less noisy/scary for daily wiggles
    time_frame = "1M";

    # Interval to update data from API (seconds)
    # Default is 1. 10s is plenty for casual watching and less likely to hit API rate limits
    update_interval = 10;

    # Show volumes graph
    show_volumes = true;

    # Show x-axis labels
    show_x_labels = true;

    # Start in summary mode
    # Easier starting point than paging through full charts one by one —
    # press enter on a row to drill into its chart
    summary = true;
  };
in
{
  home.file.".config/tickrs/config.yml".source =
    (pkgs.formats.yaml { }).generate "tickrs-config.yml" settings;
}
