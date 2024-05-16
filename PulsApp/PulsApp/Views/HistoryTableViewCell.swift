

import UIKit
import SnapKit

class HistoryTableViewCell: UITableViewCell {
        
    var typeResult: ResultType!
    var pulseType: SmallPulseTypeView!
    
    lazy var dateLabel: UILabel = {
        var label = UILabel()
        label.text = "February 15 2021, 11:47 AM"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(red: 0.114, green: 0.114, blue: 0.145, alpha: 0.3)
        label.textAlignment = .left
        
        self.addSubview(label)
        
        return label
    }()
    
    lazy var pulseLabel: UILabel = {
        var label = UILabel()
        label.text = "00"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        
        self.addSubview(label)
        
        return label
    }()
    
    lazy var bpmLabel: UILabel = {
        var label = UILabel()
        label.text = "bpm"
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = .black
        
        self.addSubview(label)
        
        return label
    }()
    
    lazy var heartImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "red-heart")
        
        self.addSubview(imageView)
        
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "HistoryTableViewCell")
        
        setupUI()
        setupLayout()
        
//        typeResult.updateAnalyze!(incomeAnalyzeTypes!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = #colorLiteral(red: 0.9197916389, green: 0.9297400713, blue: 0.9338695407, alpha: 1)
        typeResult = ResultType()
        pulseType = SmallPulseTypeView()
        
        self.addSubview(typeResult)
        self.addSubview(pulseType)
    }
    
    private func setupLayout() {
        typeResult.snp.makeConstraints { make in
            make.top.equalTo(2)
            make.leading.equalTo(20)
            make.width.equalToSuperview().dividedBy(7.5)
            make.bottom.equalTo(-10)
        }
        
        pulseLabel.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.leading.equalTo(typeResult.snp.trailing).offset(13)
        }
        
        bpmLabel.snp.makeConstraints { make in
            make.leading.equalTo(pulseLabel.snp.trailing).offset(3)
            make.bottom.equalTo(pulseLabel).offset(-2)
        }
        
        heartImageView.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(bpmLabel.snp.trailing).offset(8)
            make.width.equalToSuperview().dividedBy(31.25)
            make.height.equalTo(11)
//            make.bottom.equalTo(bpmLabel.snp.centerY)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(pulseLabel.snp.bottom).offset(3)
            make.leading.equalTo(pulseLabel)
        }
        
        pulseType.snp.makeConstraints { make in
            make.centerY.equalTo(typeResult)
            make.trailing.equalTo(-20)
            make.width.equalToSuperview().dividedBy(6.35)
            make.height.equalTo(26)
        }
    }
    
}
