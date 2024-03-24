
import UIKit

class Device {
    static let base: CGFloat = 375
    
    static var ratio: CGFloat {
        return UIScreen.main.bounds.width / base
    }
}

extension CGFloat{
    var adjusted: CGFloat{
        return self * Device.ratio
    }
}

extension Double{
    var adjusted: CGFloat{
        return CGFloat(self) * Device.ratio
    }
}

extension Int{
    var adjusted: CGFloat{
        return CGFloat(self) * Device.ratio
    }
}
