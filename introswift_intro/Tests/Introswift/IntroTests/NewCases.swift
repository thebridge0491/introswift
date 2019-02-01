import XCTest
@testable import class Introswift_Intro.Intro

class NewCases: XCTestCase {
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

    func testMethod1() {
    	XCTAssertEqual(4, 2 * 2)
    }

    func testDblMethod() {
    	//XCTAssertEqual(4.0, 4.0, accuracy: self.epsilon * 4.0)
    	XCTAssert(self.inEpsilon(4.0, 4.0, self.epsilon * 4.0))
    }

    func testStrMethod() {
    	XCTAssertEqual("Hello, World!", "Hello, World!")
    }

    func testFailMethod() {
    	XCTFail("fails")
    }

    /*func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }*/
}


#if !os(macOS)

extension NewCases {
    static var allTests: [(String, (NewCases) -> () throws -> Void)] {
        return [
            //("testPerformanceExample", testPerformanceExample),
            ("testMethod1", testMethod1), ("testDblMethod", testDblMethod),
            ("testStrMethod", testStrMethod), ("testFailMethod", testFailMethod)
        ]
    }
}
#endif
