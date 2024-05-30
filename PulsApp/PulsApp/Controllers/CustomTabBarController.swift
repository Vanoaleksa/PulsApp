
import UIKit
import SnapKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTabBar()
    }
    
    private func createTabBar() {
        
        let mainVC = HeartRateViewController()
        let historyVC = HistoryViewController()
        let dietVC = DietViewController()
        let testVC = TestViewController()
        let profileVC = ProfileViewController()
        
        self.viewControllers = [
            mainVC,
            historyVC,
            dietVC,
            testVC,
            profileVC
        ]
        
        mainVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "Heart"),
            tag: 0
        )
        
        
        historyVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "History"),
            tag: 1
        )
        
        dietVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "Diet"),
            tag: 2
        )
        
        testVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "Test"),
            tag: 3
        )
        
        profileVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "Profile"),
            tag: 4
        )
        
        self.tabBar.isTranslucent = true
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = UIColor(red: 255/255, green: 134/255, blue: 56/255, alpha: 1)
        self.tabBar.layer.cornerRadius = 20
    }
}



