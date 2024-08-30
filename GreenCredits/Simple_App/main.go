package main

import (
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
)

type Token struct {
	Name     string `json:"name"`
	Symbol   string `json:"symbol"`
	Decimals string `json:"decimals"`
}

type Mint struct {
	Amount string `json:"amount"`
}

type Transfer struct {
	Recipient string `json:"recipient"`
	Amount    string `json:"amount"`
}

type Approve struct {
	Spender string `json:"spender"`
	Value   string `json:"value"`
}

const MINTER = "eDUwOTo6Q049Z292ZXJubWVudGFkbWluLE9VPWFkbWluLE89SHlwZXJsZWRnZXIsU1Q9Tm9ydGggQ2Fyb2xpbmEsQz1VUzo6Q049ZmFicmljLWNhLXNlcnZlcixPVT1GYWJyaWMsTz1IeXBlcmxlZGdlcixTVD1Ob3J0aCBDYXJvbGluYSxDPVVT"
const NGO1 = "eDUwOTo6Q049bmdvMWFkbWluLE9VPWFkbWluLE89SHlwZXJsZWRnZXIsU1Q9Tm9ydGggQ2Fyb2xpbmEsQz1VUzo6Q049ZmFicmljLWNhLXNlcnZlcixPVT1GYWJyaWMsTz1IeXBlcmxlZGdlcixTVD1Ob3J0aCBDYXJvbGluYSxDPVVT"
const NGO2 = "eDUwOTo6Q049bmdvMmFkbWluLE9VPWFkbWluLE89SHlwZXJsZWRnZXIsU1Q9Tm9ydGggQ2Fyb2xpbmEsQz1VUzo6Q049ZmFicmljLWNhLXNlcnZlcixPVT1GYWJyaWMsTz1IeXBlcmxlZGdlcixTVD1Ob3J0aCBDYXJvbGluYSxDPVVT"
const CORPORATE1 = "eDUwOTo6Q049Y29ycG9yYXRlMWFkbWluLE9VPWFkbWluLE89SHlwZXJsZWRnZXIsU1Q9Tm9ydGggQ2Fyb2xpbmEsQz1VUzo6Q049ZmFicmljLWNhLXNlcnZlcixPVT1GYWJyaWMsTz1IeXBlcmxlZGdlcixTVD1Ob3J0aCBDYXJvbGluYSxDPVVT"
const CORPORATE2 = "eDUwOTo6Q049Y29ycG9yYXRlMmFkbWluLE9VPWFkbWluLE89SHlwZXJsZWRnZXIsU1Q9Tm9ydGggQ2Fyb2xpbmEsQz1VUzo6Q049ZmFicmljLWNhLXNlcnZlcixPVT1GYWJyaWMsTz1IeXBlcmxlZGdlcixTVD1Ob3J0aCBDYXJvbGluYSxDPVVT"

