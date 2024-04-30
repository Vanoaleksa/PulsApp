
import UIKit
import SnapKit

protocol PeriodsDelegate: AnyObject {
    func choosePeriod(period: Periods)
}

protocol SortingTypesDelegate: AnyObject {
    func chooseType(type: SortingTypes)
}

final class HistoryViewController: UIViewController {
    
    var backgroundImage = BackgroundHistoryView() // Cиняя вьюшка
    
    let resultsBPM = BPMUserManager.getAllResultsBPM()
        
    //MARK: Настройка выбора периода
    private var stackView = UIStackView()
    private var dayPeriod = PeriodView(periods: .day)
    private var weekPeriod = PeriodView(periods: .week)
    private var monthPeriod = PeriodView(periods: .month)
    private var periodIsSelected: Periods = .day {
        didSet {
            if periodIsSelected == .day {
                dayPeriod.periodChangedStateSelected(isSelected: true)
                weekPeriod.periodChangedStateSelected(isSelected: false)
                monthPeriod.periodChangedStateSelected(isSelected: false)
                backgroundImage.dayTimeLapseImage.isHidden = false
                backgroundImage.weekTimeLapseImage.isHidden = true
                backgroundImage.monthTimeLapseImage.isHidden = true
            } else if periodIsSelected == .week {
                dayPeriod.periodChangedStateSelected(isSelected: false)
                weekPeriod.periodChangedStateSelected(isSelected: true)
                monthPeriod.periodChangedStateSelected(isSelected: false)
                backgroundImage.dayTimeLapseImage.isHidden = true
                backgroundImage.weekTimeLapseImage.isHidden = false
                backgroundImage.monthTimeLapseImage.isHidden = true
            } else {
                dayPeriod.periodChangedStateSelected(isSelected: false)
                weekPeriod.periodChangedStateSelected(isSelected: false)
                monthPeriod.periodChangedStateSelected(isSelected: true)
                backgroundImage.dayTimeLapseImage.isHidden = true
                backgroundImage.weekTimeLapseImage.isHidden = true
                backgroundImage.monthTimeLapseImage.isHidden = false
            }
        }
    }
    
    //MARK: Настройка фильтрации
    let allTypeButton = TypeFilterButtonView(type: .all,
                                             image: UIImageView(image: UIImage(named: "Alltype-image")))
    
    let restingTypeButton = TypeFilterButtonView(type: .coffee,
                                                      image: UIImageView(image: UIImage(named: "Resting-image")))
    let sleepTypeButton = TypeFilterButtonView(type: .sleep,
                                                    image: UIImageView(image: UIImage(named: "Sleep-image")))
    let activeTypeButton = TypeFilterButtonView(type: .active,
                                                     image: UIImageView(image: UIImage(named: "Active-image")))
    
    private var typeIsSelected: SortingTypes = .all {
        didSet{
            if typeIsSelected == .all {
                allTypeButton.typesChangeStateSelected(isSelected: true)
                restingTypeButton.typesChangeStateSelected(isSelected: false)
                sleepTypeButton.typesChangeStateSelected(isSelected: false)
                activeTypeButton.typesChangeStateSelected(isSelected: false)
            } else if typeIsSelected == .coffee {
                allTypeButton.typesChangeStateSelected(isSelected: false)
                restingTypeButton.typesChangeStateSelected(isSelected: true)
                sleepTypeButton.typesChangeStateSelected(isSelected: false)
                activeTypeButton.typesChangeStateSelected(isSelected: false)
            } else if typeIsSelected == .sleep {
                allTypeButton.typesChangeStateSelected(isSelected: false)
                restingTypeButton.typesChangeStateSelected(isSelected: false)
                sleepTypeButton.typesChangeStateSelected(isSelected: true)
                activeTypeButton.typesChangeStateSelected(isSelected: false)
            } else {
                allTypeButton.typesChangeStateSelected(isSelected: false)
                restingTypeButton.typesChangeStateSelected(isSelected: false)
                sleepTypeButton.typesChangeStateSelected(isSelected: false)
                activeTypeButton.typesChangeStateSelected(isSelected: true)
            }
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        view.addSubview(tableView)
        
        return tableView
        
    }()
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Statistical data"
        let customFont = UIFont(name: "SFProDisplay-Bold", size: 28.adjusted)
        label.font = customFont
        label.textColor = .white
        
        view.addSubview(label)
        
        return label
    }()
    
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
        label.font = .systemFont(ofSize: 18.adjusted, weight: .regular)
        label.textColor = .black
        
