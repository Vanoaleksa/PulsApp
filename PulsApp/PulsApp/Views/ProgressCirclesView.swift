import UIKit
import SnapKit

final class ProgressCirclesView: UIView {
    
    private let progressLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    private var initialProgress: CGFloat = 0.0

    let procentsLabel = UILabel()
    let nameLabel = UILabel()
    let gramsLabel = UILabel()
    
    init(frame: CGRect, progress: CGFloat, procentsLabelText: String, nameLabelText: String, gramsLabelText: String ) {
        super.init(frame: frame)
        setupView()
//        setProgress(progress)
        self.initialProgress = progress
        setupLabels(procentsLabelText: procentsLabelText, nameLabelText: nameLabelText, gramsLabelText: gramsLabelText)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setProgress(0.0)
    }
    
    private func setupView() {
        
        let endAngle = 2 * CGFloat.pi
        let startAngle = -CGFloat.pi / 2
        let center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        let radius = frame.width / 2
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        // Настройка backgroundLayer
        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = #colorLiteral(red: 0.8618590236, green: 0.8668316007, blue: 0.8882443309, alpha: 1)
        backgroundLayer.lineWidth = 4
        backgroundLayer.strokeEnd = 1.0
        backgroundLayer.position = CGPoint(x: bounds.midX - 7, y: bounds.midY - bounds.height / 4)
        layer.addSublayer(backgroundLayer)
        
        // Настройка progressLayer
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.orange.cgColor
        progressLayer.lineWidth = 4
        progressLayer.strokeEnd = 0.0
        progressLayer.position = CGPoint(x: bounds.midX - 7, y: bounds.midY - bounds.height / 4)
        layer.addSublayer(progressLayer)
        
        addSubview(procentsLabel)
        addSubview(nameLabel)
        addSubview(gramsLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setProgress(initialProgress)
    }
    
    private func setProgress(_ progress: CGFloat) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 1
        animation.fromValue = progressLayer.strokeEnd
        animation.toValue = progress
        progressLayer.add(animation, forKey: "animateProgress")
                
        progressLayer.strokeEnd = progress
    }
    
    private func setupLabels(procentsLabelText: String ,nameLabelText: String, gramsLabelText: String) {
        
        procentsLabel.text = procentsLabelText
        procentsLabel.textAlignment = .center
        procentsLabel.font = .systemFont(ofSize: 16, weight: .medium)
        procentsLabel.textColor = .black
        
        nameLabel.text = nameLabelText
        nameLabel.textAlignment = .center
        nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textColor = .black
        
        gramsLabel.text = gramsLabelText
        gramsLabel.textAlignment = .center
        gramsLabel.font = .systemFont(ofSize: 14, weight: .light)
        gramsLabel.textColor = .black
    }

    
    private func setupLayout() {
        
        procentsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(20)
            make.centerX.equalToSuperview()
        }
        
        gramsLabel.snp.makeConstraints { make in
            make.bottom.equalTo(45)
            make.centerX.equalToSuperview()
        }
    }
}


