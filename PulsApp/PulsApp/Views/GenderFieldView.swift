
import UIKit

final class GenderFieldView: UIStackView{
   
   public weak var delegate: GenderCellDelegate?
   private var gender: Gender
   private var imageView: UIImageView!
   private var titleLabel: UILabel!
   
   init(gender: Gender){
       self.gender = gender
       super.init(frame: .zero)
       setupUI(titleText: gender.rawValue)
       tapGesture()
   }
   
   required init(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   private func setupUI(titleText: String){
       self.axis = .horizontal
       self.spacing = 6
       
       imageView = UIImageView(image: UIImage(named: "checkboxUnselected"))
       imageView.contentMode = .scaleAspectFit
       
       titleLabel = UILabel()
       titleLabel.textColor = UIColor(red: 0.114, green: 0.114, blue: 0.145, alpha: 1)
       titleLabel.font = .systemFont(ofSize: 16.adjusted)
       titleLabel.textAlignment = .center
       titleLabel.text = titleText
       
       self.addArrangedSubview(imageView) 
       self.addArrangedSubview(titleLabel)
   }
   
   private func tapGesture(){
       self.isUserInteractionEnabled = true
       self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseGender)))
   }
   
   public func changeStateSelected(isSelected: Bool){
       DispatchQueue.main.async {
           self.imageView.image = UIImage(named: isSelected == true ? "checkboxSelected" : "checkboxUnselected")
       }
   }
   
   @objc private func chooseGender(){
       delegate?.tapOnChooseGenderField(gender: gender)
   }
}
