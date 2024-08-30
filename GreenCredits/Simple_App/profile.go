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
		CertPath:     "../Network/organizations/peerOrganizations/government.greencredits.com/users/Admin@government.greencredits.com/msp/signcerts/cert.pem",
		KeyDirectory: "../Network/organizations/peerOrganizations/government.greencredits.com/users/Admin@government.greencredits.com/msp/keystore/",
		TLSCertPath:  "../Network/organizations/peerOrganizations/government.greencredits.com/peers/peer0.government.greencredits.com/tls/ca.crt",
		PeerEndpoint: "localhost:7091",
		GatewayPeer:  "peer0.government.greencredits.com",
		MSPID:        "GovernmentMSP",
	},

	"ngo1": {
		CertPath:     "../Network/organizations/peerOrganizations/ngo1.greencredits.com/users/Admin@ngo1.greencredits.com/msp/signcerts/cert.pem",
		KeyDirectory: "../Network/organizations/peerOrganizations/ngo1.greencredits.com/users/Admin@ngo1.greencredits.com/msp/keystore/",
		TLSCertPath:  "../Network/organizations/peerOrganizations/ngo1.greencredits.com/peers/peer0.ngo1.greencredits.com/tls/ca.crt",
		PeerEndpoint: "localhost:7111",
		GatewayPeer:  "peer0.ngo1.greencredits.com",
		MSPID:        "Ngo1MSP",
	},

	"ngo2": {
		CertPath:     "../Network/organizations/peerOrganizations/ngo2.greencredits.com/users/Admin@ngo2.greencredits.com/msp/signcerts/cert.pem",
		KeyDirectory: "../Network/organizations/peerOrganizations/ngo2.greencredits.com/users/Admin@ngo2.greencredits.com/msp/keystore/",
		TLSCertPath:  "../Network/organizations/peerOrganizations/ngo2.greencredits.com/peers/peer0.ngo2.greencredits.com/tls/ca.crt",
		PeerEndpoint: "localhost:7131",
		GatewayPeer:  "peer0.ngo2.greencredits.com",
		MSPID:        "Ngo2MSP",
	},

	"corporate1": {
		CertPath:     "../Network/organizations/peerOrganizations/corporate1.greencredits.com/users/Admin@corporate1.greencredits.com/msp/signcerts/cert.pem",
		KeyDirectory: "../Network/organizations/peerOrganizations/corporate1.greencredits.com/users/Admin@corporate1.greencredits.com/msp/keystore/",
		TLSCertPath:  "../Network/organizations/peerOrganizations/corporate1.greencredits.com/peers/peer0.corporate1.greencredits.com/tls/ca.crt",
		PeerEndpoint: "localhost:7051",
		GatewayPeer:  "peer0.corporate1.greencredits.com",
		MSPID:        "Corporate1MSP",
	},

	"corporate2": {
		CertPath:     "../Network/organizations/peerOrganizations/corporate2.greencredits.com/users/Admin@corporate2.greencredits.com/msp/signcerts/cert.pem",
		KeyDirectory: "../Network/organizations/peerOrganizations/corporate2.greencredits.com/users/Admin@corporate2.greencredits.com/msp/keystore/",
		TLSCertPath:  "../Network/organizations/peerOrganizations/corporate2.greencredits.com/peers/peer0.corporate2.greencredits.com/tls/ca.crt",
		PeerEndpoint: "localhost:7071",
		GatewayPeer:  "peer0.corporate2.greencredits.com",
		MSPID:        "Corporate2MSP",
	},
}
