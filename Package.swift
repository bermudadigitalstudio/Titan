import PackageDescription

let package = Package(
  name: "Titan",
  dependencies: [
    .Package(url: "https://github.com/bermudadigitalstudio/titan-core.git", majorVersion: 0),
//    .Package(url: "https://github.com/krzysztofzablocki/Sourcery.git", majorVersion: 0)
  ]
)
