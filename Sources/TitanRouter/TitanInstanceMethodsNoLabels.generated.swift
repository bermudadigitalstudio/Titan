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

// Routing methods for Titan overloaded with no labels
extension Titan {

    public func get(_ path: String, _ handler: @escaping Function) {
        self.get(path: path, handler: handler)
    }

    public func post(_ path: String, _ handler: @escaping Function) {
        self.post(path: path, handler: handler)
    }

    public func put(_ path: String, _ handler: @escaping Function) {
        self.put(path: path, handler: handler)
    }

    public func patch(_ path: String, _ handler: @escaping Function) {
        self.patch(path: path, handler: handler)
    }

    public func delete(_ path: String, _ handler: @escaping Function) {
        self.delete(path: path, handler: handler)
    }

    public func options(_ path: String, _ handler: @escaping Function) {
        self.options(path: path, handler: handler)
    }

    public func head(_ path: String, _ handler: @escaping Function) {
        self.head(path: path, handler: handler)
    }

    public func get(_ path: String, handler: @escaping (RequestType, ResponseType, [String: String]) -> (RequestType, ResponseType)) {
        self.get(path: path, handler: toFunction(handler, with: path))
    }

    public func post(_ path: String, _ handler: @escaping (RequestType, ResponseType, [String: String]) -> (RequestType, ResponseType)) {
        self.post(path: path, handler: handler)
    }

    public func put(_ path: String, _ handler: @escaping (RequestType, ResponseType, [String: String]) -> (RequestType, ResponseType)) {
        self.put(path: path, handler: handler)
    }

    public func patch(_ path: String, _ handler: @escaping (RequestType, ResponseType, [String: String]) -> (RequestType, ResponseType)) {
        self.patch(path: path, handler: handler)
    }

    public func delete(_ path: String, _ handler: @escaping (RequestType, ResponseType, [String: String]) -> (RequestType, ResponseType)) {
        self.delete(path: path, handler: handler)
    }

    public func options(_ path: String, _ handler: @escaping (RequestType, ResponseType, [String: String]) -> (RequestType, ResponseType)) {
        self.options(path: path, handler: handler)
    }

    public func head(_ path: String, _ handler: @escaping (RequestType, ResponseType, [String: String]) -> (RequestType, ResponseType)) {
        self.head(path: path, handler: handler)
    }

    public func route(_ method: String?, _ path: String, _ handler: @escaping Function) {
        self.route(method: method, path: path, handler: handler)
    }

    public func addFunction(_ path: String, _ handler: @escaping Function) {
        self.addFunction(path: path, handler: handler)
    }

    public func allMethods(_ path: String, _ handler: @escaping Function) {
        self.allMethods(path: path, handler: handler)
    }

}
