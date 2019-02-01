import Foundation

public class Person {
    public var version:Int, name:String, age:Int, timeIn:Date
    
    public init(_ name:String = "ToDo", age:Int = 0, timeIn:Date = Date()) {
        (self.name, self.age) = (name, age)
        self.timeIn = timeIn
        //super.init()
        self.version = 2
        NSLog("info [\(#function):\(#line)] - Person()")
    }
    
    public convenience init(_ name:String = "ToDo", age:Int = 0) {
        self.init(name, age:age, timeIn:Date())
    }
    
    public class func person(_ name:String = "ToDo", age:Int = 0) -> Person {
        return Person(name, age:age, timeIn:Date())
    }
    
    //override
    public func isEqualTo(_ object: AnyObject?) -> Bool {
        var res:Bool = true
        let obj = object as? Person
        
        res = res && (obj != nil)
        res = res && self.name == obj!.name
        res = res && self.age == obj!.age
        res = res && self.timeIn == obj!.timeIn
        
        return res
    }
    
    //override
    public func isEqual(_ object: AnyObject?) -> Bool {
        let obj = object as? Person
        
        if (obj == nil) {
            return false
        }
        if self === obj! {
            return true
        }
        return self.isEqualTo(object)
    }
    
    //override
    public var hash: Int {
        //var res = self.name.hashValue + self.age.hashValue + 
		//	self.timeIn.hashValue
        let prime:Int = 31
        var res:Int = 17
        
        res = prime * res + ((self.name.isEmpty) ? 0 : self.name.hashValue)
        res = prime * res + self.age
        res = prime * res + self.timeIn.hashValue
        
        return res
    }
    
    //override
    public var description:String {
        let dateFmtr = DateFormatter()
        (dateFmtr.dateStyle, dateFmtr.timeStyle) = (.medium, .long)
        return "\(type(of:self)){name=\(name), age=\(age), " +
			"timeIn=\(dateFmtr.string(from:timeIn))}"
    }
}
