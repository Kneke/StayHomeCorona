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
		err = result.Scan(&id, &title, &description, &category, &points)

		response = append(response, model.Challenge{ID: id, Title: title, Description: description, Category: category, Points: points})
	}
	return response
}

func CreateUser(user model.User) (string, error) {
	db, err := connectToMySQL()
	defer db.Close()
	if err != nil {
		panic(err)
	}

	stmtIns, err := db.Prepare("INSERT INTO User (ID, Name, Score, Challenges) VALUES(?, ?, ?, ?)")
	if err != nil {
		return "Failure", err
	}
	_, err = stmtIns.Exec(user.ID, user.Name, user.Score, user.Challenges)
	if err != nil {
		return "Failure", err
	}
	return "Success", nil
}

func UpdateUser(user model.User, challengeId int, challengePoints int) (string, error) {
	db, err := connectToMySQL()
	defer db.Close()
	if err != nil {
		panic(err)
	}

	stmtIns, err := db.Prepare("UPDATE User SET Challenges=?, Score=? WHERE ID=?")
	if err != nil {
		return "Failure", err
	}

	userScore := user.Score + challengePoints
	user.Challenges = append(user.Challenges, challengeId) //TODO geht das?

	_, err = stmtIns.Exec(user.Challenges, userScore, user.ID)
	if err != nil {
		return "Failure", err
	}
	return "Success", nil
}

func GetRanking() model.Ranking {
	var ranking model.Ranking

	db, err := connectToMySQL()
	if err != nil {
		panic(err)
	}
	result, err := db.Query("SELECT * FROM User")
	if err != nil {
		panic(err)
	}
	for result.Next() {
		var (
			score int
			name  string
		)
		err = result.Scan(&name, &score)

		ranking.UserRankList = append(ranking.UserRankList, model.UserRank{
			Name:  name,
			Score: score,
		})
	}

	return ranking
}
