import Titan
import Foundation

get("/") {
  return UUID().uuidString
}
