# Titan Design

Titan is a constellation of microframeworks, and an umbrella framework that has what we consider to be "the bare essentials".

## [Titan](https://github.com/bermudadigitalstudio/Titan) (this repo)
Just add a server adapter and you have a very slim server framework.

### [Titan Core](https://github.com/bermudadigitalstudio/TitanCore)
Declares the Titan class, Request/ResponseType protocols, and Request/Response structs. The Titan class exposes two methods, `addFunction` and `app`.

### [Titan Router](https://github.com/bermudadigitalstudio/TitanRouter) (incomplete)
Extends the Titan class, providing a `route` method which ensures that the Function is only executed when it matches.

### [Titan Router + Sugar](https://github.com/bermudadigitalstudio/TitanRouter-ByRouteSugar) (incomplete)
Provides convenience methods to the router, e.g. `get`, `post` etc.

### [Titan Error Handling](https://github.com/bermudadigitalstudio/TitanErrorHandling)
Extends the Titan class to take a `ThrowingFunction`.

### [Titan Error + Routing Sugar](https://github.com/bermudadigitalstudio/TitanErrorHandling-RoutingSugar) (incomplete)
Provides throwing function overloads to the router sugar.

### [Titan JSON Request Body](https://github.com/bermudadigitalstudio/TitanJSONRequestBody)
Provides quick access to decoded JSON in the request body.

### [Titan Query String](https://github.com/bermudadigitalstudio/TitanQueryString) (incomplete)
Access the query string of the request.

### [Titan Form URL Encoded Body Parser](https://github.com/bermudadigitalstudio/TitanFormURLEncodedBodyParser)
Decode `application/x-www-form-urlencoded` data in a POST body.

### [Titan 404](https://github.com/bermudadigitalstudio/Titan404) (incomplete)
A simple function that writes a cute 404 to the Response. Put it at the top of your Function stack to get a simple Not Found behaviour in case it... isn't found.

## [Titan On Steroids](https://github.com/bermudadigitalstudio/TitanOnSteroids) (incomplete)
Titan plus the kitchen sink. Still as fast, expressive and powerful as Titan, but contains more features and conveniences, for advanced users only. Comes with a webserver. Enough batteries included to electrocute yourself.

### [Titan Top Level](https://github.com/bermudadigitalstudio/TitanTopLevel)
Redeclare all Titan instance methods in Titan On Steroids and Titan as top level functions, referring to a private instance. Useful for Sinatra-style DSLs.

### Titan ResponseType Convertible (needs creating)
Return a String, an Int, a Dictionary or your own custom type, and Titan will encode it appropriately. Overloads addFunction with an example of usage.

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

