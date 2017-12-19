//   Copyright 2017 Enervolution GmbH
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//   https://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
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
