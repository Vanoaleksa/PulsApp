
import UIKit
import SnapKit

protocol PeriodsDelegate: AnyObject {
    func choosePeriod(period: Periods)
}

protocol SortingTypesDelegate: AnyObject {
    func chooseType(type: SortingTypes)
}

final class HistoryViewController: UIViewController {

    var backgroundImage = BackgroundHistoryView() // Cиняя вью
    
    var resultsBPM: Array<BPMUserSettings>?
    
    var tableViewController = UITableViewController(style: .plain)

    let dataPickerView = DatePickerView()
    
    var darkView: UIVisualEffectView?
    
    //MARK: Настройка выбора периода
    private var periodsStackView = UIStackView()
    private var dayPeriod = PeriodView(periods: .day)
    private var weekPeriod = PeriodView(periods: .week)
    private var monthPeriod = PeriodView(periods: .month)
    private var periodIsSelected: Periods = .day {
        didSet {
            if periodIsSelected == .day {
                dayPeriod.periodChangedStateSelected(isSelected: true)
                weekPeriod.periodChangedStateSelected(isSelected: false)
                monthPeriod.periodChangedStateSelected(isSelected: false)
                backgroundImage.dayStackView.isHidden = false
                backgroundImage.weekStackView.isHidden = true
                backgroundImage.monthStackView.isHidden = true
            } else if periodIsSelected == .week {
                dayPeriod.periodChangedStateSelected(isSelected: false)
                weekPeriod.periodChangedStateSelected(isSelected: true)
                monthPeriod.periodChangedStateSelected(isSelected: false)
                backgroundImage.dayStackView.isHidden = true
                backgroundImage.weekStackView.isHidden = false
                backgroundImage.monthStackView.isHidden = true
            } else {
                dayPeriod.periodChangedStateSelected(isSelected: false)
                weekPeriod.periodChangedStateSelected(isSelected: false)
                monthPeriod.periodChangedStateSelected(isSelected: true)
                backgroundImage.dayStackView.isHidden = true
                backgroundImage.weekStackView.isHidden = true
                backgroundImage.monthStackView.isHidden = false
            }
        }
    }
    
    //MARK: Настройка фильтрации
    lazy var filterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    let allTypeView = TypeFilterButtonView(type: .all,
                                           image: UIImageView(image: UIImage(named: "Alltype-image")))
    
    let restingTypeView = TypeFilterButtonView(type: .coffee,
                                               image: UIImageView(image: UIImage(named: "Resting-image")))
    let sleepTypeView = TypeFilterButtonView(type: .sleep,
                                             image: UIImageView(image: UIImage(named: "Sleep-image")))
    let activeTypeView = TypeFilterButtonView(type: .active,
                                              image: UIImageView(image: UIImage(named: "Active-image")))
    
    private var typeIsSelected: SortingTypes = .all {
        didSet{
            if typeIsSelected == .all {
                allTypeView.typesChangeStateSelected(isSelected: true)
                restingTypeView.typesChangeStateSelected(isSelected: false)
                sleepTypeView.typesChangeStateSelected(isSelected: false)
                activeTypeView.typesChangeStateSelected(isSelected: false)
            } else if typeIsSelected == .coffee {
                allTypeView.typesChangeStateSelected(isSelected: false)
                restingTypeView.typesChangeStateSelected(isSelected: true)
                sleepTypeView.typesChangeStateSelected(isSelected: false)
                activeTypeView.typesChangeStateSelected(isSelected: false)
            } else if typeIsSelected == .sleep {
                allTypeView.typesChangeStateSelected(isSelected: false)
                restingTypeView.typesChangeStateSelected(isSelected: false)
                sleepTypeView.typesChangeStateSelected(isSelected: true)
                activeTypeView.typesChangeStateSelected(isSelected: false)
            } else {
                allTypeView.typesChangeStateSelected(isSelected: false)
                restingTypeView.typesChangeStateSelected(isSelected: false)
                sleepTypeView.typesChangeStateSelected(isSelected: false)
                activeTypeView.typesChangeStateSelected(isSelected: true)
            }
        }
    }
    
