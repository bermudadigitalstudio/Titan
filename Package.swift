import PackageDescription

let package = Package(
  name: "Titan",
  dependencies: [
    .Package(url: "https://github.com/bermudadigitalstudio/titan-core.git", majorVersion: 0),
    .Package(url: "https://github.com/bermudadigitalstudio/titan-router.git", majorVersion: 0, minor: 0),
    .Package(url: "https://github.com/bermudadigitalstudio/TitanTopLevel.git", majorVersion: 0, minor: 0),
  ]
)
