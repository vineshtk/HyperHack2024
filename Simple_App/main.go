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

		fmt.Println("request", req)
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

	router.GET("/api/balance", func(ctx *gin.Context) {

		result := submitTxnFn("issuer",
			"fabrixchannel",
			"sample-chaincode",
			"SmartContract", "query", make(map[string][]byte), "ClientAccountBalance")
		ctx.JSON(http.StatusOK, gin.H{"data": result})
	})

	router.Run(":8000")
}
