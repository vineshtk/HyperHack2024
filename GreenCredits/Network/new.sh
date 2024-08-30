export CORPORATE2_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/corporate2.greencredits.com/peers/peer0.corporate2.greencredits.com/tls/ca.crt
export NGO2_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/ngo2.greencredits.com/peers/peer0.ngo2.greencredits.com/tls/ca.crt
export GOVERNMENT_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/government.greencredits.com/peers/peer0.government.greencredits.com/tls/ca.crt
export CORPORATE1_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/corporate1.greencredits.com/peers/peer0.corporate1.greencredits.com/tls/ca.crt
export NGO1_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/ngo1.greencredits.com/peers/peer0.ngo1.greencredits.com/tls/ca.crt


# query - balance
peer chaincode query -C fabrixchannel -n sample-chaincode -c '{"function":"ClientAccountBalance","Args":[]}'

# query - clientID
peer chaincode query -C fabrixchannel -n sample-chaincode -c '{"function":"ClientAccountID","Args":[]}'

# invoke - initialize
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.${DOMAIN_NAME} --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n sample-chaincode --peerAddresses localhost:7071 --tlsRootCertFiles $CORPORATE2_PEER_TLSROOTCERT --peerAddresses localhost:7131 --tlsRootCertFiles $NGO2_PEER_TLSROOTCERT --peerAddresses localhost:7091 --tlsRootCertFiles $GOVERNMENT_PEER_TLSROOTCERT --peerAddresses localhost:7051 --tlsRootCertFiles $CORPORATE1_PEER_TLSROOTCERT  --peerAddresses localhost:7111 --tlsRootCertFiles $NGO1_PEER_TLSROOTCERT -c '{"function":"Initialize","Args":["gnt", "GT", "2"]}'

# invoke - mint
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.${DOMAIN_NAME} --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n sample-chaincode --peerAddresses localhost:7071 --tlsRootCertFiles $CORPORATE2_PEER_TLSROOTCERT --peerAddresses localhost:7131 --tlsRootCertFiles $NGO2_PEER_TLSROOTCERT --peerAddresses localhost:7091 --tlsRootCertFiles $GOVERNMENT_PEER_TLSROOTCERT --peerAddresses localhost:7051 --tlsRootCertFiles $CORPORATE1_PEER_TLSROOTCERT --peerAddresses localhost:7111 --tlsRootCertFiles $NGO1_PEER_TLSROOTCERT -c '{"function":"Mint","Args":["5000"]}'

# invoke transfer
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.${DOMAIN_NAME} --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n sample-chaincode --peerAddresses localhost:7071 --tlsRootCertFiles $CORPORATE2_PEER_TLSROOTCERT --peerAddresses localhost:7131 --tlsRootCertFiles $NGO2_PEER_TLSROOTCERT --peerAddresses localhost:7091 --tlsRootCertFiles $GOVERNMENT_PEER_TLSROOTCERT --peerAddresses localhost:7051 --tlsRootCertFiles $CORPORATE1_PEER_TLSROOTCERT --peerAddresses localhost:7111 --tlsRootCertFiles $NGO1_PEER_TLSROOTCERT -c '{"function":"Transfer","Args":[ "'"$RECIPIENT"'","1000"]}'