        view.addSubview(label)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupLayout()
        
//        print("resultsbpm -------------",resultsBPM)
    }
    
    private func setup() {
        
        view.addSubview(backgroundImage)
        //Config UI
        view.backgroundColor = #colorLiteral(red: 0.9197916389, green: 0.9297400713, blue: 0.9338695407, alpha: 1)
//        backgroundImage.layer.cornerRadius = 20.adjusted
        
        dayPeriod.periodDelegate = self
        weekPeriod.periodDelegate = self
        monthPeriod.periodDelegate = self

        periodIsSelected = .day
        
        self.backgroundImage.addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
    
        stackView.addArrangedSubview(dayPeriod)
        stackView.addArrangedSubview(weekPeriod)
        stackView.addArrangedSubview(monthPeriod)
        
        view.addSubview(allTypeButton)
        view.addSubview(restingTypeButton)
        view.addSubview(activeTypeButton)
        view.addSubview(sleepTypeButton)
        
        typeIsSelected = .all
    }
}

//MARK: - Constraints
extension HistoryViewController {
    private func setupLayout() {
        backgroundImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-10.adjusted)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.65)
        }
      
        stackView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImage.titleLabel.snp.bottom).offset(20.adjusted)
            make.height.equalToSuperview().dividedBy(15.9)
            make.centerX.equalToSuperview()
        }

        averageAndMaxPulseImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backgroundImage.snp.bottom)
            make.height.equalToSuperview().dividedBy(15.7)
            make.width.equalToSuperview().multipliedBy(0.66)
        }
//        
//        historyLabel.snp.makeConstraints { make in
//            make.leading.equalTo(18.adjusted)
//            make.top.equalTo(averageAndMaxPulseImage.snp.bottom).offset(15.adjusted)
//        }
        
//        allTypeButton.snp.makeConstraints { make in
//            make.top.equalTo(historyLabel.snp.bottom).offset(10.adjusted)
//            make.leading.equalTo(18.adjusted)
//            make.width.equalTo(50.adjusted)
//            make.height.equalTo(50.adjusted)
//        }
        
//        restingTypeButton.snp.makeConstraints { make in
//            make.top.equalTo(historyLabel.snp.bottom).offset(10.adjusted)
//            make.leading.equalTo(114.adjusted)
//            make.width.equalTo(50.adjusted)
//            make.height.equalTo(50.adjusted)
//        }
        
//        sleepTypeButton.snp.makeConstraints { make in
//            make.top.equalTo(historyLabel.snp.bottom).offset(10.adjusted)
//            make.leading.equalTo(206.adjusted)
//            make.width.equalTo(50.adjusted)
//            make.height.equalTo(50.adjusted)
//        }
        
//        activeTypeButton.snp.makeConstraints { make in
//            make.top.equalTo(historyLabel.snp.bottom).offset(10.adjusted)
//            make.leading.equalTo(296.adjusted)
//            make.width.equalTo(50.adjusted)
//            make.height.equalTo(50.adjusted)
//        }
    }
}

//MARK: - PerodsDelegate
extension HistoryViewController:  SortingTypesDelegate, PeriodsDelegate {
    func choosePeriod(period: Periods) {
        self.periodIsSelected = period
    }
    
    func chooseType(type: SortingTypes) {
        self.typeIsSelected = type
    }
}
