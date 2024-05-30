
import UIKit
import SnapKit
import RealmSwift

protocol UnitsDelegate: AnyObject{
    func chooseUnits(units: Units)
}

class AboutMeViewController: UIViewController {
   
    var tableViewController = UITableViewController(style: .plain)
    private var stackView: UIStackView!
    private var cmKgView: UnitsView!
    private var inLbsView: UnitsView!
    private var unitsIsSelected: Units = .cmKg{
        didSet{
            if unitsIsSelected == .cmKg{
                cmKgView.unitsChangeStateSelected(isSelected: true)
                cmKgView.changeColor(isSelected: true)
                inLbsView.unitsChangeStateSelected(isSelected: false)
                inLbsView.changeColor(isSelected: false)
            }else{
                cmKgView.unitsChangeStateSelected(isSelected: false)
                cmKgView.changeColor(isSelected: false)
                inLbsView.unitsChangeStateSelected(isSelected: true)
                inLbsView.changeColor(isSelected: true)
            }
        }
    }
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "About me"
        let customFont = UIFont(name: "SFProDisplay-Bold", size: 28.adjusted)
        label.font = customFont
        label.textColor = .black
        
        view.addSubview(label)
        
        return label
    }()
    
    lazy var continueButton: GlobalButton = {
        var button = GlobalButton()
        button.setTitle("Continue", for: .normal)
        button.addTarget(self, action: #selector(continueButtonAction), for: .touchUpInside)
        
        view.addSubview(button)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        createTableView()
        configStackView()
        setupLayout()
    }
    
    private func configStackView(){
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        cmKgView = UnitsView(units: .cmKg)
        inLbsView = UnitsView(units: .inLbs)
        
        cmKgView.unitsDelegate = self
        inLbsView.unitsDelegate = self
        
        unitsIsSelected = .cmKg
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(cmKgView)
        stackView.addArrangedSubview(inLbsView)
    }
    
    //MARK: - Setup UI
    func configUI() {
        //Установка фонового изображения
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "bg")
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
    }
    
    //MARK: - Создание tableView
    private func createTableView() {
        tableViewController.tableView.register(CustomGenderCell.self, forCellReuseIdentifier: "GenderCell")
        tableViewController.tableView.register(CustomParametersCell.self, forCellReuseIdentifier: "CustomParametersCell")
        tableViewController.tableView.delegate = self
        tableViewController.tableView.dataSource = self
        tableViewController.tableView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        tableViewController.tableView.separatorStyle = .none
        
        view.addSubview(tableViewController.tableView)
    }
    
    @objc func continueButtonAction() {
        // Меняем состояние кнопок, если они пустые
        for row in 1...3 {
            if let cell = tableViewController.tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? CustomParametersCell {
                if cell.paramTextField.text?.isEmpty == true {
                    cell.isEmpty = true
                }
            }
        }
        
        // Проверяем на заполненность ячейки
        let cells = tableViewController.tableView.visibleCells.filter { currentCell in
            return currentCell.isKind(of: CustomParametersCell.self)
        }
        
        let allCellsFilled = cells.filter { currentCell in
            guard let field = currentCell as? CustomParametersCell else {return false}
            return field.paramTextField.text?.isEmpty == true
        }
        
        if allCellsFilled.isEmpty {
            
            let user = UserModel()            
            let visibleCells = tableViewController.tableView.visibleCells
            
            // Начало записи в базу данных Realm
            UserManager.createUser()
            
            let realm = try! Realm()

            try! realm.write({
                visibleCells.forEach { currentCell in
                    if let genderCell = currentCell as? CustomGenderCell {
                        user.gender = genderCell.genderIsSelected
                    } else if let paramCell = currentCell as? CustomParametersCell {
                        let fieldType = paramCell.typeLabel.text
                        let fieldValue = paramCell.paramTextField.text
                        
                        switch fieldType{
                        case "Height":
                            user.height = Double(fieldValue ?? "") ?? 0.0
                        case "Weight":
                            user.weight = Double(fieldValue ?? "") ?? 0.0
                        case "Age":
                            user.age = Int(fieldValue ?? "") ?? 0
                        default:
                            break
                        }
                    }
                }
                
                user.units = unitsIsSelected
                user.aboutMeWasShow = true
                user.isFirstLogin = true

                realm.add(user)
            })
            self.dismiss(animated: true)
        }
    }
}

//MARK: - UITableViewDataSource
extension AboutMeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let genderCell = tableView.dequeueReusableCell(withIdentifier: "GenderCell", for: indexPath)
            genderCell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
            genderCell.selectionStyle = .none
     
            return genderCell
        }
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomParametersCell", for: indexPath) as! CustomParametersCell
            cell.typeLabel.text = "Height"
            cell.warningLabel.text = "Please enter a valid value for:  \(cell.typeLabel.text!)"
            cell.selectionStyle = .none

            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomParametersCell", for: indexPath) as! CustomParametersCell
            cell.typeLabel.text = "Weight"
            cell.warningLabel.text = "Please enter a valid value for:  \(cell.typeLabel.text!)"
            cell.selectionStyle = .none
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomParametersCell", for: indexPath) as! CustomParametersCell
            cell.typeLabel.text = "Age"
            cell.warningLabel.text = "Please enter a valid value for:  \(cell.typeLabel.text!)"
            cell.selectionStyle = .none
            
            return cell
        }
    }
}

//MARK: - UITableViewDelegate
extension AboutMeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.endEditing(true)
    }
}

//MARK: - Setup constraints
extension AboutMeViewController {
    func setupLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18.adjusted)
            make.top.equalToSuperview().offset(74.adjusted)
        }
        
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(tableViewController.tableView.snp.top).offset(-20.adjusted)
            make.centerX.equalToSuperview()
        }
        
        tableViewController.tableView.snp.makeConstraints { make in
            make.top.equalTo(187.adjusted)
            make.left.equalTo(18.adjusted)
            make.right.equalTo(-18.adjusted)
            make.bottom.equalToSuperview().offset(-200.adjusted)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(tableViewController.tableView.snp.bottom).offset(30.adjusted)
            make.height.equalTo(75.adjusted)
            make.left.equalToSuperview().offset(40.adjusted)
            make.right.equalToSuperview().offset(-40.adjusted)
            make.centerX.equalToSuperview()
        }
    }
}


//MARK: - UnitsDelegate
extension AboutMeViewController: UnitsDelegate{
    
    func chooseUnits(units: Units) {
        self.unitsIsSelected = units
    }
}

