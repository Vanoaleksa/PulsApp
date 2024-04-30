
import UIKit
import SnapKit

final class PeriodView: UIView {
    
    public weak var periodDelegate: PeriodsDelegate?
    private var period: Periods
    private var imageView = UIImageView()
    private var periodsLabel = UILabel()
    
    init(periods: Periods) {
        self.period = periods
        super.init(frame: .zero)
        
        setupView(periodText: periods.periodsString)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(periodText: String) {
        
        imageView.image = UIImage(named: "FullPeriodsRectangle")
        imageView.contentMode = .scaleAspectFit
        
        periodsLabel.text = periodText
        periodsLabel.font = .systemFont(ofSize: 14.adjusted)
        periodsLabel.textColor = UIColor(red: 113/255, green: 102/255, blue: 249/255, alpha: 1)
        
        self.addSubview(imageView)
        self.addSubview(periodsLabel)
        
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAndChoosePeriod)))
    }
    
    @objc func tapAndChoosePeriod() {
        self.periodDelegate?.choosePeriod(period: period)
    }
    
    public func periodChangedStateSelected(isSelected: Bool) {
        DispatchQueue.main.async {
            self.imageView.image = UIImage(named: isSelected == true ? "FullPeriodsRectangle" : "EmptyPeriodsRectangle")
            self.periodsLabel.textColor = UIColor(cgColor: isSelected == true ? .init(red: 113/255, green: 102/255, blue: 249/255, alpha: 1) : .init(red: 1, green: 1, blue: 1, alpha: 1))

        }
    }
    
    private func setupLayout() {
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        periodsLabel.snp.makeConstraints { make in
            make.center.equalTo(imageView)
        }
    }
    
}
