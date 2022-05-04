import Foundation

public class Intro {
    public class func greeting(_ greetPath:String, name:String) -> String {
        NSLog("info [\(#function):\(#line)] - \(name)")
        if !FileManager.default.fileExists(atPath: greetPath) {
		    return ""
		}
        let fIn = FileHandle.init(forReadingAtPath:greetPath)
        let dataIn = fIn!.readDataToEndOfFile()
        var str = String.init(data:dataIn, encoding:String.Encoding.utf8)

        str = str?.trimmingCharacters(in:CharacterSet.newlines)
        return str!.appendingFormat(name)
    }

    public class func delayChar(_ secs:Float) -> Character {
        var ch:Character = "\0"

        while true {
            Thread.sleep(forTimeInterval:(Double(secs)))
            print("Type any character when ready: ", terminator:"")
            let str = readLine()!
            ch = str.isEmpty ? "\0" : str.first!

            if "\n" != ch && "\0" != ch {
                break
            }
        }
        return ch
    }
}
