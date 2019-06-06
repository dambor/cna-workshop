cf create-service p.rabbitmq single-node-3.7 cloud-bus
cf create-service p.mysql db-small fortune-db
cf create-service p-config-server trial config-server -c cloud-config-uri.json
cf create-service p-circuit-breaker-dashboard trial circuit-breaker-dashboard
cf create-service p-service-registry trial service-registry

cd ../fortune-service
./mvnw clean install -DskipTests
cd ../greeting-ui
./mvnw clean install -DskipTests
cd ../cna-demo-setup

# Push apps
cd ../fortune-service
cf push -f $MANIFEST --no-start
cd ../greeting-ui
cf push -f $MANIFEST --no-start
cd ../cna-demo-setup

cf set-env fortune-service TRUST_CERTS $CF_API
cf set-env fortune-service TRUST_CERTS $CF_API

if [[ $C2C == "Y" ]]; then
  cf add-network-policy greeting-ui --destination-app fortune-service --protocol tcp --port 8080
fi

# Start apps
cf start fortune-service
cf start greeting-ui