    lazy var averageAndMaxPulseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "averageAndMaxPulseImage")
        imageView.contentMode = .scaleAspectFill
        
        view.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var historyLabel: UILabel = {
        var label = UILabel()
        label.text = "History"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        
        view.addSubview(label)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        configTableView()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resultsBPM = BPMUserManager.getAllResultsBPM()
        tableViewController.tableView.reloadData()
        
    }
    
    private func setup() {
        
        //Config UI
        view.addSubview(backgroundImage)
        view.backgroundColor = #colorLiteral(red: 0.9197916389, green: 0.9297400713, blue: 0.9338695407, alpha: 1)
        
        //Config Periods
        dayPeriod.periodDelegate = self
        weekPeriod.periodDelegate = self
        monthPeriod.periodDelegate = self
        
        periodIsSelected = .day
        
        self.view.addSubview(periodsStackView)
        
        periodsStackView.axis = .horizontal
        periodsStackView.spacing = 10
        periodsStackView.distribution = .fillEqually
        
        periodsStackView.addArrangedSubview(dayPeriod)
        periodsStackView.addArrangedSubview(weekPeriod)
        periodsStackView.addArrangedSubview(monthPeriod)
        
        //Config Filter types
        
        view.addSubview(filterStackView)
        
        allTypeView.typesDelegate = self
        restingTypeView.typesDelegate = self
        sleepTypeView.typesDelegate = self
        activeTypeView.typesDelegate = self
        
        filterStackView.addArrangedSubview(allTypeView)
        filterStackView.addArrangedSubview(restingTypeView)
        filterStackView.addArrangedSubview(sleepTypeView)
        filterStackView.addArrangedSubview(activeTypeView)
        
        typeIsSelected = .all
        
        backgroundImage.datePickerButton.addTarget(self, action: #selector(showDatePickerView), for: .touchUpInside)
        
    }
    
    //MARK: Создание tableView
    private func configTableView() {
        tableViewController.tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "HistoryTableViewCell")
        
        tableViewController.tableView.delegate = self
        tableViewController.tableView.dataSource = self
        
        tableViewController.tableView.backgroundColor = #colorLiteral(red: 0.9197916389, green: 0.9297400713, blue: 0.9338695407, alpha: 1)
        tableViewController.tableView.separatorStyle = .none
        
        view.addSubview(tableViewController.tableView)
    }
    
    private func formatDate(dateInterval:Double) -> String{
        let date = Date(timeIntervalSince1970: dateInterval)
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = " MMMM dd yyyy h:mm"
        let dateString = formatter.string(from: date)
        return dateString
    }
}

//MARK: - UITableViewDataSource
extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        resultsBPM != nil ? resultsBPM!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
        
        if let result = resultsBPM?[indexPath.row] {
            cell.pulseLabel.text = result.bpm.description
            cell.dateLabel.text = formatDate(dateInterval: result.date)
            cell.pulseType.updateType!(result.pulseType)
            cell.typeResult.updateAnalyze!(result.analyzeResult)
            cell.selectionStyle = .none
        }
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

//MARK: - Constraints
extension HistoryViewController {
    private func setupLayout() {
        backgroundImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-10)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().dividedBy(1.85)
        }
        
        periodsStackView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImage.titleLabel.snp.bottom).offset(20)
            make.height.equalToSuperview().dividedBy(15.9)
            make.centerX.equalToSuperview()
        }
        
        averageAndMaxPulseImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backgroundImage.snp.bottom)
            make.height.equalTo(backgroundImage).dividedBy(8.5)
            make.width.equalToSuperview().multipliedBy(0.66)
        }
        
        historyLabel.snp.makeConstraints { make in
            make.leading.equalTo(18)
            make.top.equalTo(averageAndMaxPulseImage.snp.bottom).offset(15)
        }
        
        filterStackView.snp.makeConstraints { make in
            make.top.equalTo(historyLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(historyLabel.snp.bottom).offset(60)
        }
        
        tableViewController.tableView.snp.makeConstraints { make in
            make.top.equalTo(filterStackView.snp.bottom).offset(35)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

//MARK: - SortingTypesDelegate, PeriodsDelegate
extension HistoryViewController:  SortingTypesDelegate, PeriodsDelegate {
    func choosePeriod(period: Periods) {
        self.periodIsSelected = period
    }
    
    func chooseType(type: SortingTypes) {
        self.typeIsSelected = type
    }
}

//MARK: - Configure Date Picker
extension HistoryViewController: DatePickerViewDelegate {
    
    @objc private func showDatePickerView() {
        setupDarkView()
        dataPickerView.delegate = self
        self.tabBarController?.view.addSubview(dataPickerView)
        
        let height = 335
        
        dataPickerView.frame = CGRect(x: 0, y: self.tabBarController!.view.frame.height, width: self.tabBarController!.view.frame.width, height: CGFloat(height))
        self.tabBarController?.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dataPickerView.frame.origin.y -= CGFloat(height)
        })
    }
    
    private func setupDarkView() {
        let blurEffect = UIBlurEffect(style: .regular)
        
        darkView = UIVisualEffectView(effect: blurEffect)
        darkView?.frame = view.bounds
        darkView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        if let darkView = darkView{
            view.addSubview(darkView)
        }
    }
    
    func hideAlertViewWithAnimation(){
        let height = 335
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dataPickerView.frame.origin.y += CGFloat(height)
        }) { _ in
            self.dataPickerView.removeFromSuperview()
        }
    }
    
    func tappedActionInPrivacyView() {
        hideAlertViewWithAnimation()
        self.darkView?.removeFromSuperview()
    }
}
