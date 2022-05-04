// swift-tools-version:5.5

import PackageDescription
import Foundation

func targetDepn(_ name:String) -> Target.Dependency {
    //return Target.Dependency.target(name: name)
    return Target.Dependency(stringLiteral: name)
}
let (parent, mod) = ("Introswift", "Intro")
let prefix = ProcessInfo.processInfo.environment["PREFIX"] ?? "/usr/local"

let package = Package(
    name: "\(parent)_\(mod)",
    products: [
        .library(name: "\(parent)_\(mod)"
            , type: .static // [.dynamic | .static]
            , targets: ["\(parent)_\(mod)"])
        , .executable(name: "\(parent)_\(mod)Main"
            , targets: ["\(parent)_\(mod)Main"])
    ],
    dependencies: [
        //.package(url: /* package url */, from: "1.0.0"),
	    .package(url: "https://github.com/apple/swift-docc-plugin.git", from: "1.0.0"),
	    .package(url: "https://github.com/stackotter/swift-lint-plugin.git", from: "0.1.0"),
	    .package(url: "https://github.com/typelift/SwiftCheck.git", from: "0.7.0"),
	    .package(url: "https://github.com/jdfergason/swift-toml.git", from: "1.0.0"),
	    .package(url: "https://github.com/behrang/YamlSwift.git", from: "3.0.0"),
	    .package(url: "https://github.com/dduan/TOMLDecoder.git", from: "0.2.1"),
	    .package(url: "https://github.com/jpsim/Yams.git", from: "4.0.0"),
	    //.package(url: "../introswift_util", .branch("master")),
	    //.package(path: "../introswift_util"),
	    //.package(path: "../introswift_practice")
    ],
    targets: [
        .target(
            name: "\(parent)_\(mod)"
            , dependencies: []
            , path: "Sources/\(parent)/\(mod)"
        )
        , .executableTarget(
            name: "\(parent)_\(mod)Main"
            , dependencies: [.product(name: "Toml", package: "swift-toml"),
                .product(name: "Yaml", package: "YamlSwift")
                , "TOMLDecoder", "Yams"
                //, targetDepn("\(parent)_Util")
                //, targetDepn("\(parent)_Practice")
                , targetDepn("\(parent)_\(mod)")]
            , path: "Sources/\(parent)/Main"
            , linkerSettings: [.unsafeFlags(["-L\(prefix)/lib"
            	, "-l\(parent)_Util", "-l\(parent)_Practice"])]
        )
        , .testTarget(
            name: "\(parent)_\(mod)Tests"
            , dependencies: ["SwiftCheck"//, targetDepn("\(parent)_Util")
                , targetDepn("\(parent)_\(mod)")]
            , path: "Tests/\(parent)/\(mod)Tests"
            , linkerSettings: [.unsafeFlags(["-L\(prefix)/lib"
            	, "-l\(parent)_Util"])]
        )
    ]
)
