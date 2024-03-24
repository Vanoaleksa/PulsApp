
import Foundation
import RealmSwift

@objc
enum AnalyzeTypes: Int, RealmEnum, PersistableEnum{
    case coffee
    case sleep
    case active
    
    var typesString: String{
        switch self {
        case .coffee:
            return NSLocalizedString("Resting", comment: "")
        case .sleep:
            return NSLocalizedString("Sleep", comment: "")
        case .active:
            return NSLocalizedString("Active", comment: "")
        }
    }
}

@objc
enum PulseType: Int, RealmEnum{
    case slow
    case normal
    case fast
    
    var pulseTypesString: String{
        switch self {
        case .slow:
            return NSLocalizedString("Slow puls", comment: "")
        case .normal:
            return NSLocalizedString("Normal puls", comment: "")
        case .fast:
            return NSLocalizedString("Fast puls", comment: "")
        }
    }
}

@objcMembers
class BPMUserSettings: Object{
    @Persisted var id: String = UUID().uuidString
    @Persisted var date: Double = 0.0
    @Persisted var bpm: Int = 0
    dynamic var pulseType: PulseType = .normal
    dynamic var analyzeResult: AnalyzeTypes = .coffee{
        didSet{
            switch analyzeResult {
            case .coffee:
                self.pulseType = DefiningPulseType.pulseStateDetermineResting(bpmValue: bpm)
            case .sleep:
                self.pulseType = DefiningPulseType.pulseStateDetermineSleep(bpmValue: bpm)
            case .active:
                self.pulseType = DefiningPulseType.pulseStateDetermineActive(bpmValue: bpm)
            }
        }
    }
    override class func primaryKey() -> String? {
        return #keyPath(BPMUserSettings.id)
    }
}
