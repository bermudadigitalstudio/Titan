# Titan

Titan is an extensible, powerful & easy-to-use microframework for <b>server-side Swift</b>.<br/>
Write and run **production web apps & services** under Linux or Docker in a convenient way.

[![Language Swift 3](https://img.shields.io/badge/Language-Swift%203-orange.svg)](https://swift.org) ![Platforms](https://img.shields.io/badge/Platforms-Docker%20%7C%20Linux%20%7C%20macOS-blue.svg) [![CircleCI](https://circleci.com/gh/bermudadigitalstudio/Titan/tree/master.svg?style=shield)](https://circleci.com/gh/bermudadigitalstudio/Titan)

## Features

1. very modular with a light-weight core for routing & JSON
1. add features with plug & play middleware packages
1. functional design which makes it easy to write own middleware
1. use different webservers like Kitura or Nest
1. incredibly fast due to its light-weight design
1. built for latest Swift 3.x, Docker & Linux
1. conceptually similar to the powerful & modular frameworks Express.js or Flask

## Example

The following example has the following features:

- some routes to demo parameters, different request methods & wildcard routes
- demo of how simply it is to have a middleware manipulate the response
- uses Kitura as high-performance webserver


**Package.swift**:

```swift
import PackageDescription

let package = Package(
    name: "mywebapp",
    dependencies: [
        .Package(url: "https://github.com/bermudadigitalstudio/Titan.git", majorVersion: 0, minor: 7),
        .Package(url: "https://github.com/bermudadigitalstudio/TitanKituraAdapter.git", majorVersion: 0, minor: 4)
    ]
)
```


**main.swift**:

```swift

import Titan
import TitanKituraAdapter

let app = Titan()

/// Hello World, req is sent to next matching route 
app.get("/") { req, _ in
    return (req, Response(200, "Hello World"))
}

/// 2 parameters in URL
app.delete("/item/*/subitem/*") { req, param1, param2, _ in
	let text = "I will delete \(param2) in \(param1)"
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

/// a quick in-line middleware function to optionally set 404 response code
/// can be used by other routes / functions
func send404IfNoMatch(req: RequestType, res: ResponseType) -> (RequestType, ResponseType) {
	var res = res.copy()
	if res.code < 200 {
		res.code = 404
		res.body = "Page Not Found"
	}
	return (req, res)
}

/// use the 404 middleware on all routes and request methods
app.addFunction(send404IfNoMatch)

// start the Kitura webserver on port 8000
TitanKituraAdapter.serve(app.app, on: 8000)
```

You can now run the webserver and open [http://localhost:8000](http://localhost:8000) or [http://localhost:8000/item/foo/subitem/bar](http://localhost:8000/item/apple/subitem/banana) or send JSON via POST to [http://localhost:8000/data](http://localhost:8000/data)

## Tests

Execute `Scripts/test.sh` to run all unit-tests inside a Docker container.

## Contributing

Titan is maintained by Thomas Catterall ([@swizzlr](https://github.com/swizzlr)), Johannes Erhardt ([@johanneserhardt](https://github.com/johanneserhardt)) and Sebastian Kreutzberger ([@skreutzberger](https://github.com/skreutzberger)).

Contributions are more than welcomed. You can either work on existing Github issues or discuss with us your ideas in a new Github issue. Thanks 🙌

## Background and License

Titan was initially developed in a project run with [Bermuda Digital Studio (BDS)](http://www.bdstudio.de) Germany. BDS is a team devoted to enable digital product management, design and development for the retail business of the renewable energies corp [innogy SE](http://www.innogy.com). The goal is to digitize and disrupt energy.

Titan Framework is released under the [Apache 2.0 License](https://github.com/bermudadigitalstudio/titan/blob/master/LICENSE.txt).
