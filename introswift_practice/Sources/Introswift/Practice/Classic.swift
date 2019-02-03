import Foundation

public class Classic {
    public class func factLp(_ n:Int) -> Int {
        var acc:Int = 1
        NSLog("info [\(#function):\(#line)] - Classic.factLp:")

        for i in (1...n).reversed() {
            acc *= i
        }
        return acc
    }

    public class func factI(_ n:Int) -> Int {
        func iter(_ n:Int, _ acc:Int) -> Int {
            return n > 1 ? iter(n - 1, n * acc) : acc
        }
        return iter(n, 1)
    }

    public class func exptLp(_ b:Float, _ n:Float) -> Float {
        var acc:Float = 1.0

        for _ in (1...Int(n)).reversed() {
            acc *= b
        }
        return acc
    }

    public class func exptI(_ b:Float, _ n:Float) -> Float {
        func iter(_ b:Float, _ n:Float, _ acc:Float) -> Float {
            return n > 0.0 ? iter(b, n - 1.0, b * acc) : acc
        }
        return iter(b, n, 1.0)
    }
}
