

import Foundation
import RealmSwift


class BPMUserManager{
    
    let shared = BPMUserManager()
    private init() {}
    
    static func getAllResultsBPM() -> Array<BPMUserSettings>? { //Эта функция возвращает все объекты BPMUserSettings из базы данных Realm, отсортированные по дате.
        let realm = try! Realm()
        
        let objects = realm.objects(BPMUserSettings.self).sorted(by: {$0.date < $1.date})
        return objects
    }
    
    static func saveBPMResults(object: BPMUserSettings){  //Эта функция сохраняет объект BPMUserSettings в базу данных Realm.
        QueueManager.realmQueue.sync {
            let realm = try! Realm()
            
            try! realm.write {
                realm.add(object)
            }
        }
    }
}
