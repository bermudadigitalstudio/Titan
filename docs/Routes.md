# Routing syntax

## Simple matches

Match path `/username` with any HTTP method.

```swift
route("/username")
```

(equivalent to)
```swift
route("username")
```

(and equivalent to)
```swift
route("username/")
```

Match all HTTP paths with any method. You may want to consider simply using Titan's core [`middleware`](https://github.com/bermudadigitalstudio/titan-core/blob/692e2eec60a0fc6c44bea113cb2c8574ba7d9d26/Sources/TitanCore.swift#L40-L42) method instead, if routing by path is not required

```swift
route("*")
```

(equivalent to)
```swift
middleware()
```

Match all HTTP GETs.

```swift
get("*")
```

Match all HTTP GETs with path `/username`.

```swift
get("/username")
```

Match all HTTP POSTs with path `/username`.

```swift
post("/username")
```
