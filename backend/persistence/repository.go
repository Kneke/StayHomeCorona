package persistence

import (
	"database/sql"
	"main/model"

	_ "github.com/go-sql-driver/mysql"
)

func connectToMySQL() (*sql.DB, error) {

	// Insert secret connection string
	return sql.Open("mysql")

}

// CreateChallenge inserts a new challenge into the database
func CreateChallenge(challenge model.Challenge) {
	db, err := connectToMySQL()
	defer db.Close()
	if err != nil {
		panic(err)
	}

	insert, err := db.Query("INSERT INTO Challenges VALUES ( 2, 'TEST' )")
	if err != nil {
		panic(err.Error())
	}
	defer insert.Close()

}

// GetChallenges loads all challenges from the database and returns them
func GetChallenges() []model.Challenge {
	db, err := connectToMySQL()
	if err != nil {
		panic(err)
	}
	response := []model.Challenge{}
	result, err := db.Query("SELECT * FROM Challenges")
	if err != nil {
		panic(err)
	}
	for result.Next() {
		var id, points int
		var title, description string
		var category model.Category
		result.Scan(&id, &title, &description, &category, &points)

		response = append([]model.Challenge{model.Challenge{id, title, description, category, points}})
	}
	return response
}
