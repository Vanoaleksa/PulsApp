//
//  ProgressView.swift
//  PulsApp
//
//  Created by MacBook on 7.03.24.
//

import UIKit
import SnapKit

class ProgressView: UIView {
        
    var shapeLayer = CAShapeLayer()
    var trackLayer = CAShapeLayer()
    
    lazy var pulseLabel: UILabel = {
        var label = UILabel()
        label.text = "00"
        label.font = .systemFont(ofSize: 60, weight: .medium)
        
        self.addSubview(label)
        
        return label
    }()
    
    lazy var bpmLabel: UILabel = {
        var label = UILabel()
        label.text = "bpm"
        label.font = .systemFont(ofSize: 16)
        
        self.addSubview(label)
        
        return label
    }()
    
    lazy var heartImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "red-heart")
        
        self.addSubview(imageView)
        
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
        setupLayout()
        createCircleShape()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
    }
    
    func createCircleShape() {
        
        let endAngle = 2 * CGFloat.pi
        let startAngle = -CGFloat.pi / 2
        let center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        let radius = frame.width / 2
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        trackLayer.path = path.cgPath
        trackLayer.strokeColor = CGColor(red: 194/255, green: 190/255, blue: 250/255, alpha: 1)
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 20
        trackLayer.lineCap = .round
        
        self.layer.addSublayer(trackLayer)
        
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = CGColor(red: 113/255, green: 102/255, blue: 249/255, alpha: 1)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 20
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func startAniamation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 25
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = true
        self.shapeLayer.add(basicAnimation, forKey: "animation")
    }
    
    func deleteAnimations() {
        shapeLayer.removeAllAnimations()
        trackLayer.removeAllAnimations()
    }
}

extension ProgressView {
    func setupLayout() {
        
        pulseLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(-15)
        }
        
        bpmLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(12)
            make.left.equalTo(pulseLabel.snp.right).offset(5)
        }
        
        heartImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-13)
            make.left.equalTo(pulseLabel.snp.right).offset(10)
            make.height.equalTo(18)
            make.width.equalTo(20)
        }
    }
}
