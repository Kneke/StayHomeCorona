package model
	
// Challenge is grouped in categories
type Challenge struct {
	ID 			int 	`json:"id"`
	Title 		string 	`json:"title"`
	Description string 	`json:"description"`
	Category  	string 	`json:"category"`
	Points 		int 	`json:"points"`
}