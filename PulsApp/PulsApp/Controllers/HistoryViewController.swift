
import UIKit
import SnapKit

protocol PeriodsDelegate: AnyObject {
    func choosePeriod(period: Periods)
}

protocol SortingTypesDelegate: AnyObject {
    func chooseType(type: SortingTypes)
}

final class HistoryViewController: UIViewController {
    
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
                dayTimeLapseImage.isHidden = false
                weekTimeLapseImage.isHidden = true
                monthTimeLapseImage.isHidden = true
            } else if periodIsSelected == .week {
                dayPeriod.periodChangedStateSelected(isSelected: false)
                weekPeriod.periodChangedStateSelected(isSelected: true)
                monthPeriod.periodChangedStateSelected(isSelected: false)
                dayTimeLapseImage.isHidden = true
                weekTimeLapseImage.isHidden = false
                monthTimeLapseImage.isHidden = true
            } else {
                dayPeriod.periodChangedStateSelected(isSelected: false)
                weekPeriod.periodChangedStateSelected(isSelected: false)
                monthPeriod.periodChangedStateSelected(isSelected: true)
                dayTimeLapseImage.isHidden = true
                weekTimeLapseImage.isHidden = true
                monthTimeLapseImage.isHidden = false
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
    
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundHistoryVC")
        
        view.addSubview(imageView)
        
        return imageView
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
    
    lazy var leftArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "leftArrow")
        
        view.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var rightArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rightArrow")
        
        view.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var dateLabel: UILabel = {
        var label = UILabel()
        label.text = "February 15"
        label.font = .systemFont(ofSize: 14.adjusted, weight: .regular)
        label.textColor = .white
        
        view.addSubview(label)
        
        return label
    }()
    
    lazy var pulseStatisticalImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pulseStatisticalImage")
        
        view.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var dayTimeLapseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dayTimeLapseImage")
        
        view.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var weekTimeLapseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "weekTimeLapseImage")
        imageView.isHidden = true
        
        view.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var monthTimeLapseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "monthTimeLapseImage")
        imageView.isHidden = true
        
        view.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var averageAndMaxPulseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "averageAndMaxPulseImage")
        
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
        
        print("resultsbpm -------------",resultsBPM)
    }
    
    private func setup() {
        
        view.addSubview(backgroundImage)
        //Config UI
        view.backgroundColor = #colorLiteral(red: 0.9197916389, green: 0.9297400713, blue: 0.9338695407, alpha: 1)
        backgroundImage.layer.cornerRadius = 20.adjusted
        
        dayPeriod.periodDelegate = self
        weekPeriod.periodDelegate = self
        monthPeriod.periodDelegate = self
        
        periodIsSelected = .day
        
        view.addSubview(stackView)
        
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
//            make.height.equalTo(UIScreen.main.bounds.width == 375 ? 380 : 460)
//            make.height.equalToSuperview().multipliedBy(0.55)
//            make.bottom.equalTo(view.snp.centerY).offset(40.adjusted)
            make.height.equalTo(493.adjustedHeight)
            
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18.adjusted)
            make.top.equalTo(view.snp.topMargin).offset(20.adjusted)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15.adjusted)
            make.centerX.equalToSuperview()
        }
        
        leftArrowImage.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10.adjusted)
            make.leading.equalTo(35.adjusted)
            make.width.equalTo(8.adjusted)
            make.height.equalTo(12.adjusted)
        }
        
        rightArrowImage.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(10.adjusted)
            make.trailing.equalTo(-35.adjusted)
            make.width.equalTo(8.adjusted)
            make.height.equalTo(12.adjusted)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(rightArrowImage)
        }
        
        pulseStatisticalImage.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(20.adjusted)
//            make.leading.equalTo(20.adjusted)
//            make.trailing.equalTo(-20.adjusted)
            make.centerX.equalToSuperview()
            make.width.equalTo(344.adjusted)
            make.height.equalTo(166.adjustedHeight)
//            make.height.equalTo(backgroundImage).multipliedBy(0.3)
        }
        
        dayTimeLapseImage.snp.makeConstraints { make in
            make.top.equalTo(pulseStatisticalImage.snp.bottom).offset(8.adjusted)
            make.trailing.equalTo(pulseStatisticalImage.snp.trailing)
            make.width.equalTo(312.adjusted)
            make.height.equalTo(25.adjustedHeight)
        }
        
        weekTimeLapseImage.snp.makeConstraints { make in
            make.top.equalTo(pulseStatisticalImage.snp.bottom).offset(8.adjusted)
            make.trailing.equalTo(pulseStatisticalImage.snp.trailing)
            make.width.equalTo(305.adjusted)
            make.height.equalTo(25.adjustedHeight)
        }
        
        monthTimeLapseImage.snp.makeConstraints { make in
            make.top.equalTo(pulseStatisticalImage.snp.bottom).offset(10.adjusted)
            make.trailing.equalTo(pulseStatisticalImage.snp.trailing)
            make.width.equalTo(298.adjusted)
            make.height.equalTo(14.adjustedHeight)
        }
        
        averageAndMaxPulseImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(backgroundImage.snp.bottom).offset(-20.adjusted)
            make.height.equalTo(55.adjustedHeight)
//            make.width.equalTo(278.adjusted)
            make.width.equalToSuperview().multipliedBy(0.66)
        }
        
        historyLabel.snp.makeConstraints { make in
            make.leading.equalTo(18.adjusted)
            make.top.equalTo(averageAndMaxPulseImage.snp.bottom).offset(15.adjusted)
        }
        
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
extension HistoryViewController: PeriodsDelegate, SortingTypesDelegate {
    func chooseType(type: SortingTypes) {
        self.typeIsSelected = type
    }
    
    func choosePeriod(period: Periods) {
        self.periodIsSelected = period
    }
    
}
