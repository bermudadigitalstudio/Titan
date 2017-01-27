import PackageDescription

let package = Package(
  name: "Titan",
  dependencies: [
    .Package(url: "https://github.com/bermudadigitalstudio/TitanCore.git", majorVersion: 0, minor: 3),
    .Package(url: "https://github.com/bermudadigitalstudio/TitanRouter.git", majorVersion: 0, minor: 3),
    .Package(url: "https://github.com/bermudadigitalstudio/TitanErrorHandling.git", majorVersion: 0, minor: 1),
    .Package(url: "https://github.com/bermudadigitalstudio/TitanJSONRequestBody.git", majorVersion: 0, minor: 1),
    .Package(url: "https://github.com/bermudadigitalstudio/TitanFormURLEncodedBodyParser.git", majorVersion: 0, minor: 2),
    .Package(url: "https://github.com/bermudadigitalstudio/TitanQueryString.git", majorVersion: 0, minor: 1),
    .Package(url: "https://github.com/bermudadigitalstudio/TitanCORS.git", majorVersion: 0, minor: 1),
  ]
)
