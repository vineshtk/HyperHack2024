
	#!/bin/bash
	export DOMAIN_NAME="greencredits.com"

	echo "------------Register the ca admin for each organization—----------------"

docker compose -f docker/docker-compose-ca.yaml up -d
sleep 3

sudo chmod -R 777 organizations/

export PATH=${PWD}/bin:${PWD}:$PATH

echo "------------Register and enroll the users for each organization—-----------"

chmod +x registerEnroll.sh

./registerEnroll.sh
sleep 3

echo "—-------------Build the infrastructure—-----------------"

docker compose -f docker/docker-compose-orgs.yaml up -d
sleep 3

echo "-------------Generate the genesis block—-------------------------------"

export FABRIC_CFG_PATH=${PWD}/config

export CHANNEL_NAME=fabrixchannel

configtxgen -profile ThreeOrgsChannel -outputBlock ${PWD}/channel-artifacts/${CHANNEL_NAME}.block -channelID $CHANNEL_NAME
sleep 2

echo "------ Create the application channel------"

export ORDERER_CA=${PWD}/organizations/ordererOrganizations/${DOMAIN_NAME}/orderers/orderer.${DOMAIN_NAME}/msp/tlscacerts/tlsca.${DOMAIN_NAME}-cert.pem

export ORDERER_ADMIN_TLS_SIGN_CERT=${PWD}/organizations/ordererOrganizations/${DOMAIN_NAME}/orderers/orderer.${DOMAIN_NAME}/tls/server.crt

export ORDERER_ADMIN_TLS_PRIVATE_KEY=${PWD}/organizations/ordererOrganizations/${DOMAIN_NAME}/orderers/orderer.${DOMAIN_NAME}/tls/server.key

osnadmin channel join --channelID $CHANNEL_NAME --config-block ${PWD}/channel-artifacts/$CHANNEL_NAME.block -o localhost:7053 --ca-file $ORDERER_CA --client-cert $ORDERER_ADMIN_TLS_SIGN_CERT --client-key $ORDERER_ADMIN_TLS_PRIVATE_KEY
sleep 2

osnadmin channel list -o localhost:7053 --ca-file $ORDERER_CA --client-cert $ORDERER_ADMIN_TLS_SIGN_CERT --client-key $ORDERER_ADMIN_TLS_PRIVATE_KEY
sleep 2

