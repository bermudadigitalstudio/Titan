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

// Extend all route methods to access path components directly

extension Titan {

    public func get(path: String, handler: @escaping (RequestType, ResponseType, [String: String]) -> (RequestType, ResponseType)) {
        self.get(path: path, handler: toFunction(handler, with: path))
    }

    public func post(path: String, handler: @escaping (RequestType, ResponseType, [String: String]) -> (RequestType, ResponseType)) {
        self.post(path: path, handler: toFunction(handler, with: path))
    }

    public func put(path: String, handler: @escaping (RequestType, ResponseType, [String: String]) -> (RequestType, ResponseType)) {
        self.put(path: path, handler: toFunction(handler, with: path))
    }

    public func patch(path: String, handler: @escaping (RequestType, ResponseType, [String: String]) -> (RequestType, ResponseType)) {
        self.patch(path: path, handler: toFunction(handler, with: path))
    }

    public func delete(path: String, handler: @escaping (RequestType, ResponseType, [String: String]) -> (RequestType, ResponseType)) {
        self.delete(path: path, handler: toFunction(handler, with: path))
    }

    public func options(path: String, handler: @escaping (RequestType, ResponseType, [String: String]) -> (RequestType, ResponseType)) {
        self.delete(path: path, handler: toFunction(handler, with: path))
    }

    public func head(path: String, handler: @escaping (RequestType, ResponseType, [String: String]) -> (RequestType, ResponseType)) {
        self.head(path: path, handler: toFunction(handler, with: path))
    }
}
