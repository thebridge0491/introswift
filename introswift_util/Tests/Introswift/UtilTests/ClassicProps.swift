import XCTest
import SwiftCheck
@testable import class Introswift_Util.Classic

class ClassicProps: XCTestCase {
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

    func testPropFact() {
    	let funcs = [Classic.factLp, Classic.factI]
    	let numsGen = Gen<Int>.fromElements(in: 1...12)
    	property("prop fact(n) == [1..n].product") <- forAll(numsGen) {
				(n: Int) in
        	let ans = Array(1...n).reduce(1, *)
        	return funcs.reduce(true) {acc, f in acc && ans == f(n)}
        }
    }

    func testPropExpt() {
    	let funcs = [Classic.exptLp, Classic.exptI]
    	let bsGen = Gen<UInt32>.fromElements(in: 2...19).map({b in Float(b)})
    	let numGen = Gen<UInt32>.fromElements(in: 2...9).map({n in Float(n)})
    	property("prop expt(b, n) == pow(b, n)") <- forAll(bsGen, numGen) {
    			(b: Float, n: Float) in
        	let ans = powf(b, n)
			return funcs.reduce(true) {acc, f in
				acc && self.inEpsilon(ans, f(b, n), self.epsilon * ans)}
        }
    }
}


#if !os(macOS)

extension ClassicProps {
    static var allTests: [(String, (ClassicProps) -> () throws -> Void)] {
        return [
            ("testPropFact", testPropFact), ("testPropExpt", testPropExpt)
        ]
    }
}
#endif
