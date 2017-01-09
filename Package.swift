import PackageDescription

var package = Package(
  name: "Titan",
  dependencies: [
    .Package(url: "https://github.com/bermudadigitalstudio/titan-core.git", majorVersion: 0)
  ],
  exclude: ["script", "Templates", "examples", "benchmark", "TitanServerDelegate"]
)

// Uncomment the following to develop TitanServerDelegate
//package.exclude = package.exclude.filter { $0 != "TitanServerDelegate" }
//
//package.dependencies.append(
// .Package(url: "https://github.com/IBM-Swift/Kitura-net.git", majorVersion: 1)
//)

// Uncomment the following to install sourcery for development
//package.dependencies.append(
//  .Package(url: "https://github.com/krzysztofzablocki/Sourcery.git", "0.5.0")
//)

// Uncomment the following to compile the benchmark
//package.exclude = package.exclude.filter { $0 != "benchmark" }
//
//package.targets = [
//  Target(name: "benchmark", dependencies: ["Titan"])
//]
