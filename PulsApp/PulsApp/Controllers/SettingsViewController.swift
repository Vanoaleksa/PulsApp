
import UIKit
import SnapKit

final class SettingsViewController: UIViewController {
    
    private let tableViewController = UITableViewController(style: .plain)
    
    private let imagesNames = ["Feedback", "Privacy Policy", "terms-image"]
    private let cellsNames = ["Privacy Policy", "Terms of Service", "Feedback"]
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.text = "Result"
        label.numberOfLines = 0
        
        view.addSubview(label)
        
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "left-black-arrow-image"), for: .normal)
        button.addTarget(self, action: #selector(goBackAction), for: .touchUpInside)
        
        view.addSubview(button)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setupLayout()
    }
    
    private func configUI() {
        //Установка фонового изображения
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "bg")
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
        
        createTableView()
    }
    
    //MARK:  Создание tableView
    private func createTableView() {
        tableViewController.tableView.register(CustomSettingsCell.self, forCellReuseIdentifier: "CustomSettingsCell")
        tableViewController.tableView.register(ProfileSettingsCell.self, forCellReuseIdentifier: "ProfileSettingsCell")
        tableViewController.tableView.delegate = self
        tableViewController.tableView.dataSource = self
        tableViewController.tableView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        tableViewController.tableView.separatorStyle = .none
        
        view.addSubview(tableViewController.tableView)
    }
    
    @objc func goBackAction() {
        self.dismiss(animated: true)
    }
    
    private func showSecondAlert() {
        let secondAlertController = UIAlertController(title: "We have sent instructions to your email", message: "", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        secondAlertController.addAction(okAction)
        
        present(secondAlertController, animated: true, completion: nil)
    }
}


extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomSettingsCell", for: indexPath) as! CustomSettingsCell
            
            let imageItem = imagesNames[indexPath.row]
            let namesItem = cellsNames[indexPath.row]
            
            cell.cellImage.image = UIImage(named: imageItem.description)
            cell.typeLabel.text = namesItem.description
            cell.selectionStyle = .none
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileSettingsCell", for: indexPath) as! ProfileSettingsCell
            
            
            let imageNamesArr = ["restore-image", "subscription-image"]
            let namesArr = ["Restore", "Cancel Subscription"]
            let adjustedIndex = indexPath.row - imageNamesArr.count - 1
            let imageItem = imageNamesArr[adjustedIndex]
            let namesItem = namesArr[adjustedIndex]
                            
            cell.cellImage.image = UIImage(named: imageItem.description)
            cell.typeLabel.text = namesItem.description
            cell.selectionStyle = .none
            
            return cell
        }
    }
}

//MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 3 || indexPath.row == 4 ? 81 : 71
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.endEditing(true)
        
        if indexPath.row == 4 {
            // Создаем UIAlertController с нужным сообщением
            let alertController = UIAlertController(title: "Are you sure you want to cancel your subscription and lose PRO version", message: "", preferredStyle: .alert)
                        
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                self.showSecondAlert()
            }
            let cancelAction = UIAlertAction(title: "Cansel", style: .cancel, handler: nil)
            
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
}

extension SettingsViewController{
    private func setupLayout() {
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.leading.equalToSuperview().offset(18)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(18)
            make.width.equalToSuperview().dividedBy(1.65)
        }
        
        tableViewController.tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(25)
            make.trailing.equalTo(-25)
            make.bottom.equalToSuperview()
        }
    }
}
