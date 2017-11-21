# Titan Design

## Design Goals

Titan was conceived with the goals of being architecturally elegant and simple.

In the past, these goals have often been at odds with "easy". In order to maintain the ability to offer both simple and easy, an abstraction was born: `TitanCore`.

From this abstraction we obtain `Titan`, an umbrella framework of `TitanCore` combined with enough extra packages to make it minimally usable, without providing too much that it appears to work like magic.

> Deciding what goes into Titan is the hardest aspect of designing this framework.

## Project Structure

Swift 4 introduced product definitions, which allows us to use a sort of monorepo – we can have all Titan microframeworks in one place, and they can be selectively compiled and linked as needed by the user.

This also makes updates a lot easier – in Swift 3, tagging and releasing 12 different repositories to accomodate an API change in TitanCore was awful, to say the least.

## Components included in the Titan Umbrella Framework

|Component|Contains|
|---|---|
|[TitanCore](../Sources/TitanCore)|Core types, and the definition of the Titan class|
|[TitanRouter](../Sources/TitanRouter)|Provides conditional execution of functions on path matches|
|[TitanErrorHandling](../Sources/TitanErrorHandling)| Extends the Titan class to take a `ThrowingFunction`.|
|[Titan404](../Sources/Titan404)|A small helper that ensures the default response is 404, in case no other middleware handles the request.|
|[TitanCORS](../Sources/TitanCORS)|Respond to Cross-Origin Resource Sharing requests|
|[TitanJSON](../Sources/TitanJSON)|Access the body of a request as a JSON object, and write JSONEncodable objects to the response.|
|[TitanFormURLEncodedBodyParser](../Sources/TitanFormURLEncodedBodyParser)|Decode `application/x-www-form-urlencoded` data in a POST body.|
|[TitanQueryString](../Sources/TitanQueryString)|Access the query string of the request.|

## Components not included in the Titan umbrella framework

These libraries are considered extremely useful, but not applicable to all.

|Component|Contains|
|---|---|
|[TitanHealthz](../Sources/TitanHealthz)|Quickly add a `healthz` health check endpoint to any Titan app|

## Planned Libraries
- Subscript headers
- Subscript query string
- Simplified route versioning

## Deprecated Libraries

### [Titan On Steroids](https://github.com/bermudadigitalstudio/TitanOnSteroids) (incomplete)
Titan plus the kitchen sink. Still as fast, expressive and powerful as Titan, but contains more features and conveniences, for advanced users only. Comes with a webserver. Enough batteries included to electrocute yourself.

### [Titan Top Level](https://github.com/bermudadigitalstudio/TitanTopLevel)
Redeclare all Titan instance methods in Titan On Steroids and Titan as top level functions, referring to a private instance. Useful for Sinatra-style DSLs.

### Titan Function Overloads (needs creating/refactoring)
Overloads addFunction with convenient variants including the ability to mutate the input parameters, as well as `ResponseType Convertible`.

### Titan Function Overloads + Routing Sugar (needs creating/refactoring)
Overloads all of the functions provided by the routing sugar with the same overloads as `TitanFunctionOverloads`.

### Titan JSON ResponseType Convertible (needs creating)
Return JSON objects, send down encoded strings of delight.

### Titan OnceOnly Routing
For more complex APIs, guarantee that only one or none of your routes will match.

### Titan Smoothie
Polish off your requests with sensible defaults, including `Content-Length` headers, encoding specifiers and other sanitary things.

