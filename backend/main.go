package main

import (
	"main/model"
	"main/persistence"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	r.POST("/challenges", createChallengeHandler)
	r.GET("/challenges", challengeHandler)
	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})
	r.Run() // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
}

func challengeHandler(c *gin.Context) {
	challenges := persistence.GetChallenges()
	c.JSON(200, gin.H{
		"values": challenges,
	})
}

func createChallengeHandler(c *gin.Context) {
	var challenge model.Challenge
	if c.BindJSON(&challenge) == nil {
		result, err := persistence.CreateChallenge(challenge)
		if err != nil {
			c.JSON(400, gin.H{
				"error": err,
			})
		}
		c.JSON(200, gin.H{
			"result": result,
		})
	}
	c.JSON(500, gin.H{
		"error": "Bad Request, could not marshal JSON to Object",
	})
}
