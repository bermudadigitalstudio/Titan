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
import Foundation

public extension RequestType {
    /// Return the body content as a JSON object, if possible, otherwise return nil.
    /// Uses `Foundation` JSONSerialization for decoding.
    var json: Any? {
        return try? JSONSerialization.jsonObject(with: body, options: [])
    }
}
