import SwiftUI

struct ContentView: View {
    
    @StateObject var gameBoard = Board()
    
    var body: some View {
        
        let borderSize = CGFloat(5)
        
        Text(gameBoard.turnTitle())
            .font(.title)
            .bold()
            .padding()
        Spacer()
        
        Text(String(format: "Crosses: %d", gameBoard.scoreX))
            .font(.title)
            .bold()
            .padding()
        
        VStack(spacing: borderSize){
            ForEach(0...2, id: \.self){
                row in HStack(spacing: borderSize){
                    ForEach(0...2, id: \.self){
                        column in let square = gameBoard.board[row][column]
                        
                        Text(square.displaySquare())
                            .font(.system(size: 60))
                            .foregroundColor(square.changeTileColor())
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .background(.white)
                            .onTapGesture{
                                gameBoard.placeTitle(row, column)
                            }
                            
                    }
                }
            }
        }
        .background(.black)
        .padding()
        .alert(isPresented: $gameBoard.displayMessage){
            Alert(
                title: Text(gameBoard.alertMessage),
                dismissButton: .default(Text("Okay"))
                {
                    gameBoard.resetBoard()
                }
            )
        }
        
        Text(String(format: "Circles: %d", gameBoard.scoreO))
            .font(.title)
            .bold()
            .padding()
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
