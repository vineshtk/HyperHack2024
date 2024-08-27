package main

import (
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
)

type Token struct {
	Name     string `json:"name"`
	Symbol   string `json:"symbol"`
	Decimals string `json:"decimal"`
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
		fmt.Println("reqqq", req)
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

	router.POST("/api/transfer", func(ctx *gin.Context) {
		var req Transfer
		if err := ctx.BindJSON(&req); err != nil {
			ctx.JSON(http.StatusBadRequest, gin.H{"message": "Bad request"})
			return
		}

		fmt.Println("request", req)
		result := submitTxnFn(
			"issuer",
			"fabrixchannel",
			"sample-chaincode",
			"SmartContract",
			"invoke",
			make(map[string][]byte),
			"TransferFrom",
			"eDUwOTo6Q049Z292ZXJubWVudGFkbWluLE9VPWFkbWluLE89SHlwZXJsZWRnZXIsU1Q9Tm9ydGggQ2Fyb2xpbmEsQz1VUzo6Q049ZmFicmljLWNhLXNlcnZlcixPVT1GYWJyaWMsTz1IeXBlcmxlZGdlcixTVD1Ob3J0aCBDYXJvbGluYSxDPVVT",
			req.Recipient,
			req.Amount,
		)
		ctx.JSON(http.StatusOK, gin.H{"message": "minted greenCredits", "result": result})
	})

	router.POST("/api/approve", func(ctx *gin.Context) {
		var req Approve
		if err := ctx.BindJSON(&req); err != nil {
			ctx.JSON(http.StatusBadRequest, gin.H{"message": "Bad request"})
			return
		}

		if req.Spender == "NGO1" {
			req.Spender = "eDUwOTo6Q049aXNzdWVyYWRtaW4sT1U9YWRtaW4sTz1IeXBlcmxlZGdlcixTVD1Ob3J0aCBDYXJvbGluYSxDPVVTOjpDTj1mYWJyaWMtY2Etc2VydmVyLE9VPUZhYnJpYyxPPUh5cGVybGVkZ2VyLFNUPU5vcnRoIENhcm9saW5hLEM9VVM="
		}

		if req.Spender == "NGO2" {
			req.Spender = "eDUwOTo6Q049YnV5ZXJhZG1pbixPVT1hZG1pbixPPUh5cGVybGVkZ2VyLFNUPU5vcnRoIENhcm9saW5hLEM9VVM6OkNOPWZhYnJpYy1jYS1zZXJ2ZXIsT1U9RmFicmljLE89SHlwZXJsZWRnZXIsU1Q9Tm9ydGggQ2Fyb2xpbmEsQz1VUw=="
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

		result := submitTxnFn("government",
			"fabrixchannel",
			"sample-chaincode",
			"SmartContract", "query", make(map[string][]byte), "ClientAccountID")
		ctx.JSON(http.StatusOK, gin.H{"data": result})
	})

	router.GET("/api/balance", func(ctx *gin.Context) {

		result := submitTxnFn(
			"buyer",
			"fabrixchannel",
			"sample-chaincode",
			"SmartContract", "query", make(map[string][]byte), "ClientAccountBalance")
		ctx.JSON(http.StatusOK, gin.H{"data": result})
	})

	router.GET("/api/ngo1/allowance", func(ctx *gin.Context) {

		result := submitTxnFn(
			"buyer",
			"fabrixchannel",
			"sample-chaincode",
			"SmartContract", "query", make(map[string][]byte), "Allowance", "eDUwOTo6Q049Z292ZXJubWVudGFkbWluLE9VPWFkbWluLE89SHlwZXJsZWRnZXIsU1Q9Tm9ydGggQ2Fyb2xpbmEsQz1VUzo6Q049ZmFicmljLWNhLXNlcnZlcixPVT1GYWJyaWMsTz1IeXBlcmxlZGdlcixTVD1Ob3J0aCBDYXJvbGluYSxDPVVT", "eDUwOTo6Q049aXNzdWVyYWRtaW4sT1U9YWRtaW4sTz1IeXBlcmxlZGdlcixTVD1Ob3J0aCBDYXJvbGluYSxDPVVTOjpDTj1mYWJyaWMtY2Etc2VydmVyLE9VPUZhYnJpYyxPPUh5cGVybGVkZ2VyLFNUPU5vcnRoIENhcm9saW5hLEM9VVM=")
		ctx.JSON(http.StatusOK, gin.H{"data": result})
	})

	router.GET("/api/ngo2/allowance", func(ctx *gin.Context) {

		result := submitTxnFn(
			"buyer",
			"fabrixchannel",
			"sample-chaincode",
			"SmartContract", "query", make(map[string][]byte), "Allowance", "eDUwOTo6Q049Z292ZXJubWVudGFkbWluLE9VPWFkbWluLE89SHlwZXJsZWRnZXIsU1Q9Tm9ydGggQ2Fyb2xpbmEsQz1VUzo6Q049ZmFicmljLWNhLXNlcnZlcixPVT1GYWJyaWMsTz1IeXBlcmxlZGdlcixTVD1Ob3J0aCBDYXJvbGluYSxDPVVT", "eDUwOTo6Q049YnV5ZXJhZG1pbixPVT1hZG1pbixPPUh5cGVybGVkZ2VyLFNUPU5vcnRoIENhcm9saW5hLEM9VVM6OkNOPWZhYnJpYy1jYS1zZXJ2ZXIsT1U9RmFicmljLE89SHlwZXJsZWRnZXIsU1Q9Tm9ydGggQ2Fyb2xpbmEsQz1VUw==")
		ctx.JSON(http.StatusOK, gin.H{"data": result})
	})

	router.GET("/api/totalsupply", func(ctx *gin.Context) {

		result := submitTxnFn("government",
			"fabrixchannel",
			"sample-chaincode",
			"SmartContract", "query", make(map[string][]byte), "TotalSupply")
		ctx.JSON(http.StatusOK, gin.H{"data": result})
	})

	router.GET("/api/balanceof", func(ctx *gin.Context) {

		result := submitTxnFn("issuer",
			"fabrixchannel",
			"sample-chaincode",
			"SmartContract", "query", make(map[string][]byte), "BalanceOf", "dfgsgsDG")
		ctx.JSON(http.StatusOK, gin.H{"data": result})
	})

	router.Run(":8000")
}
