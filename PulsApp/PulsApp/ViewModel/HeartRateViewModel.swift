
import UIKit
import RealmSwift
import UserNotifications

protocol BindWithHeartControllerProtocol {
    func showAboutMeViewController(heartController: HeartRateViewController)
    func calculateAndSaveBPMDataToDB(pulse: [Int])
    func showAnalyzeVC(heartController: HeartRateViewController)
    func handleAnalyzeType(type: AnalyzeTypes)
    func showResultView(heartController: HeartRateViewController)
    func saveBPMSettingsToDB()
}

class HeartRateViewModel: BindWithHeartControllerProtocol {
    var userBPMSettings: BPMUserSettings = BPMUserSettings()
    let realm = try! Realm()
    
    func showAboutMeViewController(heartController: HeartRateViewController) {
        let aboutMeVC = AboutMeViewController()
        aboutMeVC.modalPresentationStyle = .fullScreen
        heartController.present(aboutMeVC, animated: true)
    }
    
    func calculateAndSaveBPMDataToDB(pulse: [Int]) {
        self.userBPMSettings = BPMUserSettings()
        var sumPulse = 0
        _ = pulse.map {sumPulse += $0}
        let averagePulse = sumPulse / pulse.count
        userBPMSettings.bpm = averagePulse
    }
    
    func showAnalyzeVC(heartController: HeartRateViewController) {
        let analyzVC = AnalyzViewController()
        analyzVC.delegate = heartController
        analyzVC.modalPresentationStyle = .fullScreen
        analyzVC.modalTransitionStyle = .coverVertical
        
        heartController.present(analyzVC, animated: true)
    }
    
    func handleAnalyzeType(type: AnalyzeTypes) {
        self.userBPMSettings.analyzeResult = type

        let dateInterval = Date().timeIntervalSince1970
        self.userBPMSettings.date = dateInterval
    }
    
    func showResultView(heartController: HeartRateViewController) {
        let resultView = ResultScreenView()
        
        resultView.delegate = heartController
        resultView.updateLabelsValues(bpm: userBPMSettings.bpm, date: userBPMSettings.date, analyzType: userBPMSettings.analyzeResult, typePulse: userBPMSettings.pulseType)
        heartController.tabBarController?.view.addSubview(resultView)
    }
    
    func saveBPMSettingsToDB() {
        BPMUserManager.saveBPMResults(object: userBPMSettings)
    }
}
