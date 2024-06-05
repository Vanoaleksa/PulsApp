
import UIKit
import SnapKit

protocol ResultViewDelegate {
    func saveToDBAndCloseResultView()
}

final class ResultScreenView: UIView {
    
    var delegate: ResultViewDelegate?
    
    var resultWindow = ResultWindow()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.frame = UIScreen.main.bounds
        self.backgroundColor = .clear
        resultWindow.delegateResult = self
        
        self.addSubview(resultWindow)
    }
    
    func updateLabelsValues(bpm: Int, date: Double, analyzType: AnalyzeTypes, typePulse: PulseType) {
        resultWindow.updateCompletion?(bpm, date, analyzType, typePulse)
    }
    
    private func setupLayout() {
        
        resultWindow.snp.makeConstraints { make in
            make.bottom.equalTo(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(513)
        }
    }
    
    private func hideViewWithAnimation(){
        let height = 513
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.frame.origin.y += CGFloat(height)
        }) { _ in
            self.removeFromSuperview()
        }
    }
}

extension ResultScreenView: ResultWindowActionsDelegate {
    func tappedButtonOK() {
        hideViewWithAnimation()
        self.delegate?.saveToDBAndCloseResultView()
    }
}
