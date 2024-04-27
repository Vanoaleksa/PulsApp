
import UIKit

class Device {
//    static let baseWidth: CGFloat = 428
//    static let baseHeight: CGFloat = 896
    
    //Минимальные размеры дисплея
    static let baseWidth: CGFloat = 375
    static let baseHeight: CGFloat = 667
    
    static var ratioWitdh: CGFloat {
        return UIScreen.main.bounds.width / baseWidth
    }
    
    static var ratioHeight: CGFloat {
        return UIScreen.main.bounds.height / baseHeight
    }
    
}

extension CGFloat {
    var adjusted: CGFloat {
        return self * Device.ratioWitdh
    }
    
    var adjustedHeight: CGFloat {
        return self * Device.ratioHeight
    }
}

extension Double {
    var adjusted: CGFloat {
        return CGFloat(self) * Device.ratioWitdh
    }
    
    var adjustedHeight: CGFloat {
        return CGFloat(self) * Device.ratioHeight
    }
}

extension Int {
    var adjusted: CGFloat {
        return CGFloat(self) * Device.ratioWitdh
    }
    
    var adjustedHeight: CGFloat {
        return CGFloat(self) * Device.ratioHeight
    }
}
