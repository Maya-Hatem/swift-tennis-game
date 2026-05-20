import Foundation
import Combine

/**
 Do not change the method signatures for any methods in this class (that is the method names, paramater names, parameter types and return types must not be changed
 */
final class Game : ObservableObject {
    
    //You may, but don't need to, change the type of one or both of these to Strings.
    //You may also change the names if you wish
    //You must NOT add any further variables to this class
    @Published var p1Points = 0
    @Published var p2Points = 0
    
    /**
     This method will be called when player 1 wins a point and update the state of the instance of Game to reflect the change
     */
    func addPointToPlayer1(){
        if complete() { return }
        p1Points += 1
    }
    
    /**
     This method will be called when player 2 wins a point
     */
    func addPointToPlayer2(){
        if complete() { return }
        p2Points += 1
    }
    
    /**
     Returns the score for player 1, this will only ever be "0","15","30","40" or "A"
     If the game is complete, this should return an empty string
     */
    func player1Score() -> String {
        return scoreString(forPlayerPoints: p1Points, otherPlayerPoints: p2Points)
    }
    /**
     Returns the score for player 2, this will only ever be "0","15","30","40" or "A"
     If the game is complete, this should return an empty string
     */
    func player2Score() -> String {
        return scoreString(forPlayerPoints: p2Points, otherPlayerPoints: p1Points)
        
    }
    
    /**
     Returns true if player 1 has won the game, false otherwise
     */
    func player1Won() -> Bool{
        return hasWon(winnerPoints: p1Points, loserPoints: p2Points)
    }
    
    /**
     Returns true if player 2 has won the game, false otherwise
     */
    func player2Won() -> Bool{
        return hasWon(winnerPoints: p2Points, loserPoints: p1Points)
        
    }
    
    /**
     Returns true if the game is finished, false otherwise
     */
    func complete() ->Bool {
        return player1Won() || player2Won()
        
    }
    
    /**
     If, and only if, player 1 would win the game if they won the next point, returns the number of points player 2 would need to win to equalise the score, otherwise returns 0
     e.g. if the score is 40:15 to player 1, player 1 would win if they scored the next point, and player 2 would need 2 points in a row to prevent that, so this method should return 2 in that case.
     if the score is 30:0 to player 1, player 1 would not win if they won the next point, so the method would return 0
     */
    
    func gamePointsForPlayer1() -> Int {
        if complete() { return 0 }
        
        if hasWon(winnerPoints: p1Points + 1, loserPoints: p2Points) {
            return max(0, p1Points - p2Points)
        }
        
        return 0
    }
    
    
    /**
     If player 2 would win the game if they won the next point, returns the number of points player 1 would need to win to equalise the score
     */
    func gamePointsForPlayer2() -> Int {
        if complete() { return 0 }
        if hasWon(winnerPoints: p2Points + 1, loserPoints: p1Points) {
            return max(0, p2Points - p1Points)
        }
        return 0
        
    }
    
    private func hasWon(winnerPoints: Int, loserPoints: Int) -> Bool {
        
        return winnerPoints >= 4 && (winnerPoints - loserPoints) >= 2
    }
    
    private func scoreString(forPlayerPoints p: Int, otherPlayerPoints o: Int) -> String {
        if complete() { return "" }
        
        if p >= 3 && o >= 3 {
            if p == o { return "40"}
            if p == o + 1 { return "A"}
            return "40"
            
            }
        
        switch p {
        case 0: return "0"
        case 1: return "15"
        case 2: return "30"
        default: return "40"
        }
        
    }
}
    
     

