import Foundation

final class Set {

    var p1Games = 0
    var p2Games = 0

    var currentGame = Game()

    var inTieBreak = false
    var p1TieBreakPoints = 0
    var p2TieBreakPoints = 0
    
    private let isFinalSet: Bool
    
    init(isFinalSet: Bool = false) {
        self.isFinalSet = isFinalSet
    }

    func addPointToPlayer1() {
        if complete() { return }

        if inTieBreak {
            p1TieBreakPoints += 1
            updateAfterTieBreakPoint()
        } else {
            currentGame.addPointToPlayer1()
            updateAfterGamePoint()
        }
    }

    func addPointToPlayer2() {
        if complete() { return }

        if inTieBreak {
            p2TieBreakPoints += 1
            updateAfterTieBreakPoint()
        } else {
            currentGame.addPointToPlayer2()
            updateAfterGamePoint()
        }
    }

    private func updateAfterGamePoint() {
        if currentGame.player1Won() {
            p1Games += 1
            currentGame = Game()
        } else if currentGame.player2Won() {
            p2Games += 1
            currentGame = Game()
        }

        if shouldStartTieBreak() {
            inTieBreak = true
            p1TieBreakPoints = 0
            p2TieBreakPoints = 0
        }
    }

    private func shouldStartTieBreak() -> Bool {
        if isFinalSet {
            return p1Games == 12 && p2Games == 12
        }
        return p1Games == 6 && p2Games == 6
    }

    private func updateAfterTieBreakPoint() {
        if tieBreakWon(p1TieBreakPoints, p2TieBreakPoints) {
            p1Games += 1
            inTieBreak = false
        } else if tieBreakWon(p2TieBreakPoints, p1TieBreakPoints) {
            p2Games += 1
            inTieBreak = false
        }
    }

    private func tieBreakWon(_ winner: Int, _ loser: Int) -> Bool {
        return winner >= 7 && (winner - loser) >= 2
    }

    func player1Won() -> Bool {
        if isFinalSet {
            return (p1Games >= 6 && (p1Games - p2Games) >= 2) || (p1Games == 13 && p2Games == 12)
        }
        return (p1Games >= 6 && (p1Games - p2Games) >= 2) || p1Games == 7
    }

    func player2Won() -> Bool {
        if isFinalSet {
            return (p2Games >= 6 && (p2Games - p1Games) >= 2) || (p2Games == 13 && p1Games == 12)
        }
        return (p2Games >= 6 && (p2Games - p1Games) >= 2) || p2Games == 7
    }

    func complete() -> Bool {
        return player1Won() || player2Won()
    }
    
    func player1HasSetPoint() -> Bool {
        if complete() { return false }
        
        if inTieBreak {
            return tieBreakWon(p1TieBreakPoints + 1, p2TieBreakPoints)
        }
        
        if currentGame.gamePointsForPlayer1() > 0 {
            let projectedP1Games = p1Games + 1
            if isFinalSet {
                return (projectedP1Games >= 6 && (projectedP1Games - p2Games) >= 2) || (projectedP1Games == 13 && p2Games == 12)
            }
            return (projectedP1Games >= 6 && (projectedP1Games - p2Games) >= 2) || projectedP1Games == 7
        }
        
        return false
    }

    func player2HasSetPoint() -> Bool {
        if complete() { return false }
        
        if inTieBreak {
            return tieBreakWon(p2TieBreakPoints + 1, p1TieBreakPoints)
        }
        
        if currentGame.gamePointsForPlayer2() > 0 {
            let projectedP2Games = p2Games + 1
            if isFinalSet {
                return (projectedP2Games >= 6 && (projectedP2Games - p1Games) >= 2) || (projectedP2Games == 13 && p1Games == 12)
            }
            return (projectedP2Games >= 6 && (projectedP2Games - p1Games) >= 2) || projectedP2Games == 7
        }
        
        return false
    }
    
}
