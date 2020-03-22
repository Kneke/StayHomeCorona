package main

import (
	"fmt"
	"main/model"
	"main/persistence"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()

	v1 := r.Group("/v1")
	{
		v1.POST("/challenges", createChallengeHandler)
		v1.GET("/challenges", challengeHandler)
		v1.POST("/user", createUser)
		v1.GET("/user", getUser)
		v1.POST("/challengeDone", challengeDoneHandler)
		v1.GET("/ranking", getRanking)

		v1.GET("/ping", func(c *gin.Context) {
			c.JSON(200, gin.H{
				"message": "pong",
			})
		})
	}

	err := r.Run() // listen and serve on 0.0.0.0:8080 (for windows "localhost:8080")
	if err != nil {
		fmt.Print(err)
	}
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

func getRanking(c *gin.Context) {
	ranking := persistence.GetRanking()
	c.JSON(200, gin.H{
		"values": ranking,
	})
}

func getUser(c *gin.Context) {
	var uis userIdStruct

	if c.BindJSON(&uis) == nil {
		fmt.Println(uis)
		user := persistence.GetUser(uis.Userid)
		fmt.Println(user)
		c.JSON(200, gin.H{
			"values": user,
		})
	}
}

type userIdStruct struct {
	Userid string `json:"userid"`
}

func createUser(c *gin.Context) {
	var user model.User
	if c.BindJSON(&user) == nil {
		result, err := persistence.CreateUser(user)
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

func challengeDoneHandler(c *gin.Context) {
	var userupdate model.UserUpdate
	if c.BindJSON(&userupdate) == nil {
		result, err := persistence.UpdateUser(userupdate)
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
