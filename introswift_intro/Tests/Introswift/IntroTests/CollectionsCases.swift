import XCTest
import class Introswift_Util.Util
@testable import class Introswift_Intro.Intro

class CollectionsCases: XCTestCase {
    let epsilon:Float = 0.001

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {

        super.tearDown()
    }

    func testArrays() {
        let longArr:[Int64] = [16, 2, 77, 29]
        let nines:[Int64] = [9, 9, 9, 9]
        var arr1:[Int64] = []
        XCTAssertTrue(arr1.isEmpty, "isEmpty")
        arr1.append(contentsOf: longArr)
        XCTAssertEqual(longArr.count, arr1.count, "length")
        XCTAssertEqual(longArr[0], arr1[0], "first")
        XCTAssertEqual(1, arr1.index(of: longArr[1]), "indexOf")
        arr1.append(contentsOf: nines)
        XCTAssertEqual(longArr.count + nines.count, arr1.count, "append")
        let res = arr1.sorted()
        XCTAssertEqual("[2, 9, 9, 9, 9, 16, 29, 77]", "\(res)", "sorted")
    }

    func testSets() {
        let charArr:[Character] = ["a", "e", "k", "p", "u", "k", "a"]
        var set1: Set<Character> = []
        let set2: Set<Character> = ["q", "p", "z", "u"]

        XCTAssertTrue(set1.isEmpty)
        set1 = Set(charArr)
        XCTAssertTrue(set1.contains("a"), "contains")
        XCTAssertEqual(["a", "e", "k", "p", "u", "q", "z"],
            set1.union(set2), "union")
        XCTAssertEqual(["p", "u"], set1.intersection(set2), "intersect")
        XCTAssertEqual(["a", "e", "k"], set1.subtracting(set2), "differ")
        XCTAssertEqual(["a", "e", "k", "q", "z"],
            set1.symmetricDifference(set2), "xor")
    }

    func testDicts() {
        let charArr:[Character] = ["a", "e", "k", "p", "u", "k", "a"]
        var key1:String = ""
        var dict1:[String: Character] = [:]
        XCTAssertTrue(dict1.isEmpty)
        for i in 0..<charArr.count {
            key1 = "ltr \(i % 5)"
            dict1[key1] = charArr[i]
        }
        XCTAssertTrue(nil != dict1["ltr 1"], "contains")
        XCTAssertEqual("k", dict1["ltr 2"], "get")
        dict1.removeValue(forKey: "ltr 2")
        XCTAssertTrue(nil == dict1["ltr 2"], "remove")
        dict1["ltr 2"] = "Z"
        XCTAssertEqual("Z", dict1["ltr 2"], "put")
    }
}


#if !os(macOS)

extension CollectionsCases {
    static var allTests: [(String, (CollectionsCases) -> () throws -> Void)] {
        return [
            ("testArrays", testArrays), ("testSets", testSets),
            ("testDicts", testDicts)
        ]
    }
}
#endif
