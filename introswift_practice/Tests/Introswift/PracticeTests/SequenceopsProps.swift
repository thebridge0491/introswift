import XCTest
import SwiftCheck
import class Introswift_Util.Util
@testable import class Introswift_Practice.Sequenceops

class SequenceopsProps: XCTestCase {
    let epsilon:Float = 0.001
    let (arrInts, arrIntsRev) = ([2, 1, 0, 4, 3], [3, 4, 0, 1, 2])

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {

        super.tearDown()
    }

    func testPropFindIndex() {
        let funcs:[(Int, [Int]) -> Int?] = [Sequenceops.findIndexLp]
        property("prop findIndex(el, xs) == xs.index(el)") <- forAll {
                (data: Int, ys: [Int]) in
            let xs = Array(ys)
            let ans = xs.firstIndex(of: data)
            return funcs.reduce(true) {acc, f in acc && ans == f(data, xs)}
        }
    }

    func testPropReverse() {
        /*let fnMutImm:[((inout [Int]) -> Void, ([Int]) -> [Int])] = [
            (Sequenceops.reverseLp, Sequenceops.reverseI)]
        property("prop reverse(xs) == xs.reversed()") <- forAll {
                (ys: [Int]) in
            let xs = Array(ys)
            let ans: [Int] = xs.reversed()
            return fnMutImm.reduce(true) {acc, fnMut_fnImm in
                let (fnMut, fnImm) = (fnMut_fnImm.0, fnMut_fnImm.1)
                var tmp = Array(xs)
                fnMut(&tmp)
                return acc && ans == tmp && ans == fnImm(xs)}
        }*/
        let fnMut:[(inout [Int]) -> Void] = [Sequenceops.reverseLp]
        let fnImm:[([Int]) -> [Int]] = [Sequenceops.reverseI]
        property("prop reverse(xs) == xs.reversed()") <- forAll {
                (ys: [Int]) in
            let xs = Array(ys)
            let ans: [Int] = xs.reversed()
            return fnMut.reduce(true) {acc, f in
                var tmp = Array(xs)
                f(&tmp)
                return acc && ans == tmp}
            && fnImm.reduce(true) {acc, f in acc && ans == f(xs)}
        }
    }
}


#if !os(macOS)

extension SequenceopsProps {
    static var allTests: [(String, (SequenceopsProps) -> () throws -> Void)] {
        return [
            ("testPropFindIndex", testPropFindIndex), ("testPropReverse", testPropReverse)
        ]
    }
}
#endif
