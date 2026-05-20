import Foundation

final class Match {
    
    var p1Sets = 0
    var p2Sets = 0
    
    var currentSet = Set()
    
    var totalGamesCompleted = 0
    
    func addPointToPlayer1() {
        if complete() { return }
        
        let gamesBeforePoint = currentSet.p1Games + currentSet.p2Games
        
        currentSet.addPointToPlayer1()
        updateTotalGamesCompleted(gamesBeforePoint: gamesBeforePoint)
        updateAfterPoint()
    }
    
    func addPointToPlayer2() {
        if complete() { return }
        
        let gamesBeforePoint = currentSet.p1Games + currentSet.p2Games
        
        currentSet.addPointToPlayer2()
        updateTotalGamesCompleted(gamesBeforePoint: gamesBeforePoint)
        updateAfterPoint()
    }
    
    private func updateTotalGamesCompleted(gamesBeforePoint: Int) {
        let gamesAfterPoint = currentSet.p1Games + currentSet.p2Games
        
        if gamesAfterPoint > gamesBeforePoint {
            totalGamesCompleted += 1
        }
    }
    
    private func updateAfterPoint() {
        if currentSet.player1Won() {
            p1Sets += 1
            if !complete() {
                currentSet = Set(isFinalSet: isFinalSet())
            }
        } else if currentSet.player2Won() {
            p2Sets += 1
            if !complete() {
                currentSet = Set(isFinalSet: isFinalSet())
            }
        }
    }
    
    private func isFinalSet() -> Bool {
        return p1Sets + p2Sets == 4
    }
    
    func player1Serving() -> Bool {
        if currentSet.inTieBreak {
            let firstTieBreakServerIsPlayer1 = totalGamesCompleted % 2 == 0
            let tieBreakPointsPlayed = currentSet.p1TieBreakPoints + currentSet.p2TieBreakPoints
            
            if tieBreakPointsPlayed == 0 {
                return firstTieBreakServerIsPlayer1
            }
            
            let serviceGroup = (tieBreakPointsPlayed - 1) / 2
            
            if serviceGroup % 2 == 0 {
                return !firstTieBreakServerIsPlayer1
            } else {
                return firstTieBreakServerIsPlayer1
            }
        }
        
        return totalGamesCompleted % 2 == 0
    }
    
    func player2Serving() -> Bool {
        return !player1Serving()
    }
    
    func player1HasMatchPoint() -> Bool {
        if complete() { return false }
        return p1Sets == 2 && currentSet.player1HasSetPoint()
    }

    func player2HasMatchPoint() -> Bool {
        if complete() { return false }
        return p2Sets == 2 && currentSet.player2HasSetPoint()
    }
    
    func player1Won() -> Bool {
        return p1Sets == 3
    }
    
    func player2Won() -> Bool {
        return p2Sets == 3
    }
    
    func complete() -> Bool {
        return player1Won() || player2Won()
    }
}
