import XCTest
@testable import Tennis_CLI

final class SetTests: XCTestCase {
    
    func testPlayer1WinsSet() {
        let set = Set()
        
        for _ in 1...24 {
            set.addPointToPlayer1()
        }
        
        XCTAssertEqual(set.p1Games, 6)
        XCTAssertEqual(set.p2Games, 0)
        XCTAssertTrue(set.player1Won())
    }
    
    func testTieBreakStartsAtSixAll() {
        let set = Set()
        
        for _ in 1...6 {
            for _ in 1...4 {
                set.addPointToPlayer1()
            }
            
            for _ in 1...4 {
                set.addPointToPlayer2()
            }
        }
        
        XCTAssertEqual(set.p1Games, 6)
        XCTAssertEqual(set.p2Games, 6)
        XCTAssertTrue(set.inTieBreak)
        XCTAssertFalse(set.complete())
    }
}
func testPlayer2WinsSet() {
    let set = Set()

    for _ in 1...24 {
        set.addPointToPlayer2()
    }

    XCTAssertEqual(set.p1Games, 0)
    XCTAssertEqual(set.p2Games, 6)
    XCTAssertTrue(set.player2Won())
}
