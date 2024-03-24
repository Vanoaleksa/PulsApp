//
//  QueueManager.swift
//  PulseApp
//
//  Created by Bogdan Monid on 29.10.23.
//

import Foundation
import RealmSwift

fileprivate let realmQueueString = "com.createx.realm.thread.conсcurent"


class QueueManager{
    static let realmQueue = DispatchQueue(label: realmQueueString, qos: .userInitiated, attributes: .concurrent)
}
