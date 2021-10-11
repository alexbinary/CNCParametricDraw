
import Foundation



public struct BoxCrenelConfig {

    
    var crenelConfig: CrenelConfig
    var numberOfCrenels: NumerOfCrenelsEnum
    
    
    public init(
        crenelConfig: CrenelConfig,
        numberOfCrenels: NumerOfCrenelsEnum
    ) {
        self.crenelConfig = crenelConfig
        self.numberOfCrenels = numberOfCrenels
    }
}
