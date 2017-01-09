import PackageDescription

var package = Package(
  name: "Titan",
  dependencies: [
    .Package(url: "https://github.com/bermudadigitalstudio/titan-core.git", majorVersion: 0),
//    .Package(url: "https://github.com/krzysztofzablocki/Sourcery.git", "0.5.0")
  ],
  exclude: ["script", "Templates", "examples", "benchmark"]
)

// Uncomment the following to compile the benchmark
//package.exclude.removeLast()
//
//package.targets = [
// Target(name: "benchmark", dependencies: ["Titan"])
//]
