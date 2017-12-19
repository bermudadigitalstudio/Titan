// swift-tools-version:4.0

//   Copyright 2017 Enervolution GmbH
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//   https://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
import PackageDescription

let package = Package(
    name: "Titan",
    products: [
        .library(name: "TitanCore", targets: ["TitanCore"]),
        .library(name: "Titan", targets: ["Titan"]),
        .library(name: "TitanRouter", targets: ["TitanRouter"]),
        .library(name: "TitanErrorHandling", targets: ["TitanErrorHandling"]),
        .library(name: "Titan404", targets: ["Titan404"]),
        .library(name: "TitanCORS", targets: ["TitanCORS"]),
        .library(name: "TitanFormURLEncodedBodyParser", targets: ["TitanFormURLEncodedBodyParser"]),
        .library(name: "TitanJSON", targets: ["TitanJSON"]),
        .library(name: "TitanQueryString", targets: ["TitanQueryString"]),
        .library(name: "TitanHealthz", targets:["TitanHealthz"])
    ],
    targets: [
        .target(name: "TitanCore"),
        .target(name:"Titan", dependencies: [
            "TitanCore",
            "TitanRouter",
            "TitanErrorHandling",
            "Titan404",
            "TitanCORS",
            "TitanFormURLEncodedBodyParser",
            "TitanJSON",
            "TitanQueryString"]),
        .target(name:"TitanRouter", dependencies: ["TitanCore"]),
        .target(name:"TitanErrorHandling", dependencies: ["TitanCore"]),
        .target(name:"Titan404", dependencies: ["TitanCore"]),
        .target(name:"TitanCORS", dependencies: ["TitanCore"]),
        .target(name:"TitanFormURLEncodedBodyParser", dependencies: ["TitanCore"]),
        .target(name:"TitanJSON", dependencies: ["TitanCore"]),
        .target(name:"TitanQueryString", dependencies: ["TitanCore"]),
        .target(name:"TitanHealthz", dependencies: ["TitanCore"]),
        .testTarget(name: "TitanTests", dependencies: ["Titan"]),
        .testTarget(name: "TitanCoreTests", dependencies: ["TitanCore"]),
        .testTarget(name: "TitanRouterTests", dependencies: ["TitanRouter"]),
        .testTarget(name: "Titan404Tests", dependencies: ["Titan404"]),
        .testTarget(name: "TitanCORSTests", dependencies: ["TitanCORS"]),
        .testTarget(name: "TitanFormURLEncodedBodyParserTests", dependencies: ["TitanFormURLEncodedBodyParser"]),
        .testTarget(name: "TitanErrorHandlingTests", dependencies: ["TitanErrorHandling"]),
        .testTarget(name: "TitanJSONTests", dependencies: ["TitanJSON"]),
        .testTarget(name: "TitanQueryStringTests", dependencies: ["TitanQueryString"]),
        .testTarget(name: "TitanHealthzTests", dependencies: ["TitanHealthz"])
    ]
)
