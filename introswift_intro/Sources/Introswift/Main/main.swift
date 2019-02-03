import Foundation

import Yaml
import Yams

import class Introswift_Util.Util
import Introswift_Intro
import Introswift_Practice

struct User {
    var name:String
    var num:Int
    var timeIn:Float
}

struct UVar {
    var width = 0
    var height:Float = 0.0
}

let PI:Float = 3.14

typealias uchar_t = UInt8

enum ConstItems: Int {
    case ZERO, NUMZ = 26
}

/** Run method.

 - todo: complete function
 - author: thebridge0491
 - version: 0.1.0

// - parameter progname: program name
 - parameters:
    - progname: program name
    - rsrcPath: resources path
    - opts: dictionary of options

 - returns: n/a */
func runIntro(_ progname:String, _ rsrcPath:String, _ opts:[String: Any]) {
    let timeIn = Date()

    // basic datatypes
    let isDone:Bool = false
    var (numI, arrLen) = (0, ConstItems.ZERO.rawValue)
    var timeDiff:Float = 0.0
    let delaySecs:Float = 2.5
    var ch:Character = "\0"

    // pointers

    // strings & arrays
    var greetBuf:String, dateBuf:String
    let numArr:[Int] = [9, 0o11, 0x9, 0b1001]

    // composites
    let uvar1 = UVar()
    let pers = Person.person("I.M. Computer", age:32)


    #if os(macOS)
    let fnRand = arc4random
    #else
    let fnRand = random
    #endif
    //let seedp = UInt32(timeIn.timeIntervalSince1970)
    // srand(seedp)
    let num = (0 == opts["n"] as! Int) ? Int(fnRand() % 17 + 2) : opts["n"] as! Int

    for elem in numArr {
        numI += elem
    }
    arrLen = numArr.count
    assert((arrLen * numArr[0]) == numI, "arrLen * numArr[0] != numI")

    let user1 = User(name: "John", num: num,
		timeIn:Float(timeIn.timeIntervalSince1970))
    print("user1.description: User{name=\(user1.name)," +
		"num=\(user1.num)} \(user1.timeIn)")

    ch = Intro.delayChar(delaySecs)

    do {
        let re = try NSRegularExpression(pattern:"^(?i)quit$",
			options: NSRegularExpression.Options.init(rawValue:0))
        let match = re.firstMatch(in:opts["u"] as! String, options:
			NSRegularExpression.MatchingOptions.init(rawValue:0),
			range: NSMakeRange(0, (opts["u"] as! String).lengthOfBytes(
			using:String.Encoding.utf8)))
        print("\(match != nil ? "Good" : "Does not") match: \(opts["u"] as! String) to " +
			"\(re.pattern)")
    } catch let error {
        print(error.localizedDescription)
    }

    let dateFmtr = DateFormatter()
    (dateFmtr.dateStyle, dateFmtr.timeStyle) = (.medium, .long)
    dateBuf = dateFmtr.string(from:timeIn as Date)

    greetBuf = Intro.greeting("\(rsrcPath)/greet.txt", name:opts["u"] as! String)
    print("\(dateBuf)\n\(greetBuf)!\n")

    timeDiff = -Float(timeIn.timeIntervalSinceNow)
    print("(program \(progname)) Took \(String(format:"%.1f", timeDiff)) " +
		"seconds.\n")

    //var arrInts:[Int] = [2, 1, 0, 4, 3]
    var arrInts:[Int] = [9, 9, 9, 9]
    arrInts += [2, 1, 0, 4, 3]

    if opts["2"] as! Bool {
        let n = Float(num)
        print("expt(\(2.0), \(n)): \(Classic.exptLp(2.0, n))")
        //String(format: "expt(%.1f, n:%.1f): %.1f", Float(2.0), n, Classic.exptLp(2.0, n)))

        let res = arrInts.description
        var arr = Sequenceops.copyOfLp(arrInts)
        Sequenceops.reverseLp(&arr)
        print("reverse(\(res)): \(arr.description)")
        print("\(res).sort(<): \(arrInts.sorted(by: <).description)")
        print("\(res).sort(){(a, b) -> Bool in a > b}: " +
			"\((arrInts.sorted(by: {(a, b) -> Bool in a > b})).description)")
    } else {
        print("fact(\(num)): \(Classic.factLp(num))")

        let (res, el) = (arrInts.description, 3)
        print("findIndex(\(el), \(res)): " +
			"\(Sequenceops.findIndexLp(el, arrInts)!)")
        arrInts += [50]
        print("\(res) += [\(50)]: \(arrInts.description)")
    }
    print("".padding(toLength:40, withPad:"-", startingAt:0))


    assert(pers is Person && (pers as? Person != nil), "pers is Person")
    print("pers.description: \(pers.description)")
    pers.age = 33
    print("pers.description: \(pers.description)")
    print("".padding(toLength:40, withPad:"-", startingAt:0))
}

