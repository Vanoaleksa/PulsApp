
import UIKit
import SnapKit

class UnitsView: UIView{
    
    public weak var unitsDelegate: UnitsDelegate?
    private var units: Units
    private var imageView: UIImageView!
    private var unitsLabel: UILabel!
    
    init(units: Units) {
        self.units = units
        super.init(frame: .zero)
        setupView(unitsText: units.unitsString)
        tapGesture()
        setupLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(unitsText: String){
        
        imageView = UIImageView(image: UIImage(named: "FullRectangle"))
        imageView.contentMode = .scaleAspectFit
        
        unitsLabel = UILabel()
        unitsLabel.font = .systemFont(ofSize: 14.adjusted)
        unitsLabel.textColor = .white
        unitsLabel.text = unitsText
        
        self.addSubview(imageView)
        self.addSubview(unitsLabel)
    }
    
    public func changeColor(isSelected: Bool){
        self.unitsLabel.textColor = UIColor(cgColor: isSelected == true ? .init(red: 1, green: 1, blue: 1, alpha: 1) : .init(red: 0.4, green: 0.463, blue: 0.98, alpha: 1))
    }
    
    private func tapGesture(){
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAndChooseUnits)))
    }
    
    @objc private func tapAndChooseUnits(){
        self.unitsDelegate?.chooseUnits(units: units)
    }
    
    public func unitsChangeStateSelected(isSelected: Bool){
        DispatchQueue.main.async {
            self.imageView.image = UIImage(named: isSelected == true ? "FullRectangle" : "EmptyRectangle")
        }
    }
    
    private func setupLayout(){
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(self.snp_margins)
        }
        
        unitsLabel.snp.makeConstraints { make in
            make.center.equalTo(imageView)
        }
    }
}
