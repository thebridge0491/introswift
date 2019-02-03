import Foundation

public class Sequenceops {
    public class func swapItems<T>(_ idx1:Int, _ idx2:Int, _ arr:inout [T]) {
        //let swap:T = arr[idx1] ; arr[idx1] = arr[idx2] ; arr[idx2] = swap
        (arr[idx1], arr[idx2]) = (arr[idx2], arr[idx1])
    }

    public class func copyOfLp<T>(_ arr:[T]) -> [T] {
        var newArr = [T]()

        for elem in arr {
            newArr.append(elem)
        }
        return newArr
    }

    public class func findIndexLp<T:Comparable>(_ data:T, _ arr:[T]) -> Int? {
        for i in 0..<arr.count {
            if (arr[i] == data) {
                return Int?(i) //Optional<Int>(i)
            }
        }
        return nil //Optional.none
    }

    public class func reverseLp<T>(_ arr:inout [T]) {
        NSLog("info [\(#function):\(#line)] - Sequenceops.reverseLp:")
        for i in 0..<(arr.count / 2) {
            swapItems(i, (arr.count - 1 - i) , &arr)
        }
    }

    public class func reverseI<T>(_ arr:[T]) -> [T] {
        func iter(_ rst:[T], _ acc:[T]) -> [T] {
            if rst.isEmpty {
                return acc
            } else {
                return iter(Array(rst.dropLast()), acc + [rst.last!])
            }
        }
        return iter(arr, [T]())
    }
}
