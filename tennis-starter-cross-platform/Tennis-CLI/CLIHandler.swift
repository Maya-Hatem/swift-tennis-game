/**
 Do not add any init methods to this class, i.e. it must be able to be constructed without any parameters
 */
final class CLIHandler {
    
    //The below Game object is included for demo purposes.
    //It is expected that this will be removed, and instead there will be an instance of whatever class represents the whole match instead
    private let match = Match()
    
    
    /**
     Update this function as needed but do not change the name or method signature (i.e. don't add any parameters or a return type)
     This function must not have any side effects (the state of the Match should not change as a result of it being called)
     This means that changes to the state of the match must be initiated by code in the 'addPointToPlayer1' or 'addPointToPlayer2' function
     */
    func getScoreboard() -> Scoreboard{
        
        let p1Points = match.currentSet.inTieBreak ? "\(match.currentSet.p1TieBreakPoints)" : match.currentSet.currentGame.player1Score()
        
        let p2Points = match.currentSet.inTieBreak ? "\(match.currentSet.p2TieBreakPoints)" : match.currentSet.currentGame.player2Score()
        //todo: add code here to get the values (e.g. from your Match class) to pass into the generateScoreboard function
        
        //todo: modify the code that creates the scoreboard to pass the correct values
        return Scoreboard(
            p1PrevSets: "-",
            p1MatchScore: match.p1Sets,
            p1SetScore: match.currentSet.p1Games,
            p1GameScore: p1Points,
            p2PrevSets: "-",
            p2MatchScore: match.p2Sets,
            p2SetScore: match.currentSet.p2Games,
            p2GameScore: p2Points
        )
    }
    
    /**
     Update this function as needed but do not change the name or method signature (i.e. don't add any parameters or a return type)
     The logic in the function should, in due course, update the state of the Match
     */
    func addPointToPlayer1(){
        match.addPointToPlayer1()
    }
    
    /**
     Update this function as needed but do not change the name or method signature (i.e. don't add any parameters or a return type)
     The logic in the function should, in due course, update the state of the Match
     */
    func addPointToPlayer2(){
        match.addPointToPlayer2()
    }
    
    
    /**
     Do not modify this function in any way
     */
    
    func run() {
        
        print ("Type the number of the player you want to add a point to, or anything else to exit: ")
        print ("you can also use the following")
        print("q: 4 points (1 game) to player 1")
        print("w: 4 points (1 game) to player 2")
        print("a: 24 points (1 normal set) to player 1")
        print("s: 24 points (1 normal set) to player 2")
        
        //Do not modify this loop in any way
        whileLoop: while (true)
        {
            let board = getScoreboard()
            print(board.printView())
            
            
            switch (readLine()){
            case "1": addPointToPlayer1()
                break;
            case "2": addPointToPlayer2()
                break;
            case "q" : (1...4).forEach { _ in addPointToPlayer1()}
                break;
            case "a" : (1...24).forEach { _ in addPointToPlayer1()}
                break;
            case "w" : (1...4).forEach { _ in addPointToPlayer2()}
                break;
            case "s" : (1...24).forEach { _ in addPointToPlayer2()}
                break;
            default: break whileLoop
            }
        }
    }
    
}
