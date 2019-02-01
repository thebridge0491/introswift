import XCTest
import SwiftCheck
@testable import class Introswift_Intro.Intro

class NewProps: XCTestCase {
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

    func testPropCommutAdd() {
    	property("prop (commutative) a + b == b + a") <- forAll {
    			(a: Int, b: Int) in
        	return a + b == b + a
        }
    }

    func testPropAssocAdd() {
    	property("prop (associative) (a + b) + c == a + (b + c)") <- forAll {
    			(a: Float, b: Float, c: Float) in
    		let res = (a + b) + c
        	return self.inEpsilon(res, a + (b + c), self.epsilon * abs(res))
        }
    }

    func testPropRevRev() {
    	property("prop xs.reverse().reverse() == xs") <- forAll {
    			(ys: [Int]) in
    		let xs: [Int] = Array(ys)
    		let tmp: [Int] = xs.reversed().reversed()
        	return xs == tmp
        }
    }

    func testPropIdRev() {
    	property("prop xs.reverse() == xs") <- forAll { (ys: [Int]) in
    		let xs: [Int] = Array(ys)
    		let tmp: [Int] = xs.reversed()
        	return xs == tmp
        }
    }

    func testPropSortRev() {
    	property("prop xs.reverse().sort() == xs.sort()") <- forAll {
    			(ys: [Float]) in
    		let xs: [Float] = Array(ys)
    		let tmp: [Float] = xs.reversed()
        	return xs.sorted() == tmp.sorted(by: <)
        }
    }

    func testPropMinSortHead() {
		let nonEmptyFloats = [Float].arbitrary.suchThat {
			$0.count > 0 && $0.count < 25 }
    	property("prop xs.min() == xs.sort().head") <- forAll(nonEmptyFloats) {
    			(ys: [Float]) in
    		let xs: [Float] = Array(ys)
			return xs.sorted().first == xs.min()
        }
    }
}


#if !os(macOS)

extension NewProps {
    static var allTests: [(String, (NewProps) -> () throws -> Void)] {
        return [
            ("testPropCommutAdd", testPropCommutAdd),
            ("testPropAssocAdd", testPropAssocAdd),
            ("testPropRevRev", testPropRevRev),
            ("testPropIdRev", testPropIdRev),
            ("testPropSortRev", testPropSortRev),
            ("testPropMinSortHead", testPropMinSortHead)
        ]
    }
}
#endif
