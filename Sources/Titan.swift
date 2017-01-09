@_exported import TitanCore

internal var GlobalDefaultTitanInstance = Titan()

public private(set) var TitanApp = GlobalDefaultTitanInstance.app

public func TitanAppReset() {
  GlobalDefaultTitanInstance = Titan()
  TitanApp = GlobalDefaultTitanInstance.app
}
