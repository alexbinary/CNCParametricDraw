
import Foundation



public struct BoxCrenelConfig {

    
    var crenelConfigInternal: CrenelConfig
    var crenelConfigExternal: CrenelConfig
    var numberOfCrenels: NumerOfCrenelsEnum
    
    
    public init(
        crenelConfigInternal: CrenelConfig,
        crenelConfigExternal: CrenelConfig,
        numberOfCrenels: NumerOfCrenelsEnum
    ) {
        self.crenelConfigInternal = crenelConfigInternal
        self.crenelConfigExternal = crenelConfigExternal
        self.numberOfCrenels = numberOfCrenels
    }
}
