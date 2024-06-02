
import Foundation
import RealmSwift

var userID = "UserID"

class UserManager{
    static func createUser(){
        let realm = try! Realm()
        
        if realm.object(ofType: UserModel.self, forPrimaryKey: userID) == nil{
            QueueManager.realmQueue.sync {
                try! realm.write {
                    let user = UserModel()
                    user.id = userID
                    user.timeWhenAppWasInstall = Date().timeIntervalSince1970
                    realm.add(user)
//                    NotificationCenter.default.post(name: .userDidCreate, object: nil)
                }
            }
        }
    }
    
    static func getUser() -> UserModel?{
        let realm = try! Realm()
        
        if let user = realm.object(ofType: UserModel.self, forPrimaryKey: "1"){
            return user
        }
        return nil
    }
}

internal func GetUserSettings() -> UserModel{
    let realm: Realm = try! Realm()
    return realm.object(ofType: UserModel.self, forPrimaryKey: userID)!
}
