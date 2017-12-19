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

    public func get(path: String, handler: @escaping (RequestType, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 1)
        self.get(path: path, handler: toFunction(handler, with: path))
    }
    public func get(path: String, handler: @escaping (RequestType, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 2)
        self.get(path: path, handler: toFunction(handler, with: path))
    }
    public func get(path: String, handler: @escaping (RequestType, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 3)
        self.get(path: path, handler: toFunction(handler, with: path))
    }
    public func get(path: String, handler: @escaping (RequestType, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 4)
        self.get(path: path, handler: toFunction(handler, with: path))
    }
    public func get(path: String, handler: @escaping (RequestType, String, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 5)
        self.get(path: path, handler: toFunction(handler, with: path))
    }

    public func post(path: String, handler: @escaping (RequestType, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 1)
        self.post(path: path, handler: toFunction(handler, with: path))
    }
    public func post(path: String, handler: @escaping (RequestType, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 2)
        self.post(path: path, handler: toFunction(handler, with: path))
    }
    public func post(path: String, handler: @escaping (RequestType, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 3)
        self.post(path: path, handler: toFunction(handler, with: path))
    }
    public func post(path: String, handler: @escaping (RequestType, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 4)
        self.post(path: path, handler: toFunction(handler, with: path))
    }
    public func post(path: String, handler: @escaping (RequestType, String, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 5)
        self.post(path: path, handler: toFunction(handler, with: path))
    }

    public func put(path: String, handler: @escaping (RequestType, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 1)
        self.put(path: path, handler: toFunction(handler, with: path))
    }
    public func put(path: String, handler: @escaping (RequestType, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 2)
        self.put(path: path, handler: toFunction(handler, with: path))
    }
    public func put(path: String, handler: @escaping (RequestType, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 3)
        self.put(path: path, handler: toFunction(handler, with: path))
    }
    public func put(path: String, handler: @escaping (RequestType, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 4)
        self.put(path: path, handler: toFunction(handler, with: path))
    }
    public func put(path: String, handler: @escaping (RequestType, String, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 5)
        self.put(path: path, handler: toFunction(handler, with: path))
    }

    public func patch(path: String, handler: @escaping (RequestType, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 1)
        self.patch(path: path, handler: toFunction(handler, with: path))
    }
    public func patch(path: String, handler: @escaping (RequestType, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 2)
        self.patch(path: path, handler: toFunction(handler, with: path))
    }
    public func patch(path: String, handler: @escaping (RequestType, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 3)
        self.patch(path: path, handler: toFunction(handler, with: path))
    }
    public func patch(path: String, handler: @escaping (RequestType, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 4)
        self.patch(path: path, handler: toFunction(handler, with: path))
    }
    public func patch(path: String, handler: @escaping (RequestType, String, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 5)
        self.patch(path: path, handler: toFunction(handler, with: path))
    }

    public func delete(path: String, handler: @escaping (RequestType, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 1)
        self.delete(path: path, handler: toFunction(handler, with: path))
    }
    public func delete(path: String, handler: @escaping (RequestType, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 2)
        self.delete(path: path, handler: toFunction(handler, with: path))
    }
    public func delete(path: String, handler: @escaping (RequestType, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 3)
        self.delete(path: path, handler: toFunction(handler, with: path))
    }
    public func delete(path: String, handler: @escaping (RequestType, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 4)
        self.delete(path: path, handler: toFunction(handler, with: path))
    }
    public func delete(path: String, handler: @escaping (RequestType, String, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 5)
        self.delete(path: path, handler: toFunction(handler, with: path))
    }

    public func options(path: String, handler: @escaping (RequestType, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 1)
        self.options(path: path, handler: toFunction(handler, with: path))
    }
    public func options(path: String, handler: @escaping (RequestType, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 2)
        self.options(path: path, handler: toFunction(handler, with: path))
    }
    public func options(path: String, handler: @escaping (RequestType, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 3)
        self.options(path: path, handler: toFunction(handler, with: path))
    }
    public func options(path: String, handler: @escaping (RequestType, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 4)
        self.options(path: path, handler: toFunction(handler, with: path))
    }
    public func options(path: String, handler: @escaping (RequestType, String, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 5)
        self.options(path: path, handler: toFunction(handler, with: path))
    }

    public func head(path: String, handler: @escaping (RequestType, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 1)
        self.head(path: path, handler: toFunction(handler, with: path))
    }
    public func head(path: String, handler: @escaping (RequestType, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 2)
        self.head(path: path, handler: toFunction(handler, with: path))
    }
    public func head(path: String, handler: @escaping (RequestType, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 3)
        self.head(path: path, handler: toFunction(handler, with: path))
    }
    public func head(path: String, handler: @escaping (RequestType, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 4)
        self.head(path: path, handler: toFunction(handler, with: path))
    }
    public func head(path: String, handler: @escaping (RequestType, String, String, String, String, String, ResponseType) -> (RequestType, ResponseType)) {
        precondition(path.wildcards == 5)
        self.head(path: path, handler: toFunction(handler, with: path))
    }

}
