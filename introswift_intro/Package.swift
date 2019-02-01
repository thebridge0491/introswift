// swift-tools-version:4.2

import PackageDescription

func targetDepn(_ name:String) -> Target.Dependency {
    //return Target.Dependency.target(name: name)
    return Target.Dependency(stringLiteral: name)
}
let (parent, mod) = ("Introswift", "Intro")

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
	    .package(url: "https://github.com/typelift/SwiftCheck.git", from: "0.7.0"),
	    .package(url: "https://github.com/behrang/YamlSwift.git", from: "3.0.0"),
	    .package(url: "https://github.com/jpsim/Yams.git", from: "0.3.6"),
	    //.package(url: "../introswift_util", .branch("master")),
	    //.package(path: "../introswift_util")
    ],
    targets: [
        .target(
            name: "\(parent)_\(mod)"
            , dependencies: []
            , path: "Sources/\(parent)/\(mod)")
        , .target(
            name: "\(parent)_\(mod)Main"
            , dependencies: ["Yaml", "Yams", targetDepn("\(parent)_\(mod)")]
            , path: "Sources/\(parent)/Main")
        , .testTarget(
            name: "\(parent)_\(mod)Tests"
            , dependencies: ["SwiftCheck", targetDepn("\(parent)_\(mod)")]
            , path: "Tests/\(parent)/\(mod)Tests"
            , exclude: ["ClassicCases.swift", "ClassicProps.swift"]
        )
    ]
)
