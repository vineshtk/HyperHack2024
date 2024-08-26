package main

// Config represents the configuration for a role.
type Config struct {
	CertPath     string `json:"certPath"`
	KeyDirectory string `json:"keyPath"`
	TLSCertPath  string `json:"tlsCertPath"`
	PeerEndpoint string `json:"peerEndpoint"`
	GatewayPeer  string `json:"gatewayPeer"`
	MSPID        string `json:"mspID"`
}

// Create a Profile map
var profile = map[string]Config{

	"government": {
		CertPath:     "../Network/organizations/peerOrganizations/government.greencredits.com/users/User1@government.greencredits.com/msp/signcerts/cert.pem",
		KeyDirectory: "../Network/organizations/peerOrganizations/government.greencredits.com/users/User1@government.greencredits.com/msp/keystore/",
		TLSCertPath:  "../Network/organizations/peerOrganizations/government.greencredits.com/peers/peer0.government.greencredits.com/tls/ca.crt",
		PeerEndpoint: "localhost:7131",
		GatewayPeer:  "peer0.government.greencredits.com",
		MSPID:        "GovernmentMSP",
	},

	"verifier": {
		CertPath:     "../Network/organizations/peerOrganizations/verifier.greencredits.com/users/User1@verifier.greencredits.com/msp/signcerts/cert.pem",
		KeyDirectory: "../Network/organizations/peerOrganizations/verifier.greencredits.com/users/User1@verifier.greencredits.com/msp/keystore/",
		TLSCertPath:  "../Network/organizations/peerOrganizations/verifier.greencredits.com/peers/peer0.verifier.greencredits.com/tls/ca.crt",
		PeerEndpoint: "localhost:7211",
		GatewayPeer:  "peer0.verifier.greencredits.com",
		MSPID:        "VerifierMSP",
	},

	"issuer": {
		CertPath:     "../Network/organizations/peerOrganizations/issuer.greencredits.com/users/User1@issuer.greencredits.com/msp/signcerts/cert.pem",
		KeyDirectory: "../Network/organizations/peerOrganizations/issuer.greencredits.com/users/User1@issuer.greencredits.com/msp/keystore/",
		TLSCertPath:  "../Network/organizations/peerOrganizations/issuer.greencredits.com/peers/peer0.issuer.greencredits.com/tls/ca.crt",
		PeerEndpoint: "localhost:7171",
		GatewayPeer:  "peer0.issuer.greencredits.com",
		MSPID:        "IssuerMSP",
	},

	"buyer": {
		CertPath:     "../Network/organizations/peerOrganizations/buyer.greencredits.com/users/User1@buyer.greencredits.com/msp/signcerts/cert.pem",
		KeyDirectory: "../Network/organizations/peerOrganizations/buyer.greencredits.com/users/User1@buyer.greencredits.com/msp/keystore/",
		TLSCertPath:  "../Network/organizations/peerOrganizations/buyer.greencredits.com/peers/peer0.buyer.greencredits.com/tls/ca.crt",
		PeerEndpoint: "localhost:7051",
		GatewayPeer:  "peer0.buyer.greencredits.com",
		MSPID:        "BuyerMSP",
	},

	"financialinstitution": {
		CertPath:     "../Network/organizations/peerOrganizations/financialinstitution.greencredits.com/users/User1@financialinstitution.greencredits.com/msp/signcerts/cert.pem",
		KeyDirectory: "../Network/organizations/peerOrganizations/financialinstitution.greencredits.com/users/User1@financialinstitution.greencredits.com/msp/keystore/",
		TLSCertPath:  "../Network/organizations/peerOrganizations/financialinstitution.greencredits.com/peers/peer0.financialinstitution.greencredits.com/tls/ca.crt",
		PeerEndpoint: "localhost:7091",
		GatewayPeer:  "peer0.financialinstitution.greencredits.com",
		MSPID:        "FinancialinstitutionMSP",
	},

}
