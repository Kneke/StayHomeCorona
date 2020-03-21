package persistence

import (
	"database/sql"
	"main/common"
	"main/model"

	// We need the mysql databse driver
	_ "github.com/go-sql-driver/mysql"
)

func connectToMySQL() (*sql.DB, error) {
	dataSourceName := common.LoadEnv("DB_CONNECTION_STRING")

	// Insert secret connection string
	return sql.Open("mysql", dataSourceName)
}

// CreateChallenge inserts a new challenge into the database
func CreateChallenge(challenge model.Challenge) (string, error) {
	db, err := connectToMySQL()
	defer db.Close()
	if err != nil {
		panic(err)
	}

	// _, err = db.Query("INSERT INTO Challenges(ID, Title, Description, Category, Points) VALUES($1, $2, $3, $4, $5)", challenge.ID, challenge.Title, challenge.Description, challenge.Category, challenge.Points)
	// if err != nil {
	// 	return "Failure", err
	// }
	// return "Success", nil

	// Insert several books
	stmtIns, err := db.Prepare("INSERT INTO Challenges (ID, Title, Description, Category, Points) VALUES(?, ?,?,?,?)")
	if err != nil {
		return "Failure", err
	}
	_, err = stmtIns.Exec(challenge.ID, challenge.Title, challenge.Description, challenge.Category, challenge.Points)
	if err != nil {
		return "Failure", err
	}
	return "Success", nil
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
		var title, description, category string
		result.Scan(&id, &title, &description, &category, &points)

		response = append(response, model.Challenge{ID: id, Title: title, Description: description, Category: category, Points: points})
	}
	return response
}
