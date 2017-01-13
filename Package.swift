import PackageDescription

let package = Package(
  name: "Titan",
  dependencies: [
    .Package(url: "https://github.com/bermudadigitalstudio/TitanCore.git", majorVersion: 0, minor: 2),
    .Package(url: "https://github.com/bermudadigitalstudio/TitanRouter.git", majorVersion: 0, minor: 0),
    .Package(url: "https://github.com/bermudadigitalstudio/TitanTopLevel.git", majorVersion: 0, minor: 0),
  ]
)
