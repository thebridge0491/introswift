import Foundation

public class Intro {
	public class func inEpsilon(_ a: Float, _ b: Float,
	        _ tolerance: Float = 0.001) -> Bool {
	    let delta = abs(tolerance)
	    //return (a - delta) <= b && (a + delta) >= b
	    return !((a + delta) < b) && !((b + delta) < a)
	}

    public class func cartesianProd<T>(_ arr1:[T], _ arr2:[T]) -> [(T, T)] {
        let prodArr = (arr1.flatMap {n1 in arr2.map {n2 in (n1, n2)}}
            ).filter {e in true}
        return prodArr
    }

	public class func getTextFmFile(_ filePath: String) -> String? {
		if !FileManager.default.fileExists(atPath: filePath) {
		    return nil
		}
		let fIn = FileHandle.init(forReadingAtPath: filePath)
		let dataIn = fIn!.readDataToEndOfFile()
		var str = String.init(data: dataIn, encoding: String.Encoding.utf8)
		return str?.trimmingCharacters(in: CharacterSet.newlines)
	}

    public class func getInput() -> String {
        /*let fIn = FileHandle.standardInput
        let dataIn = fIn.availableData
        let str = String.init(data:dataIn, encoding:String.Encoding.utf8)

        fIn.closeFile()
        return str!.trimmingCharacters(in:CharacterSet.newlines)*/
        return readLine()!
    }

    public class func getCharFmInput() -> Character {
        let str = readLine()!   //self.getInput()
        return str.isEmpty ? "\0" : str.first!
    }

    public class func readJSONObject(_ jsonStr: String) throws -> Any {
		let jsonData = jsonStr.data(using: .utf8)
		let jsonObject = try JSONSerialization.jsonObject(with: jsonData!,
			options: [])
		return jsonObject
    }
}
