import TitanCore

func toFunction(_ handler: @escaping (RequestType, String, ResponseType) -> (RequestType, ResponseType), with pathTemplate: String) -> Function {
    return { req, res in
        let param = extractParameters(from: req.path, with: pathTemplate)
        return handler(req, param[0], res)
    }
}

func toFunction(_ handler: @escaping (RequestType, String, String, ResponseType) -> (RequestType, ResponseType), with pathTemplate: String) -> Function {
    return { req, res in
        let param = extractParameters(from: req.path, with: pathTemplate)
        return handler(req, param[0], param[1], res)
    }
}

func toFunction(_ handler: @escaping (RequestType, String, String, String, ResponseType) -> (RequestType, ResponseType), with pathTemplate: String) -> Function {
    return { req, res in
        let param = extractParameters(from: req.path, with: pathTemplate)
        return handler(req, param[0], param[1], param[2], res)
    }
}

func toFunction(_ handler: @escaping (RequestType, String, String, String, String, ResponseType) -> (RequestType, ResponseType), with pathTemplate: String) -> Function {
    return { req, res in
        let param = extractParameters(from: req.path, with: pathTemplate)
        return handler(req, param[0], param[1], param[2], param[3], res)
    }
}

func toFunction(_ handler: @escaping (RequestType, String, String, String, String, String, ResponseType) -> (RequestType, ResponseType), with pathTemplate: String) -> Function {
    return { req, res in
        let param = extractParameters(from: req.path, with: pathTemplate)
        return handler(req, param[0], param[1], param[2], param[3], param[4], res)
    }
}

/// Extract the parameters from a path given a template.
/// It is a programmer error to pass a path template containing a different number of components to the path itself, and may result in undefined behavior.
/// Where the `path` is /users/567/email
/// Where the `template` is /users/*/email
/// return [567]
func extractParameters(from path: String, with template: String) -> [String] {
    // Split the path and the template into its individual parts
    let pathComps = path.splitOnSlashes()
    let templateComps = template.splitOnSlashes()
    // Zip them together
    let z = zip(pathComps, templateComps)
    var ret: [String] = []
    for (pathComp, templateComp) in z {
        guard templateComp == "*" else {
            continue
        }
        ret.append(pathComp)
    }
    return ret
}
