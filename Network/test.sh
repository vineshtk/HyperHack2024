export BUYER_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/buyer.greencredits.com/peers/peer0.buyer.greencredits.com/tls/ca.crt
export FINANCIALINSTITUTION_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/financialinstitution.greencredits.com/peers/peer0.financialinstitution.greencredits.com/tls/ca.crt
export GOVERNMENT_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/government.greencredits.com/peers/peer0.government.greencredits.com/tls/ca.crt
export ISSUER_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/issuer.greencredits.com/peers/peer0.issuer.greencredits.com/tls/ca.crt
export VERIFIER_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/verifier.greencredits.com/peers/peer0.verifier.greencredits.com/tls/ca.crt

# query - balance
peer chaincode query -C fabrixchannel -n sample-chaincode -c '{"function":"ClientAccountBalance","Args":[]}'

# invoke - initialize
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.${DOMAIN_NAME} --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n sample-chaincode --peerAddresses localhost:7051 --tlsRootCertFiles $BUYER_PEER_TLSROOTCERT --peerAddresses localhost:7091 --tlsRootCertFiles $FINANCIALINSTITUTION_PEER_TLSROOTCERT --peerAddresses localhost:7131 --tlsRootCertFiles $GOVERNMENT_PEER_TLSROOTCERT --peerAddresses localhost:7171 --tlsRootCertFiles $ISSUER_PEER_TLSROOTCERT  --peerAddresses localhost:7211 --tlsRootCertFiles $VERIFIER_PEER_TLSROOTCERT -c '{"function":"Initialize","Args":["gnt", "GT", "2"]}'

# invoke - mint
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.${DOMAIN_NAME} --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n sample-chaincode --peerAddresses localhost:7051 --tlsRootCertFiles $BUYER_PEER_TLSROOTCERT --peerAddresses localhost:7091 --tlsRootCertFiles $FINANCIALINSTITUTION_PEER_TLSROOTCERT --peerAddresses localhost:7131 --tlsRootCertFiles $GOVERNMENT_PEER_TLSROOTCERT --peerAddresses localhost:7171 --tlsRootCertFiles $ISSUER_PEER_TLSROOTCERT --peerAddresses localhost:7211 --tlsRootCertFiles $VERIFIER_PEER_TLSROOTCERT -c '{"function":"Mint","Args":["5000"]}'

# invoke transfer
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.${DOMAIN_NAME} --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n sample-chaincode --peerAddresses localhost:7051 --tlsRootCertFiles $BUYER_PEER_TLSROOTCERT --peerAddresses localhost:7091 --tlsRootCertFiles $FINANCIALINSTITUTION_PEER_TLSROOTCERT --peerAddresses localhost:7131 --tlsRootCertFiles $GOVERNMENT_PEER_TLSROOTCERT --peerAddresses localhost:7171 --tlsRootCertFiles $ISSUER_PEER_TLSROOTCERT --peerAddresses localhost:7211 --tlsRootCertFiles $VERIFIER_PEER_TLSROOTCERT -c '{"function":"Transfer","Args":[ "'"$RECIPIENT"'","1000"]}'