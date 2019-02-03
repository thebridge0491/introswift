import XCTest
import class Introswift_Util.Util
@testable import class Introswift_Practice.Sequenceops

class SequenceopsCases: XCTestCase {
    let epsilon:Float = 0.001
    let (arrInts, arrIntsRev) = ([2, 1, 0, 4, 3], [3, 4, 0, 1, 2])

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {

        super.tearDown()
    }

    func testFindIndex() {
        let funcs:[(Int, [Int]) -> Int?] = [Sequenceops.findIndexLp]
        let el = 3
        for f in funcs {
            XCTAssertEqual(arrInts.index(of: el), f(el, arrInts))
            XCTAssertEqual(Int?(4), f(el, arrInts))
            XCTAssertEqual(arrIntsRev.index(of: el), f(el, arrIntsRev))
            XCTAssertEqual(Int?(0), f(el, arrIntsRev))
        }
    }

    func testReverse() {
        let fnMutImm:[((inout [Int]) -> Void, ([Int]) -> [Int])] = [
    		(Sequenceops.reverseLp, Sequenceops.reverseI)]

        for fnMut_fnImm in fnMutImm {
			let (fnMut, fnImm) = (fnMut_fnImm.0, fnMut_fnImm.1)
            var tmp = Sequenceops.copyOfLp(arrInts)
            fnMut(&tmp)
            for i in 0..<arrInts.count {
                XCTAssertEqual(arrIntsRev[i], tmp[i])
            }
            XCTAssertEqual(arrIntsRev, tmp)

            let arrRev = fnImm(arrInts)
            for i in 0..<arrInts.count {
                XCTAssertEqual(arrIntsRev[i], arrRev[i])
            }
            XCTAssertEqual(arrIntsRev, arrRev)
        }
    }
}


#if !os(macOS)

extension SequenceopsCases {
    static var allTests: [(String, (SequenceopsCases) -> () throws -> Void)] {
        return [
            ("testFindIndex", testFindIndex), ("testReverse", testReverse)
        ]
    }
}
#endif
