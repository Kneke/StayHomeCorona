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

	stmtIns, err := db.Prepare("INSERT INTO Challenges (ChallengeID, ChallengeTitle, ChallengeDescription, ChallengeCategory, ChallengePoints) VALUES(?, ?,?,?,?)")
	if err != nil {
		return "Failure", err
	}
	_, err = stmtIns.Exec(challenge.ChallengeID, challenge.ChallengeTitle, challenge.ChallengeDescription, challenge.ChallengeCategory, challenge.ChallengePoints)
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
	var response []model.Challenge
	result, err := db.Query("SELECT * FROM Challenges")
	if err != nil {
		panic(err)
	}
	for result.Next() {
		var id, points int
		var title, description, category string
		err = result.Scan(&id, &title, &description, &category, &points)

		response = append(response, model.Challenge{ChallengeID: id, ChallengeTitle: title, ChallengeDescription: description, ChallengeCategory: category, ChallengePoints: points})
	}
	return response
}

func CreateUser(user model.User) (string, error) {
	db, err := connectToMySQL()
	defer db.Close()
	if err != nil {
		panic(err)
	}

	stmtIns, err := db.Prepare("INSERT INTO Users (ID, Name, Score) VALUES(?, ?, ?, ?)")
	if err != nil {
		return "Failure", err
	}
	_, err = stmtIns.Exec(user.UserID, user.UserName, user.UserScore)
	if err != nil {
		return "Failure", err
	}
	return "Success", nil
}

func UpdateUser(userupdate model.UserUpdate) (string, error) {
	db, err := connectToMySQL()
	defer db.Close()
	if err != nil {
		panic(err)
	}

	//Update Score in User
	stmtIns, err := db.Prepare("UPDATE Users SET Score=Score+? WHERE ID=?")
	if err != nil {
		return "Failure", err
	}
	_, err = stmtIns.Exec(userupdate.Points, userupdate.UserID)
	if err != nil {
		return "Failure", err
	}

	//Insert done challenge in User-Challenge Table
	stmtIns2, err := db.Prepare("INSERT INTO UserChallenge (UC_User, UC_Challenge) VALUES(?,?)")
	if err != nil {
		return "Failure", err
	}
	_, err = stmtIns2.Exec(userupdate.UserID, userupdate.ChallengeID)
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
	result, err := db.Query("SELECT * FROM Users")
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
