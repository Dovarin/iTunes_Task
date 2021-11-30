import UIKit
import SnapKit

class SongsCollectionViewCell: UICollectionViewCell {
    
    let nameSongLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        self.addSubview(nameSongLabel)
        
        nameSongLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(self)
            $0.leading.trailing.equalTo(self).offset(5)
            $0.trailing.equalTo(self).offset(-5)
        }
    }
}
