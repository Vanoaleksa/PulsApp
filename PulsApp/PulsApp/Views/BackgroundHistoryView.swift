
import UIKit
import SnapKit

final class BackgroundHistoryView: UIView {
    
    
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundHistoryVC")
        
        self.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Statistical data"
        let customFont = UIFont(name: "SFProDisplay-Bold", size: 28)
        label.font = customFont
        label.textColor = .white
        
        self.addSubview(label)
        
        return label
    }()
    
    lazy var leftArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "leftArrow")
        
        self.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var rightArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rightArrow")
        
        self.addSubview(imageView)
        
        return imageView
    }()
    
    lazy var dateLabel: UILabel = {
        var label = UILabel()
        label.text = "February 15"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        
        self.addSubview(label)
        
        return label
    }()
    
    private lazy var leftStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .trailing
        stackView.distribution = .fillEqually
        self.insertSubview(stackView, aboveSubview: backgroundImage)
        
        return stackView
    }()
    
    private lazy var rightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        self.insertSubview(stackView, aboveSubview: backgroundImage)
        
        return stackView
    }()
    
    lazy var dayStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        //        stackView.spacing = 3
        stackView.distribution = .fillEqually
        
        self.addSubview(stackView)
        
        return stackView
    }()
    
    lazy var weekStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        self.addSubview(stackView)
        
        return stackView
    }()
    
    lazy var monthStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 1
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        self.addSubview(stackView)
        
        return stackView
    }()
    
    lazy var datePickerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "down-row-image"), for: .normal)
//        button.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        
        self.addSubview(button)
        
        return button
    }()
    
    lazy var datePickerLabel: UILabel = {
        let label = UILabel()
        label.text = "February, 2021"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        
        self.addSubview(label)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.layer.cornerRadius = 20
        
        createGraphicStacks(numberOfStacks: 5, isSecondStack: false)
        createGraphicStacks(numberOfStacks: 5, isSecondStack: true)
        
        createPeriodsStack(numberOfStacks: 5, selectedPeriod: 1)
        createPeriodsStack(numberOfStacks: 7, selectedPeriod: 2)
        createPeriodsStack(numberOfStacks: 7, selectedPeriod: 3)
    }
}




//MARK: - Create Stacks
extension BackgroundHistoryView {
    //Periods stacks
    private func createPeriodsStack(numberOfStacks: Int, selectedPeriod: Int) {
        var n = 0
        
        while n != numberOfStacks {
            if selectedPeriod == 1 {
                if n == 0 || n == 2 || n == 4 {
                    let verticalStackView: UIStackView = {
                        let stackView = UIStackView()
                        stackView.axis = .vertical
                        stackView.spacing = 5
                        stackView.alignment = .center
                        stackView.distribution = .fillEqually
                        
                        return stackView
                    }()
                    
                    let amLabel: UILabel = {
                        let label = UILabel()
                        if n == 0 {
                            label.text = "AM"
                        } else {
                            label.text = "PM"
                        }
                        
                        label.font = .systemFont(ofSize: 11)
                        label.textColor = .white
                        
                        return label
                    }()
                    
                    let timeLabel: UILabel = {
                        let label = UILabel()
                        if n == 2 {
                            label.text = "6"
                        } else {
                            label.text = "12"
                        }
                        label.textAlignment = .center
                        label.font = .systemFont(ofSize: 11)
                        label.textColor = .white
                        
                        return label
                    }()
                    
                    verticalStackView.addArrangedSubview(amLabel)
                    verticalStackView.addArrangedSubview(timeLabel)
                    dayStackView.addArrangedSubview(verticalStackView)
                    
                    n += 1
                } else {
                    var countSlashes = 0
                    
                    let horizontalStackView: UIStackView = {
                        let stackView = UIStackView()
                        stackView.axis = .horizontal
                        stackView.spacing = 3
                        stackView.alignment = .trailing
                        //                        stackView.distribution = .fillProportionally
                        stackView.distribution = .fillEqually
                        
                        return stackView
                    }()
                    
                    while countSlashes != 11 {
                        let slashLabel: UILabel = {
                            let label = UILabel()
                            label.text = "|"
                            label.font = .systemFont(ofSize: 12)
                            label.textColor = .white
                            
                            return label
                        }()
                        horizontalStackView.addArrangedSubview(slashLabel)
                        countSlashes += 1
                    }
                    
                    dayStackView.addArrangedSubview(horizontalStackView)
                    
                    n += 1
                }
            } else if selectedPeriod == 2 {
                let verticalStackView: UIStackView = {
                    let stackView = UIStackView()
                    stackView.axis = .vertical
                    stackView.spacing = 5
                    stackView.alignment = .center
                    stackView.distribution = .fillEqually
                    
                    return stackView
                }()
                
                let nameLabel: UILabel = {
                    let label = UILabel()
                    if n == 0 {
                        label.text = "SUN"
                    } else if n == 1{
                        label.text = "MON"
                    } else if n == 2 {
                        label.text = "TUE"
                    } else if n == 3 {
                        label.text = "WED"
                    } else if n == 4 {
                        label.text = "THU"
                    } else if n == 5 {
                        label.text = "FRI"
                    } else {
                        label.text = "SAT"
                    }
                    label.font = .systemFont(ofSize: 12)
                    label.textColor = .white
                    
                    return label
                }()
                
                let numberOfDaylabel: UILabel = {
                    let label = UILabel()
                    if n == 0 {
                        label.text = "21"
                    } else if n == 1{
                        label.text = "22"
                    } else if n == 2 {
                        label.text = "23"
                    } else if n == 3 {
                        label.text = "24"
                    } else if n == 4 {
                        label.text = "25"
                    } else if n == 5 {
                        label.text = "26"
                    } else {
                        label.text = "27"
                    }
                    label.font = .systemFont(ofSize: 12)
                    label.textColor = .white
                    
                    return label
                }()
                
                verticalStackView.addArrangedSubview(nameLabel)
                verticalStackView.addArrangedSubview(numberOfDaylabel)
                
                weekStackView.addArrangedSubview(verticalStackView)
                
                n += 1
            } else {
                let daysLabel: UILabel = {
                    let label = UILabel()
                    if n == 0 {
                        label.text = "1"
                    } else if n == 1{
                        label.text = "5"
                    } else if n == 2 {
                        label.text = "10"
                    } else if n == 3 {
                        label.text = "15"
                    } else if n == 4 {
                        label.text = "20"
                    } else if n == 5 {
                        label.text = "25"
                    } else {
                        label.text = "28"
                    }
                    label.font = .systemFont(ofSize: 12)
                    label.textColor = .white
                    
                    return label
                }()
                
                monthStackView.addArrangedSubview(daysLabel)
                
                n += 1
            }
        }
    }
    //Graphic stacks
    func createGraphicStacks(numberOfStacks: Int, isSecondStack: Bool) {
        var n = 0
        
        while n != numberOfStacks {
            if isSecondStack {
                let secondLabel: UILabel = {
                    let label = UILabel()
                    label.text =  "------------------------------------------------------------"
                    label.font = .systemFont(ofSize: 12, weight: .regular)
                    label.textColor = .white
                    label.textAlignment = .center
                    
                    return label
                }()
                
                rightStackView.addArrangedSubview(secondLabel)
            } else {
                let firstLabel: UILabel = {
                    let label = UILabel()
                    label.textColor = .white
                    label.font = .systemFont(ofSize: 12, weight: .regular)
                    if n == 0 {
                        label.text = "200"
                    } else if n == 1 {
                        label.text = "150"
                    } else if n == 2 {
                        label.text = "100"
                    } else if n == 3 {
                        label.text = "50"
                    } else {
                        label.text = "0"
                    }
                    
                    return label
                }()
                
                leftStackView.addArrangedSubview(firstLabel)
            }
            
            n += 1
        }
    }
}

