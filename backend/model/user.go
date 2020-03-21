package model

type User struct {
	ID         int    `json:"id"`
	Name       string `json:"name"`
	Score      int    `json:"score"`
	Challenges []int  `json:"challenges"`
}
