import SwiftUI

struct ContentView: View {
    
    @State private var match = Match()
    @State private var refresh = 0
    
    var body: some View {
        
        HStack {
            Button("Restart"){
                restart()
            }.padding()
            Spacer()
        }
        
        TennisScoreboardView(match: match, refresh: $refresh)
    }
    
    /**
     This function should allow the user to start scoring a new Tennis Match
     */
    func restart(){
        match = Match()
        refresh += 1
    }
}

struct TennisScoreboardView: View {
    
    let match: Match
    @Binding var refresh: Int
    
    var setScoresP1: String {
        return "-"
    }
    
    var setScoresP2: String {
        return "-"
    }
    
    var setsWonP1: String {
        return "\(match.p1Sets)"
    }
    
    var setsWonP2: String {
        return "\(match.p2Sets)"
    }
    
    var gamesP1: String {
        return "\(match.currentSet.p1Games)"
    }
    
    var gamesP2: String {
        return "\(match.currentSet.p2Games)"
    }
    
    var pointsP1: String {
        if match.currentSet.inTieBreak {
            return "\(match.currentSet.p1TieBreakPoints)"
        }
        return match.currentSet.currentGame.player1Score()
    }
    
    var pointsP2: String {
        if match.currentSet.inTieBreak {
            return "\(match.currentSet.p2TieBreakPoints)"
        }
        return match.currentSet.currentGame.player2Score()
    }
    
    
    
    
    var p1PointBackground: Color {
        match.currentSet.currentGame.gamePointsForPlayer1() > 0 ? .green : .clear
    }

    var p2PointBackground: Color {
        match.currentSet.currentGame.gamePointsForPlayer2() > 0 ? .green : .clear
    }

    var p1GameBackground: Color {
        match.currentSet.player1HasSetPoint() ? .green : .clear
    }

    var p2GameBackground: Color {
        match.currentSet.player2HasSetPoint() ? .green : .clear
    }

    var p1SetBackground: Color {
        match.player1HasMatchPoint() ? .green : .clear
    }

    var p2SetBackground: Color {
        match.player2HasMatchPoint() ? .green : .clear
    }
    
    

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Set Scores")
                    .frame(width: 100, alignment: .center)
                Text("Player")
                    .frame(width: 80, alignment: .leading)
                Text("Sets")
                    .frame(width: 50, alignment: .center)
                Text("Games")
                    .frame(width: 60, alignment: .center)
                Text("Points")
                    .frame(width: 60, alignment: .center)
            }

            HStack {
                Text(setScoresP1)
                    .frame(width: 100, alignment: .center)
                
                Text("Player 1")
                    .frame(width: 80, alignment: .center)
                
                Text(setsWonP1)
                    .frame(width: 50, alignment: .center)
                    .background(p1SetBackground)

                Text(gamesP1)
                    .frame(width: 60, alignment: .center)
                    .background(p1GameBackground)

                Text(pointsP1)
                    .frame(width: 60, alignment: .center)
                    .background(p1PointBackground)
            }

            HStack {
                Text(setScoresP2)
                    .frame(width: 100, alignment: .center)
                
                Text("Player 2")
                    .frame(width: 80, alignment: .center)
                
                Text(setsWonP2)
                    .frame(width: 50, alignment: .center)
                    .background(p2SetBackground)

                Text(gamesP2)
                    .frame(width: 60, alignment: .center)
                    .background(p2GameBackground)

                Text(pointsP2)
                    .frame(width: 60, alignment: .center)
                    .background(p2PointBackground)
            }
        }
        .padding()
        
        Spacer()
        
        HStack{
            Button("Player 1") {
                p1AddPoint()
            }
            .padding(.leading, 32.0)
            .buttonStyle(.borderedProminent)
            
            Spacer()
            
            Button("Player 2") {
                p2AddPoint()
            }
            .padding(.trailing, 32.0)
            .buttonStyle(.borderedProminent)
        }
    }
    
    func p1AddPoint(){
        match.addPointToPlayer1()
        refresh += 1
    }

    func p2AddPoint(){
        match.addPointToPlayer2()
        refresh += 1
    }
}

#Preview {
    ContentView()
}