func printUsage(_ progname:String) {
    print("Usage: \(progname) [-u USER][-n NUM][-2][-?|-h]")
}

func parseCmdopts(_ argv:Array<String>) -> Dictionary<String, Any> {
    let options = UserDefaults.standard
    options.register(defaults: ["u":"World", "n":0, "2":false])
    NSLog("info [\(#function):\(#line)] - parseCmdopts:argv:")

    var (i, opts) = (0, options.dictionaryRepresentation())
    while i < argv.count {
        let str = argv[i].trimmingCharacters(in:CharacterSet(charactersIn:
			"- \n") as CharacterSet)
        switch (str.first! as Character) {
        case "u":
			opts["u"] = argv[i + 1] ; i = i + 1
        case "n":
			opts["n"] = Int(argv[i + 1]) ; i = i + 1
        case "2":
			opts["2"] = true
        case "h":
            printUsage(argv[0])
            exit(0) //Thread.exit()
            break

        default:
            break
        }
        i = i + 1
    }
    return opts
}

public func main() {
	let argv = CommandLine.arguments
	//let rsrcPath = "\(FileManager.default.currentDirectoryPath)/Resources"
	let rsrcPath = ProcessInfo.processInfo.environment["RSRC_PATH"] ?? "Resources"
    let options = parseCmdopts(argv)
    var tupArr:[[String]] = []

    if let jsonDict = try! Util.readJSONObject(
			Util.getTextFmFile("\(rsrcPath)/prac.json") ?? "{}") as? [String: Any] {
		var user1Dict = jsonDict["user1", default:["name": "???"]] as! [String: Any?]
		tupArr += [["\(jsonDict)"
		    , "\(jsonDict["domain", default:"???"] as! String)",
			"\(user1Dict["name"] as! String)"]]
	}

	/*if let yamlDict = try? Yaml.load(
			Util.getTextFmFile("\(rsrcPath)/prac.yaml") ?? "") {
	    var user1Dict = yamlDict["user1"] ?? ["name": "???"]
	    tupArr += [["\(yamlDict.dictionary ?? [:])"
	        , "\(nil != yamlDict.dictionary ? yamlDict["domain"].string! : "???")",
			"\(nil != user1Dict.dictionary ? user1Dict["name"].string! : "???")"]]
	}
	if let yamlDict1 = try! Yams.load(yaml:
			Util.getTextFmFile("\(rsrcPath)/prac.yaml") ?? "") as? [String: Any] {
	    var user1Dict = yamlDict1["user1", default:["name": "???"]] as! [String: Any?]
	    tupArr += [["\(yamlDict1)"
	        , "\(yamlDict1["domain", default:"???"] as! String)",
			"\(user1Dict["name"] as! String)"]]
	}*/

	for elem in tupArr {
		print("\nconfig: \(elem[0])")
		print("domain: \(elem[1])")
		print("user1Name: \(elem[2])")
	}

    runIntro(argv[0], rsrcPath, options)
}

main()
