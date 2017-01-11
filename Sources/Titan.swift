@_exported import TitanCore
@_exported import TitanRouter

internal var GlobalDefaultTitanInstance = Titan()

public private(set) var TitanApp = GlobalDefaultTitanInstance.app

public func TitanAppReset() {
  GlobalDefaultTitanInstance = Titan()
  TitanApp = GlobalDefaultTitanInstance.app
}
