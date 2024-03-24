//
//  HeartRateViewModel.swift
//  PulseApp
//
//  Created by Bogdan Monid on 19.11.23.
//

import Foundation
import UIKit
import RealmSwift
import UserNotifications

protocol BindWithHeartControllerProtocol{
    func showAboutMeViewController(heartController: HeartRateViewController)
    func calculateAndSaveBPMDataToDB(pulse: [Int])
    func showAnalyzeVC(heartController: HeartRateViewController)
    func handleAnalyzeType(type: AnalyzeTypes)
    func showResultView(heartController: HeartRateViewController)
    func saveBPMSettingsToDB()
}

class HeartRateViewModel: BindWithHeartControllerProtocol{
    var userBPMSettings: BPMUserSettings = BPMUserSettings()
    let realm = try! Realm()
    
    func showAboutMeViewController(heartController: HeartRateViewController) {
        let aboutMeVC = AboutMeViewController()
        aboutMeVC.modalPresentationStyle = .fullScreen
        heartController.present(aboutMeVC, animated: true)
//        UserDefaults.standard.setValue(true, forKey: keyShowAboutMe)
        
//                    if let user = UserManager.getUser(){
//                        try! realm.write {
//                            user.aboutMeWasShow = true
//                        }
//                    }
    }
    
    func calculateAndSaveBPMDataToDB(pulse: [Int]) {
        self.userBPMSettings = BPMUserSettings()
        var sumPulse = 0
        _ = pulse.map {sumPulse += $0}
        let averagePulse = sumPulse / pulse.count
        userBPMSettings.bpm = averagePulse
    }
    
    func showAnalyzeVC(heartController: HeartRateViewController) {
//        let analyzVC = AnalyzViewController()
//        analyzVC.delegate = heartController
//        analyzVC.modalPresentationStyle = .fullScreen
//        heartController.present(analyzVC, animated: true)
    }
    
    func handleAnalyzeType(type: AnalyzeTypes) {
        self.userBPMSettings.analyzeResult = type
        let dateInterval = Date().timeIntervalSince1970
        self.userBPMSettings.date = dateInterval
    }
    
    func showResultView(heartController: HeartRateViewController) {
//        let resultView = ResultScreen()
//        resultView.showWithAnimation(in: heartController.view)
//        resultView.delegate = heartController
//        resultView.updateLabelsValues(bpm: userBPMSettings.bpm, date: userBPMSettings.date, analyzeType: userBPMSettings.analyzeResult, pulsType: userBPMSettings.pulseType)
//        heartController.tabBarController?.view.addSubview(resultView)
    }
    
    func saveBPMSettingsToDB() {
        BPMUserManager.saveBPMResults(object: userBPMSettings)
    }
}