func main() {

	router := gin.Default()

	router.Static("/assets", "./dist/assets")

	router.NoRoute(func(c *gin.Context) {
		c.File("./dist/index.html")
	})

	router.POST("/api/init", func(ctx *gin.Context) {
		var req Token
		if err := ctx.BindJSON(&req); err != nil {
			ctx.JSON(http.StatusBadRequest, gin.H{"message": "Bad request"})
			return
		}

		result := submitTxnFn(
			"government",
			"fabrixchannel",
			"sample-chaincode",
			"SmartContract",
			"invoke",
			make(map[string][]byte),
			"Initialize",
			req.Name,
			req.Symbol,
			req.Decimals,
		)
		ctx.JSON(http.StatusOK, gin.H{"message": "Created new token", "result": result})
	})

	router.POST("/api/mint", func(ctx *gin.Context) {
		var req Mint
		if err := ctx.BindJSON(&req); err != nil {
			ctx.JSON(http.StatusBadRequest, gin.H{"message": "Bad request"})
			return
		}
		// fmt.Println("reqqq", req)
		result := submitTxnFn(
			"government",
			"fabrixchannel",
			"sample-chaincode",
			"SmartContract",
			"invoke",
			make(map[string][]byte),
			"Mint",
			req.Amount,
		)
		ctx.JSON(http.StatusOK, gin.H{"message": "minted greenCredits", "result": result})
	})

	router.POST("/api/ngo1/transfer", func(ctx *gin.Context) {
		var req Transfer
		if err := ctx.BindJSON(&req); err != nil {
			ctx.JSON(http.StatusBadRequest, gin.H{"message": "Bad request"})
			return
		}

		if req.Recipient == "Corporate1" {
			req.Recipient = CORPORATE1
		}

		if req.Recipient == "Corporate2" {
			req.Recipient = CORPORATE2
		}

		// fmt.Println("request", req)
		result := submitTxnFn(
			"ngo1",
			"fabrixchannel",
			"sample-chaincode",
			"SmartContract",
			"invoke",
			make(map[string][]byte),
			"TransferFrom",
			MINTER,
			req.Recipient,
			req.Amount,
		)
		ctx.JSON(http.StatusOK, gin.H{"message": "transfered greenCredits", "result": result})
	})

	router.POST("/api/ngo2/transfer", func(ctx *gin.Context) {
		var req Transfer
		if err := ctx.BindJSON(&req); err != nil {
			ctx.JSON(http.StatusBadRequest, gin.H{"message": "Bad request"})
			return
		}

		if req.Recipient == "Corporate1" {
			req.Recipient = CORPORATE1
		}

		if req.Recipient == "Corporate2" {
			req.Recipient = CORPORATE2
		}

		// fmt.Println("request", req)
		result := submitTxnFn(
			"ngo2",
			"fabrixchannel",
			"sample-chaincode",
			"SmartContract",
			"invoke",
			make(map[string][]byte),
			"TransferFrom",
			MINTER,
			req.Recipient,
			req.Amount,
		)
		ctx.JSON(http.StatusOK, gin.H{"message": "transfered greenCredits", "result": result})
	})

	router.POST("/api/corporate1/transfer", func(ctx *gin.Context) {
		var req Transfer
		if err := ctx.BindJSON(&req); err != nil {
			ctx.JSON(http.StatusBadRequest, gin.H{"message": "Bad request"})
			return
		}

		if req.Recipient == "Corporate1" {
			req.Recipient = CORPORATE1
		}

		if req.Recipient == "Corporate2" {
			req.Recipient = CORPORATE2
		}

		// fmt.Println("request", req)
		result := submitTxnFn(
			"corporate1",
			"fabrixchannel",
			"sample-chaincode",
			"SmartContract",
			"invoke",
			make(map[string][]byte),
			"Transfer",
			req.Recipient,
			req.Amount,
		)
		ctx.JSON(http.StatusOK, gin.H{"message": "transfered greenCredits", "result": result})
	})


	router.POST("/api/corporate2/transfer", func(ctx *gin.Context) {
		var req Transfer
		if err := ctx.BindJSON(&req); err != nil {
			ctx.JSON(http.StatusBadRequest, gin.H{"message": "Bad request"})
			return
		}

		if req.Recipient == "Corporate1" {
			req.Recipient = CORPORATE1
		}

		if req.Recipient == "Corporate2" {
			req.Recipient = CORPORATE2
		}

		// fmt.Println("request", req)
		result := submitTxnFn(
			"corporate2",
			"fabrixchannel",
			"sample-chaincode",
			"SmartContract",
			"invoke",
			make(map[string][]byte),
			"Transfer",
			req.Recipient,
			req.Amount,
		)
		ctx.JSON(http.StatusOK, gin.H{"message": "transfered greenCredits", "result": result})
	})


	router.POST("/api/approve", func(ctx *gin.Context) {
		var req Approve
		if err := ctx.BindJSON(&req); err != nil {
			ctx.JSON(http.StatusBadRequest, gin.H{"message": "Bad request"})
			return
		}

		if req.Spender == "NGO1" {
			req.Spender = NGO1
		}

		if req.Spender == "NGO2" {
			req.Spender = NGO2
		}

		fmt.Println("request", req)
		result := submitTxnFn(
			"government",
			"fabrixchannel",
			"sample-chaincode",
			"SmartContract",
			"invoke",
			make(map[string][]byte),
			"Approve",
			req.Spender,
			req.Value,
		)
		ctx.JSON(http.StatusOK, gin.H{"message": "allocated", "result": result})
	})

	router.GET("/api/clientId", func(ctx *gin.Context) {

		result := submitTxnFn(
			"corporate2",
			"fabrixchannel",
			"sample-chaincode",
			"SmartContract", "query", make(map[string][]byte), "ClientAccountID")
		ctx.JSON(http.StatusOK, gin.H{"data": result})
	})


	router.GET("/api/ngo1/allowance", func(ctx *gin.Context) {

		result := submitTxnFn(
			"ngo1",
			"fabrixchannel",
			"sample-chaincode",
			"SmartContract", "query", make(map[string][]byte), "Allowance", MINTER, NGO1)
		ctx.JSON(http.StatusOK, gin.H{"data": result})
	})

	router.GET("/api/ngo2/allowance", func(ctx *gin.Context) {

		result := submitTxnFn(
			"ngo2",
			"fabrixchannel",
			"sample-chaincode",
			"SmartContract", "query", make(map[string][]byte), "Allowance", MINTER, NGO2)
		ctx.JSON(http.StatusOK, gin.H{"data": result})
	})


	router.GET("/api/totalsupply", func(ctx *gin.Context) {
		result := submitTxnFn("government",
			"fabrixchannel",
			"sample-chaincode",
			"SmartContract", "query", make(map[string][]byte), "TotalSupply")
		ctx.JSON(http.StatusOK, gin.H{"data": result})
	})


	router.GET("/api/corporate1/balance", func(ctx *gin.Context) {
		result := submitTxnFn("corporate1",
			"fabrixchannel",
			"sample-chaincode",
			"SmartContract", "query", make(map[string][]byte), "ClientAccountBalance")
		ctx.JSON(http.StatusOK, gin.H{"data": result})
	})


	router.GET("/api/corporate2/balance", func(ctx *gin.Context) {
		result := submitTxnFn("corporate2",
			"fabrixchannel",
			"sample-chaincode",
			"SmartContract", "query", make(map[string][]byte), "ClientAccountBalance")
		ctx.JSON(http.StatusOK, gin.H{"data": result})
	})

	router.Run(":8000")
}
