import XCTest
@testable import class Introswift_Util.Classic

class ClassicCases: XCTestCase {
    let epsilon:Float = 0.001

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {

        super.tearDown()
    }

    func inEpsilon(_ a: Float, _ b: Float, _ tolerance: Float = 0.001) ->
            Bool {
	    let delta = abs(tolerance)
	    //return (a - delta) <= b && (a + delta) >= b
	    return !((a + delta) < b) && !((b + delta) < a)
	}

	func cartesianProd<T>(_ arr1:[T], _ arr2:[T]) -> [(T, T)] {
        let prodArr = (arr1.flatMap {n1 in arr2.map {n2 in (n1, n2)}}
            ).filter {e in true}
        return prodArr
    }

    func testFact() {
        for f in [Classic.factLp, Classic.factI] {
            XCTAssertEqual(120, f(5)) ; XCTAssertEqual(5040, f(7))
        }
    }

    func testExpt() {
        let arr1:[Float] = [2.0, 11.0, 20.0], arr2:[Float] = [3.0, 6.0, 10.0]
        //let prodArr = arr1.flatMap {n1 in arr2.map {n2 in (n1, n2)}}
        let prodArr = self.cartesianProd(arr1, arr2)

        for (b, n) in prodArr {
            let ans = powf(b, n)
            for f in [Classic.exptLp, Classic.exptI] {
                //XCTAssertEqual(ans, f(b, n), accuracy: self.epsilon * ans)
                XCTAssert(self.inEpsilon(ans, f(b, n), self.epsilon * ans))
            }
        }
    }
}


#if !os(macOS)

extension ClassicCases {
    static var allTests: [(String, (ClassicCases) -> () throws -> Void)] {
        return [
            ("testFact", testFact), ("testExpt", testExpt)
        ]
    }
}
#endif