export FABRIC_CFG_PATH=${PWD}/peercfg
export CORE_PEER_TLS_ENABLED=true
	
	#Define dynamic variables
	export ORG_NAME_DOMAIN="corporate1.greencredits.com"
	export ORG_NAME="corporate1"
	export ORG_MSP="Corporate1MSP"
	export PEER="peer0" 
	export PEER_PORT=7051
	export ORG_CAP="CORPORATE1"
	export CORE_PEER_LOCALMSPID=${ORG_MSP} 
	export CORE_PEER_ADDRESS=localhost:${PEER_PORT} 
	export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/${ORG_NAME_DOMAIN}/peers/${PEER}.${ORG_NAME_DOMAIN}/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/${ORG_NAME_DOMAIN}/users/Admin@${ORG_NAME_DOMAIN}/msp
	export ${ORG_CAP}_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/${ORG_NAME_DOMAIN}/peers/${PEER}.${ORG_NAME_DOMAIN}/tls/ca.crt

	echo "—---------------Join ${ORG_NAME} peer to the channel—-------------"

	peer channel join -b ${PWD}/channel-artifacts/$CHANNEL_NAME.block
	sleep 1
	peer channel list

	echo "—-------------${ORG_NAME} anchor peer update—-----------"

	peer channel fetch config ${PWD}/channel-artifacts/config_block.pb -o localhost:7050 --ordererTLSHostnameOverride orderer.${DOMAIN_NAME} -c $CHANNEL_NAME --tls --cafile $ORDERER_CA
	sleep 1

	cd channel-artifacts

	configtxlator proto_decode --input config_block.pb --type common.Block --output config_block.json
	jq '.data.data[0].payload.data.config' config_block.json > config.json
	cp config.json config_copy.json

	jq ".channel_group.groups.Application.groups.${ORG_MSP}.values += {AnchorPeers:{mod_policy: \"Admins\",\"value\":{\"anchor_peers\": [{\"host\": \"${PEER}.${ORG_NAME_DOMAIN}\",\"port\": ${PEER_PORT}}]},\"version\": \"0\"}}" config_copy.json > modified_config.json

	configtxlator proto_encode --input config.json --type common.Config --output config.pb
	configtxlator proto_encode --input modified_config.json --type common.Config --output modified_config.pb
	configtxlator compute_update --channel_id $CHANNEL_NAME --original config.pb --updated modified_config.pb --output config_update.pb

	configtxlator proto_decode --input config_update.pb --type common.ConfigUpdate --output config_update.json
	echo '{"payload":{"header":{"channel_header":{"channel_id":"'$CHANNEL_NAME'", "type":2}},"data":{"config_update":'$(cat config_update.json)'}}}' | jq . > config_update_in_envelope.json
	configtxlator proto_encode --input config_update_in_envelope.json --type common.Envelope --output config_update_in_envelope.pb

	cd ..

	peer channel update -f ${PWD}/channel-artifacts/config_update_in_envelope.pb -c $CHANNEL_NAME -o localhost:7050  --ordererTLSHostnameOverride orderer.${DOMAIN_NAME} --tls --cafile $ORDERER_CA
	sleep 1

	echo "—---------------package chaincode—-------------"

	peer lifecycle chaincode package chaincode.tar.gz --path ${PWD}/../Chaincode/ --lang golang --label chaincode_1.0
	sleep 1

	echo "—---------------install chaincode in ${ORG_NAME} peer—-------------"

	peer lifecycle chaincode install chaincode.tar.gz
	sleep 3

	peer lifecycle chaincode queryinstalled

	export CC_PACKAGE_ID=$(peer lifecycle chaincode calculatepackageid chaincode.tar.gz)

	echo "—---------------Approve chaincode in ${ORG_NAME} peer—-------------"

	peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.${DOMAIN_NAME} --channelID $CHANNEL_NAME --name sample-chaincode --version 1.0 --collections-config ../Chaincode/collection.json --package-id $CC_PACKAGE_ID --sequence 1 --tls --cafile $ORDERER_CA --waitForEvent
	sleep 1

		
	#Define dynamic variables
	export ORG_NAME_DOMAIN="corporate2.greencredits.com"
	export ORG_NAME="corporate2"
	export ORG_MSP="Corporate2MSP"
	export PEER="peer0" 
	export PEER_PORT=7071
	export ORG_CAP="CORPORATE2"
	export CORE_PEER_LOCALMSPID=${ORG_MSP} 
	export CORE_PEER_ADDRESS=localhost:${PEER_PORT} 
	export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/${ORG_NAME_DOMAIN}/peers/${PEER}.${ORG_NAME_DOMAIN}/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/${ORG_NAME_DOMAIN}/users/Admin@${ORG_NAME_DOMAIN}/msp
	export ${ORG_CAP}_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/${ORG_NAME_DOMAIN}/peers/${PEER}.${ORG_NAME_DOMAIN}/tls/ca.crt

	echo "—---------------Join ${ORG_NAME} peer to the channel—-------------"

	peer channel join -b ${PWD}/channel-artifacts/$CHANNEL_NAME.block
	sleep 1
	peer channel list

	echo "—-------------${ORG_NAME} anchor peer update—-----------"

	peer channel fetch config ${PWD}/channel-artifacts/config_block.pb -o localhost:7050 --ordererTLSHostnameOverride orderer.${DOMAIN_NAME} -c $CHANNEL_NAME --tls --cafile $ORDERER_CA
	sleep 1

	cd channel-artifacts

	configtxlator proto_decode --input config_block.pb --type common.Block --output config_block.json
	jq '.data.data[0].payload.data.config' config_block.json > config.json
	cp config.json config_copy.json

	jq ".channel_group.groups.Application.groups.${ORG_MSP}.values += {AnchorPeers:{mod_policy: \"Admins\",\"value\":{\"anchor_peers\": [{\"host\": \"${PEER}.${ORG_NAME_DOMAIN}\",\"port\": ${PEER_PORT}}]},\"version\": \"0\"}}" config_copy.json > modified_config.json

	configtxlator proto_encode --input config.json --type common.Config --output config.pb
	configtxlator proto_encode --input modified_config.json --type common.Config --output modified_config.pb
	configtxlator compute_update --channel_id $CHANNEL_NAME --original config.pb --updated modified_config.pb --output config_update.pb

	configtxlator proto_decode --input config_update.pb --type common.ConfigUpdate --output config_update.json
	echo '{"payload":{"header":{"channel_header":{"channel_id":"'$CHANNEL_NAME'", "type":2}},"data":{"config_update":'$(cat config_update.json)'}}}' | jq . > config_update_in_envelope.json
	configtxlator proto_encode --input config_update_in_envelope.json --type common.Envelope --output config_update_in_envelope.pb

	cd ..

	peer channel update -f ${PWD}/channel-artifacts/config_update_in_envelope.pb -c $CHANNEL_NAME -o localhost:7050  --ordererTLSHostnameOverride orderer.${DOMAIN_NAME} --tls --cafile $ORDERER_CA
	sleep 1

	echo "—---------------package chaincode—-------------"

	peer lifecycle chaincode package chaincode.tar.gz --path ${PWD}/../Chaincode/ --lang golang --label chaincode_1.0
	sleep 1

	echo "—---------------install chaincode in ${ORG_NAME} peer—-------------"

	peer lifecycle chaincode install chaincode.tar.gz
	sleep 3

	peer lifecycle chaincode queryinstalled

	export CC_PACKAGE_ID=$(peer lifecycle chaincode calculatepackageid chaincode.tar.gz)

	echo "—---------------Approve chaincode in ${ORG_NAME} peer—-------------"

	peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.${DOMAIN_NAME} --channelID $CHANNEL_NAME --name sample-chaincode --version 1.0 --collections-config ../Chaincode/collection.json --package-id $CC_PACKAGE_ID --sequence 1 --tls --cafile $ORDERER_CA --waitForEvent
	sleep 1

		
	#Define dynamic variables
	export ORG_NAME_DOMAIN="government.greencredits.com"
	export ORG_NAME="government"
	export ORG_MSP="GovernmentMSP"
	export PEER="peer0" 
	export PEER_PORT=7091
	export ORG_CAP="GOVERNMENT"
	export CORE_PEER_LOCALMSPID=${ORG_MSP} 
	export CORE_PEER_ADDRESS=localhost:${PEER_PORT} 
	export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/${ORG_NAME_DOMAIN}/peers/${PEER}.${ORG_NAME_DOMAIN}/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/${ORG_NAME_DOMAIN}/users/Admin@${ORG_NAME_DOMAIN}/msp
	export ${ORG_CAP}_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/${ORG_NAME_DOMAIN}/peers/${PEER}.${ORG_NAME_DOMAIN}/tls/ca.crt

	echo "—---------------Join ${ORG_NAME} peer to the channel—-------------"

	peer channel join -b ${PWD}/channel-artifacts/$CHANNEL_NAME.block
	sleep 1
	peer channel list

	echo "—-------------${ORG_NAME} anchor peer update—-----------"

	peer channel fetch config ${PWD}/channel-artifacts/config_block.pb -o localhost:7050 --ordererTLSHostnameOverride orderer.${DOMAIN_NAME} -c $CHANNEL_NAME --tls --cafile $ORDERER_CA
	sleep 1

	cd channel-artifacts

	configtxlator proto_decode --input config_block.pb --type common.Block --output config_block.json
	jq '.data.data[0].payload.data.config' config_block.json > config.json
	cp config.json config_copy.json

	jq ".channel_group.groups.Application.groups.${ORG_MSP}.values += {AnchorPeers:{mod_policy: \"Admins\",\"value\":{\"anchor_peers\": [{\"host\": \"${PEER}.${ORG_NAME_DOMAIN}\",\"port\": ${PEER_PORT}}]},\"version\": \"0\"}}" config_copy.json > modified_config.json

	configtxlator proto_encode --input config.json --type common.Config --output config.pb
	configtxlator proto_encode --input modified_config.json --type common.Config --output modified_config.pb
	configtxlator compute_update --channel_id $CHANNEL_NAME --original config.pb --updated modified_config.pb --output config_update.pb

	configtxlator proto_decode --input config_update.pb --type common.ConfigUpdate --output config_update.json
	echo '{"payload":{"header":{"channel_header":{"channel_id":"'$CHANNEL_NAME'", "type":2}},"data":{"config_update":'$(cat config_update.json)'}}}' | jq . > config_update_in_envelope.json
	configtxlator proto_encode --input config_update_in_envelope.json --type common.Envelope --output config_update_in_envelope.pb

	cd ..

	peer channel update -f ${PWD}/channel-artifacts/config_update_in_envelope.pb -c $CHANNEL_NAME -o localhost:7050  --ordererTLSHostnameOverride orderer.${DOMAIN_NAME} --tls --cafile $ORDERER_CA
	sleep 1

	echo "—---------------package chaincode—-------------"

	peer lifecycle chaincode package chaincode.tar.gz --path ${PWD}/../Chaincode/ --lang golang --label chaincode_1.0
	sleep 1

	echo "—---------------install chaincode in ${ORG_NAME} peer—-------------"

	peer lifecycle chaincode install chaincode.tar.gz
	sleep 3

	peer lifecycle chaincode queryinstalled

	export CC_PACKAGE_ID=$(peer lifecycle chaincode calculatepackageid chaincode.tar.gz)

	echo "—---------------Approve chaincode in ${ORG_NAME} peer—-------------"

	peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.${DOMAIN_NAME} --channelID $CHANNEL_NAME --name sample-chaincode --version 1.0 --collections-config ../Chaincode/collection.json --package-id $CC_PACKAGE_ID --sequence 1 --tls --cafile $ORDERER_CA --waitForEvent
	sleep 1

		
	#Define dynamic variables
	export ORG_NAME_DOMAIN="ngo1.greencredits.com"
	export ORG_NAME="ngo1"
	export ORG_MSP="Ngo1MSP"
	export PEER="peer0" 
	export PEER_PORT=7111
	export ORG_CAP="NGO1"
	export CORE_PEER_LOCALMSPID=${ORG_MSP} 
	export CORE_PEER_ADDRESS=localhost:${PEER_PORT} 
	export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/${ORG_NAME_DOMAIN}/peers/${PEER}.${ORG_NAME_DOMAIN}/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/${ORG_NAME_DOMAIN}/users/Admin@${ORG_NAME_DOMAIN}/msp
	export ${ORG_CAP}_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/${ORG_NAME_DOMAIN}/peers/${PEER}.${ORG_NAME_DOMAIN}/tls/ca.crt

	echo "—---------------Join ${ORG_NAME} peer to the channel—-------------"

	peer channel join -b ${PWD}/channel-artifacts/$CHANNEL_NAME.block
	sleep 1
	peer channel list

	echo "—-------------${ORG_NAME} anchor peer update—-----------"

	peer channel fetch config ${PWD}/channel-artifacts/config_block.pb -o localhost:7050 --ordererTLSHostnameOverride orderer.${DOMAIN_NAME} -c $CHANNEL_NAME --tls --cafile $ORDERER_CA
	sleep 1

	cd channel-artifacts

	configtxlator proto_decode --input config_block.pb --type common.Block --output config_block.json
	jq '.data.data[0].payload.data.config' config_block.json > config.json
	cp config.json config_copy.json

	jq ".channel_group.groups.Application.groups.${ORG_MSP}.values += {AnchorPeers:{mod_policy: \"Admins\",\"value\":{\"anchor_peers\": [{\"host\": \"${PEER}.${ORG_NAME_DOMAIN}\",\"port\": ${PEER_PORT}}]},\"version\": \"0\"}}" config_copy.json > modified_config.json

	configtxlator proto_encode --input config.json --type common.Config --output config.pb
	configtxlator proto_encode --input modified_config.json --type common.Config --output modified_config.pb
	configtxlator compute_update --channel_id $CHANNEL_NAME --original config.pb --updated modified_config.pb --output config_update.pb

	configtxlator proto_decode --input config_update.pb --type common.ConfigUpdate --output config_update.json
	echo '{"payload":{"header":{"channel_header":{"channel_id":"'$CHANNEL_NAME'", "type":2}},"data":{"config_update":'$(cat config_update.json)'}}}' | jq . > config_update_in_envelope.json
	configtxlator proto_encode --input config_update_in_envelope.json --type common.Envelope --output config_update_in_envelope.pb

	cd ..

	peer channel update -f ${PWD}/channel-artifacts/config_update_in_envelope.pb -c $CHANNEL_NAME -o localhost:7050  --ordererTLSHostnameOverride orderer.${DOMAIN_NAME} --tls --cafile $ORDERER_CA
	sleep 1

	echo "—---------------package chaincode—-------------"

	peer lifecycle chaincode package chaincode.tar.gz --path ${PWD}/../Chaincode/ --lang golang --label chaincode_1.0
	sleep 1

	echo "—---------------install chaincode in ${ORG_NAME} peer—-------------"

	peer lifecycle chaincode install chaincode.tar.gz
	sleep 3

	peer lifecycle chaincode queryinstalled

	export CC_PACKAGE_ID=$(peer lifecycle chaincode calculatepackageid chaincode.tar.gz)

	echo "—---------------Approve chaincode in ${ORG_NAME} peer—-------------"

	peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.${DOMAIN_NAME} --channelID $CHANNEL_NAME --name sample-chaincode --version 1.0 --collections-config ../Chaincode/collection.json --package-id $CC_PACKAGE_ID --sequence 1 --tls --cafile $ORDERER_CA --waitForEvent
	sleep 1

		
	#Define dynamic variables
	export ORG_NAME_DOMAIN="ngo2.greencredits.com"
	export ORG_NAME="ngo2"
	export ORG_MSP="Ngo2MSP"
	export PEER="peer0" 
	export PEER_PORT=7131
	export ORG_CAP="NGO2"
	export CORE_PEER_LOCALMSPID=${ORG_MSP} 
	export CORE_PEER_ADDRESS=localhost:${PEER_PORT} 
	export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/${ORG_NAME_DOMAIN}/peers/${PEER}.${ORG_NAME_DOMAIN}/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/${ORG_NAME_DOMAIN}/users/Admin@${ORG_NAME_DOMAIN}/msp
	export ${ORG_CAP}_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/${ORG_NAME_DOMAIN}/peers/${PEER}.${ORG_NAME_DOMAIN}/tls/ca.crt

	echo "—---------------Join ${ORG_NAME} peer to the channel—-------------"

	peer channel join -b ${PWD}/channel-artifacts/$CHANNEL_NAME.block
	sleep 1
	peer channel list

	echo "—-------------${ORG_NAME} anchor peer update—-----------"

	peer channel fetch config ${PWD}/channel-artifacts/config_block.pb -o localhost:7050 --ordererTLSHostnameOverride orderer.${DOMAIN_NAME} -c $CHANNEL_NAME --tls --cafile $ORDERER_CA
	sleep 1

	cd channel-artifacts

	configtxlator proto_decode --input config_block.pb --type common.Block --output config_block.json
	jq '.data.data[0].payload.data.config' config_block.json > config.json
	cp config.json config_copy.json

	jq ".channel_group.groups.Application.groups.${ORG_MSP}.values += {AnchorPeers:{mod_policy: \"Admins\",\"value\":{\"anchor_peers\": [{\"host\": \"${PEER}.${ORG_NAME_DOMAIN}\",\"port\": ${PEER_PORT}}]},\"version\": \"0\"}}" config_copy.json > modified_config.json

	configtxlator proto_encode --input config.json --type common.Config --output config.pb
	configtxlator proto_encode --input modified_config.json --type common.Config --output modified_config.pb
	configtxlator compute_update --channel_id $CHANNEL_NAME --original config.pb --updated modified_config.pb --output config_update.pb

	configtxlator proto_decode --input config_update.pb --type common.ConfigUpdate --output config_update.json
	echo '{"payload":{"header":{"channel_header":{"channel_id":"'$CHANNEL_NAME'", "type":2}},"data":{"config_update":'$(cat config_update.json)'}}}' | jq . > config_update_in_envelope.json
	configtxlator proto_encode --input config_update_in_envelope.json --type common.Envelope --output config_update_in_envelope.pb

	cd ..

	peer channel update -f ${PWD}/channel-artifacts/config_update_in_envelope.pb -c $CHANNEL_NAME -o localhost:7050  --ordererTLSHostnameOverride orderer.${DOMAIN_NAME} --tls --cafile $ORDERER_CA
	sleep 1

	echo "—---------------package chaincode—-------------"

	peer lifecycle chaincode package chaincode.tar.gz --path ${PWD}/../Chaincode/ --lang golang --label chaincode_1.0
	sleep 1

	echo "—---------------install chaincode in ${ORG_NAME} peer—-------------"

	peer lifecycle chaincode install chaincode.tar.gz
	sleep 3

	peer lifecycle chaincode queryinstalled

	export CC_PACKAGE_ID=$(peer lifecycle chaincode calculatepackageid chaincode.tar.gz)

	echo "—---------------Approve chaincode in ${ORG_NAME} peer—-------------"

	peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.${DOMAIN_NAME} --channelID $CHANNEL_NAME --name sample-chaincode --version 1.0 --collections-config ../Chaincode/collection.json --package-id $CC_PACKAGE_ID --sequence 1 --tls --cafile $ORDERER_CA --waitForEvent
	sleep 1

		
	echo "—---------------Commit chaincode —-------------"
	peer lifecycle chaincode checkcommitreadiness --channelID $CHANNEL_NAME --name sample-chaincode --version 1.0 --sequence 1 --collections-config ../Chaincode/collection.json --tls --cafile $ORDERER_CA --output json
	peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.${DOMAIN_NAME} --channelID $CHANNEL_NAME --name sample-chaincode --version 1.0 --sequence 1 --collections-config ../Chaincode/collection.json --tls --cafile $ORDERER_CA --peerAddresses localhost:7051 --tlsRootCertFiles $CORPORATE1_PEER_TLSROOTCERT  --peerAddresses localhost:7071 --tlsRootCertFiles $CORPORATE2_PEER_TLSROOTCERT  --peerAddresses localhost:7091 --tlsRootCertFiles $GOVERNMENT_PEER_TLSROOTCERT  --peerAddresses localhost:7111 --tlsRootCertFiles $NGO1_PEER_TLSROOTCERT  --peerAddresses localhost:7131 --tlsRootCertFiles $NGO2_PEER_TLSROOTCERT
	sleep 1
	peer lifecycle chaincode querycommitted --channelID $CHANNEL_NAME --name sample-chaincode --cafile $ORDERER_CA

	