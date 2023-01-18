  ./electrum-sv daemon -v=debug --enable-node-wallet-api -rpcpassword= -walletnotify="python3 contrib/scripts/jsonrpc_wallet_event.py %s" > /root/.electrum-sv/demo_log_$(date +%s).txt 2>&1 &
  ./electrum-sv --no-password-check -wp=$WALLET_PASSWORD create_jsonrpc_wallet -w demo
  ./electrum-sv daemon load_wallet -w demo --walletpassword=$WALLET_PASSWORD
  ./electrum-sv daemon service_signup -w demo --walletpassword=$WALLET_PASSWORD