//MARK: - Constraints
extension BackgroundHistoryView {
    
    private func setupLayout() {
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topMargin).offset(15)
            make.leading.equalToSuperview().offset(18)
            make.height.equalTo(20)
        }
        
        datePickerButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-18)
            make.top.equalTo(titleLabel).offset(10)
            make.height.equalTo(8)
            make.width.equalToSuperview().dividedBy(28.5)
        }
        
        datePickerLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).offset(8)
            make.trailing.equalTo(datePickerButton.snp.leading).offset(-8)
        }
        
        leftArrowImage.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(85)
            make.leading.equalTo(45)
            make.width.equalToSuperview().dividedBy(40)
            make.height.equalToSuperview().dividedBy(30)
        }
        
        rightArrowImage.snp.makeConstraints { make in
            make.top.equalTo(leftArrowImage)
            make.trailing.equalTo(-45)
            make.width.equalTo(leftArrowImage)
            make.height.equalTo(leftArrowImage)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(leftArrowImage)
            make.height.equalToSuperview().dividedBy(27)
        }
        
        leftStackView.snp.makeConstraints { make in
            make.top.equalTo(rightArrowImage.snp.bottom).offset(20)
            make.leading.equalTo(15)
            make.trailing.equalTo(self.snp.leading).offset(40)
            make.height.equalToSuperview().dividedBy(2.95)
            //            make.bottom.equalToSuperview().offset(-180.adjusted)
        }
        
        rightStackView.snp.makeConstraints { make in
            make.top.equalTo(rightArrowImage.snp.bottom).offset(20)
            make.leading.equalTo(leftStackView.snp.trailing).offset(10)
            make.trailing.equalTo(-15)
            make.bottom.equalTo(leftStackView)
        }
        
        dayStackView.snp.makeConstraints { make in
            make.top.equalTo(rightStackView.snp.bottom).offset(5)
            //            make.leading.equalTo(rightStackView.snp.leading).offset(10)
            make.leading.equalToSuperview().offset(70)
            //            make.trailing.equalTo(rightStackView.snp.trailing).offset(-10)
            make.trailing.equalToSuperview().inset(35)
            make.bottom.equalTo(rightStackView.snp.bottom).offset(37)
        }
        
        weekStackView.snp.makeConstraints { make in
            make.top.equalTo(rightStackView.snp.bottom).offset(5)
            make.leading.equalTo(rightStackView.snp.leading)
            make.trailing.equalTo(rightStackView.snp.trailing)
            make.bottom.equalTo(rightStackView.snp.bottom).offset(37)
        }
        
        monthStackView.snp.makeConstraints { make in
            make.top.equalTo(rightStackView.snp.bottom).offset(5)
            make.leading.equalTo(rightStackView.snp.leading).offset(15)
            make.trailing.equalTo(rightStackView.snp.trailing).offset(10)
            make.bottom.equalTo(rightStackView.snp.bottom).offset(37)
        }
    }
}

