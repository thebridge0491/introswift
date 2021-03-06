import XCTest
@testable import class Introswift_Util.Util

class NewCases: XCTestCase {
    let epsilon:Float = 0.001

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {

        super.tearDown()
    }

    func testMethod1() {
    	XCTAssertEqual(4, 2 * 2)
    }

    func testDblMethod() {
    	//XCTAssertEqual(4.0, 4.0, accuracy: self.epsilon * 4.0)
    	XCTAssert(Util.inEpsilon(4.0, 4.0, self.epsilon * 4.0))
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
