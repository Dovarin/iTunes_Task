import Foundation

extension UserInfoViewController {
    
    func setupConstraints() {
        
        stackView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(20)
//            $0.centerY.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
        }
    }
}
