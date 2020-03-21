package model

// Category contain challenges
type Category struct {
	ID          int    `json:"id"`
	Title       string `json:"title"`
	Information string `json:"information"`
}
