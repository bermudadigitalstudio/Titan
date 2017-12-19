# Titan

Titan is an extensible, powerful & easy-to-use microframework for <b>server-side Swift</b>.<br/>
Write and run **production web apps & services** under Linux or Docker in a convenient way.

## Language Support

Swift 3 is no longer supported, but exists under the 0.7.x tags.

[![Language Swift 4](https://img.shields.io/badge/Language-Swift%204-orange.svg)](https://swift.org) ![Platforms](https://img.shields.io/badge/Platforms-Docker%20%7C%20Linux%20%7C%20macOS-blue.svg) [![CircleCI](https://circleci.com/gh/bermudadigitalstudio/Titan/tree/master.svg?style=shield)](https://circleci.com/gh/bermudadigitalstudio/Titan)

## Features

1. very modular with a light-weight core for routing & JSON
1. add features with plug & play middleware packages
1. functional design which makes it easy to write own middleware
1. use different webservers like Kitura or Swift-Server/HTTP
1. incredibly fast due to its light-weight design
1. built for latest Swift 4, Docker & Linux
1. conceptually similar to the powerful & modular frameworks Express.js or Flask

## Example

The following example has the following features:

- some routes to demo parameters, different request methods & wildcard routes
- demo of how simply it is to have a middleware manipulate the response
- uses Kitura as high-performance webserver


**Package.swift**:

```swift
// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "mywebapp",
    products: [
        .executable(name: "mywebapp", targets: ["mywebapp"]),
    ],
    dependencies: [
        .package(url: "https://github.com/bermudadigitalstudio/TitanKituraAdapter.git", from: "0.8.0"),
        .package(url: "https://github.com/bermudadigitalstudio/Titan", from: "0.8.0")
    ],
    targets: [
        .target(
            name: "mywebapp",
            dependencies: [
                "TitanKituraAdapter",
                "Titan"
            ]),
    ]
)
```


**main.swift**:

```swift

import Titan
import TitanKituraAdapter

let app = Titan()

/// The Response is set to 404 by default.
/// if no subsequent routing function is called, a 404 will be returned
app.addFunction(DefaultTo404)

/// Hello World, req is sent to next matching route 
app.get("/") { req, _ in
    return (req, Response(200, "Hello World")) // here we "overwrite" the 404 that was returned in the previous func.
}

/// 2 parameters in URL
app.delete("/item/{item_id}/subitem/{sub_item_id}") { req, res, paramaters in
    let itemId = params["item_id"] ?? ""
    let subId = params["sub_item_id"] ?? ""
	let text = "I will delete \(subId) in \(itemId)"
    return(req, Response(200, text))
}

/// parse JSON sent via POST, return 400 on parsing error
app.post("/data") { req, _ in
    guard let json = req.json as? [String: Any] else {
        return (req, Response(400))
    }
    return(req, Response(200, "I received \(json)"))
}

/// let’s manipulate the response of all GET routes
/// and yes, that is already a simple example for a middleware!
app.get("*") { req, res in
	var newRes = res.copy()  // res is a constant, so we need to copy
	newRes.body += " and hello from the middleware!"
    return (req, newRes)  // will return "Hello World and hello from the middleware!"
}


// start the Kitura webserver on port 8000
TitanKituraAdapter.serve(app.app, on: 8000)
```

You can now run the webserver and open [http://localhost:8000](http://localhost:8000) or [http://localhost:8000/item/foo/subitem/bar](http://localhost:8000/item/apple/subitem/banana) or send JSON via POST to [http://localhost:8000/data](http://localhost:8000/data)

## Concepts

- A Titan app is very simple: it is an array of functions that each get called. The output of one function is the input to the next.
- The first function receives the HTTP request and a dummy response.
- The last returned response is sent to the client.
- How you use Titan is up to you: you can modify the request before you pass it on further. You can compress or rewrite responses before they are sent to the client.
- Titan allows you to easily write integration tests without needing a full HTTP client.
- Titan allows you to write _unit tests_ by decomposing your request handling code into `Function`s and testing that directly.
- Titan is not suitable for large or monolithic applications. Ideally, your entire Titan app should be readable in one page.

## Tests

Execute `Scripts/test.sh` to run all unit-tests inside a Docker container.

## Contributing

Titan is maintained by Thomas Catterall ([@swizzlr](https://github.com/swizzlr)), Johannes Erhardt ([@johanneserhardt](https://github.com/johanneserhardt)) and Sebastian Kreutzberger ([@skreutzberger](https://github.com/skreutzberger)).

Contributions are more than welcomed. You can either work on existing Github issues or discuss with us your ideas in a new Github issue. Thanks 🙌

## Background and License

Titan was initially developed in a project run with [Bermuda Digital Studio (BDS)](http://www.bdstudio.de) Germany. BDS is a team devoted to enable digital product management, design and development for the retail business of the renewable energies corp [innogy SE](http://www.innogy.com). The goal is to digitize and disrupt energy.

Titan Framework is released under the [Apache 2.0 License](https://github.com/bermudadigitalstudio/titan/blob/master/LICENSE.txt).
