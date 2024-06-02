
import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    
    private var user: UserModel?
    private let tableViewController = UITableViewController(style: .plain)
    private let adProView = AdProAccountView()
    private let unitsStackView = UIStackView()
    private var cmKgView: UnitsView!
    private var inLbsView: UnitsView!
    private var unitsIsSelected: Units = .cmKg {
        didSet {
            if unitsIsSelected == .cmKg {
                cmKgView.unitsChangeStateSelected(isSelected: true)
                cmKgView.changeColor(isSelected: true)
                inLbsView.unitsChangeStateSelected(isSelected: false)
                inLbsView.changeColor(isSelected: false)
            } else {
                cmKgView.unitsChangeStateSelected(isSelected: false)
                cmKgView.changeColor(isSelected: false)
                inLbsView.unitsChangeStateSelected(isSelected: true)
                inLbsView.changeColor(isSelected: true)
            }
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.text = "Profile"
        label.numberOfLines = 0
        
        view.addSubview(label)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setupLayout()
        user = UserManager.getUser()
    }
    
    private func configUI() {
        //Установка фонового изображения
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "bg")
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.9
        view.addSubview(imageView)
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        view.addSubview(adProView)
        
        configStackView()
        createTableView()
    }
    
    private func configStackView() {
        unitsStackView.axis = .horizontal
        unitsStackView.spacing = 10
        unitsStackView.distribution = .fillEqually
        
        cmKgView = UnitsView(units: .cmKg)
        inLbsView = UnitsView(units: .inLbs)
        
        cmKgView.unitsDelegate = self
        inLbsView.unitsDelegate = self
        
        unitsIsSelected = .cmKg
        
        view.addSubview(unitsStackView)
        unitsStackView.addArrangedSubview(cmKgView)
        unitsStackView.addArrangedSubview(inLbsView)
    }
    
    //MARK: - Создание tableView
    private func createTableView() {
        tableViewController.tableView.register(ProfileGenderTableViewCell.self, forCellReuseIdentifier: "GenderCell")
        tableViewController.tableView.register(ProfileParametrsTableViewCell.self, forCellReuseIdentifier: "ProfileParametrsTableViewCell")
        tableViewController.tableView.register(ProfileSettingsCell.self, forCellReuseIdentifier: "ProfileSettingsCell")
        tableViewController.tableView.delegate = self
        tableViewController.tableView.dataSource = self
        tableViewController.tableView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        tableViewController.tableView.separatorStyle = .none
        tableViewController.tableView.showsVerticalScrollIndicator = false
        
        view.addSubview(tableViewController.tableView)
    }
}

//MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GenderCell", for: indexPath) as! ProfileGenderTableViewCell
            cell.selectionStyle = .none
            
            return cell
            
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileParametrsTableViewCell", for: indexPath) as! ProfileParametrsTableViewCell
            cell.selectionStyle = .none
            cell.typeLabel.text = "Age"
            if let user = user {
                cell.paramTextField.text = user.age.description
                
            } else {
                cell.paramTextField.text = "0"
            }

            cell.cellImage.image = UIImage(named: "age-image")
            
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileParametrsTableViewCell", for: indexPath) as! ProfileParametrsTableViewCell
            cell.selectionStyle = .none
            cell.typeLabel.text = "Height"
            
            if let user = user {
                cell.paramTextField.text = "\(Int(user.height)) cm"
            } else {
                cell.paramTextField.text = "0 cm"
            }
            cell.cellImage.image = UIImage(named: "height-image")

            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileParametrsTableViewCell", for: indexPath) as! ProfileParametrsTableViewCell
            cell.selectionStyle = .none
            cell.typeLabel.text = "Weight"
            if let user = user {
                cell.paramTextField.text = "\(Int(user.weight)) kg"
            } else {
                cell.paramTextField.text = "0 kg"
            }
            cell.cellImage.image = UIImage(named: "weight-image")

            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileSettingsCell", for: indexPath) as! ProfileSettingsCell
            cell.selectionStyle = .none
            cell.typeLabel.text = "Settings"

            cell.cellImage.image = UIImage(named: "settings")
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileSettingsCell", for: indexPath) as! ProfileSettingsCell
            cell.selectionStyle = .none
            cell.typeLabel.text = "Share the App"
            cell.cellImage.image = UIImage(named: "share")

            return cell
        }
    }
}

//MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 4 || indexPath.row == 5 ? 81 : 71
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.endEditing(true)
        if indexPath.row == 4 {
            let nextVC = SettingsViewController()
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true)
        }
    }
}

extension ProfileViewController {
    
    private func setupLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(80)
            make.leading.equalToSuperview().offset(18)
            make.width.equalToSuperview().dividedBy(1.65)
        }
        
        adProView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.height.equalTo(52)
        }
        
        unitsStackView.snp.makeConstraints { make in
            make.top.equalTo(adProView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        tableViewController.tableView.snp.makeConstraints { make in
            make.top.equalTo(unitsStackView.snp.bottom).offset(15)
            make.leading.equalTo(25)
            make.trailing.equalTo(-25)
            make.bottom.equalTo(-30)
        }
    }
}

//MARK: - UnitsDelegate
extension ProfileViewController: UnitsDelegate{
    
    func chooseUnits(units: Units) {
        self.unitsIsSelected = units
    }
}
