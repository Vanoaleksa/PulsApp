
import Foundation

class DefiningPulseType {
    
    static func pulseStateDetermineResting(bpmValue: Int) -> PulseType{
        
        let user = GetUserSettings()
        let gender = user.gender == .none ? Gender.male : user.gender
        let userAge = user.age == 0 ? 25 : user.age
        
        
        switch userAge {
        case 1:
            if bpmValue < 100 {
                return .slow
            } else if(bpmValue >= 100 && bpmValue < 160) || bpmValue == 160 {
                return .normal
            } else {
                return .fast
            }
        case 2:
            if bpmValue < 95 {
                return .slow
            } else if(bpmValue >= 95 && bpmValue < 155) || bpmValue == 155 {
                return .normal
            } else {
                return .fast
            }
        case 2..<6:
            if bpmValue < 85 {
                return .slow
            } else if(bpmValue >= 85 && bpmValue < 125) || bpmValue == 125 {
                return .normal
            } else {
                return .fast
            }
        case 6..<8:
            if bpmValue < 75 {
                return .slow
            } else if(bpmValue >= 75 && bpmValue < 120) || bpmValue == 120 {
                return .normal
            } else {
                return .fast
            }
        case 8..<10:
            if bpmValue < 70 {
                return .slow
            } else if(bpmValue >= 70 && bpmValue < 110) || bpmValue == 110 {
                return .normal
            } else {
                return .fast
            }
            //12
        case 10..<12:
            if bpmValue < 60 {
                return .slow
            } else if(bpmValue >= 60 && bpmValue < 100) || bpmValue == 100 {
                return .normal
            } else {
                return .fast
            }
        case 12..<15 :
            if bpmValue < 60 {
                return .slow
            } else if(bpmValue >= 60 && bpmValue < 95) || bpmValue == 95 {
                return .normal
            } else {
                return .fast
            }
        default: break
            
        }
        
        
        if userAge >= 15 {
            
            switch gender {
            case .male:
                
                if userAge <= 120 {
                    // ...18
                    if 15 <= userAge, 18 >= userAge  {
                        if bpmValue < 70 {
                            return .slow
                            
                        } else if (bpmValue >= 70 && bpmValue < 90) || bpmValue == 90 {
                            return .normal
                            
                        } else if bpmValue > 90 {
                            return .fast
                        }
                    }
                    
                    // 18...30
                    else if userAge >= 18 && userAge <= 30 {
                        if bpmValue < 65 {
                            return .slow
                        } else if (bpmValue >= 65 && bpmValue < 80) || bpmValue == 80 {
                            return .normal
                        } else if bpmValue > 80 {
                            return .fast
                        }
                        
                        // 31...50
                    } else if userAge >= 31 && userAge <= 50 {
                        if bpmValue < 60 {
                            return .slow
                        } else if (bpmValue >= 60 && bpmValue < 80) || bpmValue == 80 {
                            return .normal
                        } else if bpmValue > 80 {
                            return .fast
                        }
                        
                        // 51...60
                    } else if userAge >= 51 && userAge <= 60 {
                        if bpmValue < 65 {
                            return .slow
                        } else if (bpmValue >= 65 && bpmValue < 90) || bpmValue == 90 {
                            return .normal
                        } else if bpmValue > 90 {
                            return .fast
                        }
                        
                        // 61...
                    } else if userAge >= 61 {
                        if bpmValue < 60 {
                            return .slow
                        } else if (bpmValue >= 60 && bpmValue < 90) || bpmValue == 90 {
                            return .normal
                        } else if bpmValue > 90 {
                            return .fast
                        }
                    }
                }
                
            case .female:
                
                if userAge <= 120{
                    
                    
                    // ...18
                    if 15 <= userAge, 18 >= userAge {
                        if bpmValue < 80 {
                            return .slow
                        } else if (bpmValue >= 80 && bpmValue < 100) || bpmValue == 100 {
                            return .normal
                        } else if bpmValue > 100 {
                            return .fast
                        }
                    }
                    
                    // 18...30
                    else if userAge >= 18 && userAge <= 30 {
                        if bpmValue < 70 {
                            return .slow
                        } else if (bpmValue >= 70 && bpmValue < 85) || bpmValue == 85 {
                            return .normal
                        } else if bpmValue > 85 {
                            return .fast
                        }
                        
                        // 31...50
                    } else if userAge >= 31 && userAge <= 50 {
                        if bpmValue < 60 {
                            return .slow
                        } else if (bpmValue >= 60 && bpmValue < 80) || bpmValue == 80 {
                            return .normal
                        } else if bpmValue > 80 {
                            return .fast
                        }
                        
                        // 51...60
                    } else if userAge >= 51 && userAge <= 60 {
                        if bpmValue < 65 {
                            return .slow
                        } else if (bpmValue >= 65 && bpmValue < 85) || bpmValue == 85 {
                            return .normal
                        } else if bpmValue > 85 {
                            return .fast
                        }
                        
                        // 61...
                    } else if userAge >= 61 {
                        if bpmValue < 65 {
                            return .slow
                        } else if (bpmValue >= 65 && bpmValue < 95) || bpmValue == 95 {
                            return .normal
                        } else if bpmValue > 95 {
                            return .fast
                        }
                    }
                }
                
            default:break
                
            }
        }
        
        return .normal
    }
    
    
    static func pulseStateDetermineSleep(bpmValue: Int) -> PulseType  {
        
        let user = GetUserSettings()
        let gender = user.gender == .none ? Gender.male : user.gender
        let userAge = user.age == 0 ? 25 : user.age
        
        
        switch userAge {
        case 1:
            if bpmValue < 90 {
                return .slow
            } else if(bpmValue >= 90 && bpmValue < 150) || bpmValue == 150 {
                return .normal
            } else {
                return .fast
            }
        case 2:
            if bpmValue < 80 {
                return .slow
            } else if(bpmValue >= 80 && bpmValue < 130) || bpmValue == 130 {
                return .normal
            } else {
                return .fast
            }
        case 3:
            if bpmValue < 75 {
                return .slow
            } else if(bpmValue >= 75 && bpmValue < 120) || bpmValue == 120 {
                return .normal
            } else {
                return .fast
            }
        case 4:
            if bpmValue < 80 {
                return .slow
            } else if(bpmValue >= 80 && bpmValue < 120) || bpmValue == 120 {
                return .normal
            } else {
                return .fast
            }
        case 5:
            if bpmValue < 75 {
                return .slow
            } else if(bpmValue >= 75 && bpmValue < 100) || bpmValue == 100 {
                return .normal
            } else {
                return .fast
            }
            //12
        case 6:
            if bpmValue < 75 {
                return .slow
            } else if(bpmValue >= 75 && bpmValue < 90) || bpmValue == 90 {
                return .normal
            } else {
                return .fast
            }
        case 7 :
            if bpmValue < 75 {
                return .slow
            } else if(bpmValue >= 75 && bpmValue < 82) || bpmValue == 82 {
                return .normal
            } else {
                return .fast
            }
        case 8...9:
            if bpmValue < 73 {
                return .slow
            } else if(bpmValue >= 73 && bpmValue < 78) || bpmValue == 78 {
                return .normal
            } else {
                return .fast
            }
            
        case 10...11:
            if bpmValue < 70 {
                return .slow
            } else if(bpmValue >= 70 && bpmValue < 75) || bpmValue == 75 {
                return .normal
            } else {
                return .fast
            }
            
            
        case 12..<18:
            if bpmValue < 60 {
                return .slow
            } else if(bpmValue >= 60 && bpmValue < 70) || bpmValue == 70 {
                return .normal
            } else {
                return .fast
            }
            
        default: break
        }
        
        if userAge >= 18 {
            switch gender {
            case .male:
                
                if userAge <= 120 {
                    
                    // 18...50
                    if userAge >= 18 && userAge <= 50 {
                        if bpmValue < 45 {
                            return .slow
                        } else if (bpmValue >= 45 && bpmValue < 75) || bpmValue == 75 {
                            return .normal
                        } else if bpmValue > 75 {
                            return .fast
                        }
                    }
                    // 51...
                    else if userAge >= 51 {
                        if bpmValue < 50 {
                            return .slow
                        } else if (bpmValue >= 50 && bpmValue < 85) || bpmValue == 85 {
                            return .normal
                        } else if bpmValue > 85 {
                            return .fast
                        }
                    }
                }
                
            case .female:
                
                if userAge <= 120 {
                    
                    // 18...50
                    if userAge >= 18 && userAge <= 50 {
                        if bpmValue < 40 {
                            return .slow
                        } else if (bpmValue >= 40 && bpmValue < 70) || bpmValue == 70 {
                            return .normal
                        } else if bpmValue > 70 {
                            return .fast
                        }
                    }
                    // 51...
                    else if userAge >= 51 {
                        if bpmValue < 45 {
                            return .slow
                        } else if (bpmValue >= 45 && bpmValue < 80) || bpmValue == 80 {
                            return .normal
                        } else if bpmValue > 80 {
                            return .fast
                        }
                    }
                }
            default:break
            }
        }
        return .normal
    }
    
    static func pulseStateDetermineActive(bpmValue: Int) -> PulseType{
        
        let user = GetUserSettings()
        let gender = user.gender == .none ? Gender.male : user.gender
        let userAge = user.age == 0 ? 25 : user.age
        
        switch gender {
        case .male:
            let maxBpmValue = 220 - userAge
            let minBpmValue = Double(maxBpmValue) / Double(100) * Double(50)
            
            if bpmValue < Int(minBpmValue) {
                return .slow
            } else if (bpmValue >= Int(minBpmValue) && bpmValue < maxBpmValue) || bpmValue == maxBpmValue {
                return .normal
            } else if bpmValue > maxBpmValue {
                return .fast
            }
        case .female:
            let maxBpmValue = 196 - userAge
            let minBpmValue = maxBpmValue / 100 * 50
            
            if bpmValue < minBpmValue {
                return .slow
            } else if (bpmValue >= Int(minBpmValue) && bpmValue < maxBpmValue) || bpmValue == maxBpmValue {
                return .normal
            } else if bpmValue > maxBpmValue {
                return .fast
            }
        case .none:
            break
        }
        return .normal
    }
}

