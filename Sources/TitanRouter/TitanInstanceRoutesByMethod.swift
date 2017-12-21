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

// Core routing methods for Titan, matching HTTP methods
extension Titan {

    public func get(path: String, handler: @escaping Function) {
        route(method: .get, path: path, handler: handler)
    }

    public func post(path: String, handler: @escaping Function) {
        route(method: .post, path: path, handler: handler)
    }

    public func put(path: String, handler: @escaping Function) {
        route(method: .put, path: path, handler: handler)
    }

    public func patch(path: String, handler: @escaping Function) {
        route(method: .patch, path: path, handler: handler)
    }

    public func delete(path: String, handler: @escaping Function) {
        route(method: .delete, path: path, handler: handler)
    }

    public func options(path: String, handler: @escaping Function) {
        route(method: .options, path: path, handler: handler)
    }

    public func head(path: String, handler: @escaping Function) {
        route(method: .head, path: path, handler: handler)
    }

    public func custom(withName name: String, path: String, handler: @escaping Function) {
        route(method: .custom(named: name), path: path, handler: handler)
    }

}
