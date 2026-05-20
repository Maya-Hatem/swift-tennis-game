import XCTest
@testable import Tennis_CLI

final class MatchTests: XCTestCase {

    func testPlayer1WinsMatch() {
        let match = Match()

        for _ in 1...72 {
            match.addPointToPlayer1()
        }

        XCTAssertEqual(match.p1Sets, 3)
        XCTAssertEqual(match.p2Sets, 0)
        XCTAssertTrue(match.player1Won())
        XCTAssertTrue(match.complete())
    }
    
    func testNoMorePointsAfterMatchComplete() {
        let match = Match()

        for _ in 1...72 {
            match.addPointToPlayer1()
        }

        XCTAssertTrue(match.complete())
        XCTAssertEqual(match.p1Sets, 3)
        XCTAssertEqual(match.p2Sets, 0)

        match.addPointToPlayer2()
        match.addPointToPlayer2()
        match.addPointToPlayer2()
        match.addPointToPlayer2()

        XCTAssertEqual(match.p1Sets, 3)
        XCTAssertEqual(match.p2Sets, 0)
        XCTAssertTrue(match.complete())
    }
    
}

func testFinalSetContinuesPastSixAll() {
    let finalSet = Set(isFinalSet: true)

    for _ in 1...6 {
        for _ in 1...4 {
            finalSet.addPointToPlayer1()
        }

        for _ in 1...4 {
            finalSet.addPointToPlayer2()
        }
    }

    XCTAssertEqual(finalSet.p1Games, 6)
    XCTAssertEqual(finalSet.p2Games, 6)
    XCTAssertFalse(finalSet.inTieBreak)
}

func testPlayer2WinsMatch() {
    let match = Match()

    for _ in 1...72 {
        match.addPointToPlayer2()
    }

    XCTAssertEqual(match.p1Sets, 0)
    XCTAssertEqual(match.p2Sets, 3)
    XCTAssertTrue(match.player2Won())
    XCTAssertTrue(match.complete())
}
