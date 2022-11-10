import Foundation
import SwiftUI

enum SquareStatus {
    case Empty
    case O
    case X
}

struct SquareView {
    var squareStatus: SquareStatus
    
    func displaySquare() -> String {
        switch(squareStatus) {
        case SquareStatus.O:
            return "O"
        case SquareStatus.X:
            return "X"
        default:
            return""
        }
    }
    
    func changeTileColor() -> Color{
        switch(squareStatus) {
        case SquareStatus.O:
            return .blue
        case SquareStatus.X:
            return .red
        default:
            return .black
        }
    }
}
