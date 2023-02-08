echo "starting daemon..."
./electrum-sv daemon -v=debug --enable-node-wallet-api -rpcpassword= -walletnotify="python3 contrib/scripts/jsonrpc_wallet_event.py %s" > "/root/.electrum-sv/daemon_log_$(date +%s).txt" 2>&1 &
sleep 2
echo "creating wallet..."
./electrum-sv -v=debug --no-password-check -wp=pass create_jsonrpc_wallet -w demo > "/root/.electrum-sv/create_log_$(date +%s).txt" 2>&1 &
sleep 2
echo "loading wallet..."
./electrum-sv daemon -v=debug load_wallet -w demo --walletpassword=pass > "/root/.electrum-sv/load_log_$(date +%s).txt" 2>&1 &
echo "syncing headers..."
sleep 2
# we must wait until electrumsv has synced headers before signing up to services
status_code=$(curl -s -o /dev/null -w "%{http_code}" --request POST --url http://127.0.0.1:8332/ --header 'Content-Type: text/plain' --data '{"method": "walletpassphrase","params":["pass", 10000],"id": "unlock"}') 
until [[ status_code -ne 425 ]];
do
  echo "syncing headers, checking again in 5 seconds..."
  sleep 5
  status_code=$(curl -s -o /dev/null -w "%{http_code}" --request POST --url http://127.0.0.1:8332/ --header 'Content-Type: text/plain' --data '{"method": "walletpassphrase","params":["pass", 10000],"id": "unlock"}') 
done
echo "service signup..."
# now we may continue
./electrum-sv daemon -v=debug service_signup -w demo --walletpassword=pass > "/root/.electrum-sv/signup_log_$(date +%s).txt" 2>&1 &
echo "wallet is read to use"