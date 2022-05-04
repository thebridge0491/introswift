// swift-tools-version:5.5

import PackageDescription
import Foundation

func targetDepn(_ name:String) -> Target.Dependency {
    //return Target.Dependency.target(name: name)
    return Target.Dependency(stringLiteral: name)
}
let (parent, mod) = ("Introswift", "Util")
let prefix = ProcessInfo.processInfo.environment["PREFIX"] ?? "/usr/local"

let package = Package(
    name: "\(parent)_\(mod)",
    products: [
        .library(name: "\(parent)_\(mod)"
            , type: .static // [.dynamic | .static]
            , targets: ["\(parent)_\(mod)"])
    ],
    dependencies: [
        //.package(url: /* package url */, from: "1.0.0"),
	    .package(url: "https://github.com/apple/swift-docc-plugin.git", from: "1.0.0"),
	    .package(url: "https://github.com/stackotter/swift-lint-plugin.git", from: "0.1.0"),
	    .package(url: "https://github.com/typelift/SwiftCheck.git", from: "0.7.0"),
	    //.package(url: "../introswift_util", .branch("master")),
	    //.package(path: "../introswift_util")
    ],
    targets: [
        .target(
            name: "\(parent)_\(mod)"
            , dependencies: []
            , path: "Sources/\(parent)/\(mod)"
        )
        , .testTarget(
            name: "\(parent)_\(mod)Tests"
            , dependencies: ["SwiftCheck", targetDepn("\(parent)_\(mod)")]
            , path: "Tests/\(parent)/\(mod)Tests"
            //, linkerSettings: [.unsafeFlags(["-L\(prefix)/lib"
            //	, "-l\(parent)_Util"])]
        )
    ]
)
