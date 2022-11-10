import Foundation

class Board: ObservableObject {
    @Published var board = [[SquareView]]()
    @Published var turn = SquareStatus.O
    @Published var scoreO = 0
    @Published var scoreX = 0
    @Published var displayMessage = false
    @Published var alertMessage = "Draw"
    
    init() {
        resetBoard()
    }
    
    func turnTitle() -> String {
        return turn == SquareStatus.O ? "Turn O" : "Turn X"
    }
    
    func placeTitle(_ row: Int, _ column: Int) {
        if (board[row][column].squareStatus != SquareStatus.Empty) {
            return
        }
        
        board[row][column].squareStatus = turn == SquareStatus.O ? SquareStatus.O : SquareStatus.X
        
        if (checkForVictory()){
            if (turn == SquareStatus.O){
                scoreO += 1
            }
            else{
                scoreX += 1
            }
            
            let winner = turn == SquareStatus.O ? "O's" : "X's"
            alertMessage = winner + " Win!"
            displayMessage = true
            return
        }
        else{
            turn = turn == SquareStatus.O ? SquareStatus.X : SquareStatus.O
        }
        
        if (checkForDraw()) {
            alertMessage = "Draw"
            displayMessage = true
        }
    }
    
    func checkForDraw() -> Bool {
        for row in board {
            for square in row {
                if (square.squareStatus == SquareStatus.Empty) {
                    return false
                }
            }
        }
        return true
    }
    
    func checkForVictory() -> Bool {
        // Horizontal
        if (squareTurnPossession(0,0) && squareTurnPossession(0,1) && squareTurnPossession(0,2)) {
            return true
        }
        if (squareTurnPossession(1,0) && squareTurnPossession(1,1) && squareTurnPossession(1,2)) {
            return true
        }
        if (squareTurnPossession(2,0) && squareTurnPossession(2,1) && squareTurnPossession(2,2)) {
            return true
        }
        
        // Vertical
        if (squareTurnPossession(0,0) && squareTurnPossession(1,0) && squareTurnPossession(2,0)) {
            return true
        }
        if (squareTurnPossession(0,1) && squareTurnPossession(1,1) && squareTurnPossession(2,1)) {
            return true
        }
        if (squareTurnPossession(0,2) && squareTurnPossession(1,2) && squareTurnPossession(2,2)) {
            return true
        }
        
        // Cross
        if (squareTurnPossession(0,0) && squareTurnPossession(1,1) && squareTurnPossession(2,2)) {
            return true
        }
        if (squareTurnPossession(0,2) && squareTurnPossession(1,1) && squareTurnPossession(2,0)) {
            return true
        }
        
        return false
    }
    
    func squareTurnPossession(_ row: Int, _ column: Int) -> Bool {
        return board[row][column].squareStatus == turn
    }
    
    func resetBoard() {
        var newBoard = [[SquareView]]()
        
        for _ in 0...2{
            var row = [SquareView]()
            for _ in 0...2{
                row.append(SquareView(squareStatus: SquareStatus.Empty))
            }
            newBoard.append(row)
        }
        board = newBoard
    }
}
