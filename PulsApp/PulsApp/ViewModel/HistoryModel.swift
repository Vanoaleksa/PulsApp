
import UIKit

enum Periods: String {
    case day
    case week
    case month
    
    var periodsString: String {
        switch self {
        case .day:
            "Day"
        case .week:
            "Week"
        case .month:
            "Month"
        }
    }
}

enum SortingTypes: String {
    case all
    case coffee
    case sleep
    case active
    
    var typesString: String {
        switch self {
        case .all:
            "All"
        case .coffee:
            "Resting"
        case .sleep:
            "Sleep"
        case .active:
            "Active"
        }
    }
}
