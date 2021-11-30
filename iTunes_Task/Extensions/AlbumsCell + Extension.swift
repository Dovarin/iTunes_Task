import Foundation
import UIKit

extension AlbumsTableViewCell {
    func configureAlbumCell(album: Album) {
        
        if let urlString = album.artworkUrl100 {
            NetworkRequest.shared.requestData(urlString: urlString) { [weak self] result in
                switch result {
                case .success(let data):
                    let image = UIImage(data: data)
                    self?.albumLogo.image = image
                case .failure(_):
                    self?.albumLogo.image = nil
                }
            }
        } else {
            albumLogo.image = nil
        }
        
        albumNameLabel.text = album.collectionName
        artistNameLabel.text = album.artistName
        trackCountLabel.text = "\(album.trackCount) tracks"
    }
    
    func setupConstraints() {
        
        albumLogo.snp.makeConstraints {
            $0.height.width.equalTo(60)
            $0.centerY.equalTo(self)
            $0.leading.equalTo(self).inset(15)
        }
        
        albumNameLabel.snp.makeConstraints {
            $0.top.equalTo(self).offset(10)
            $0.leading.equalTo(albumLogo.snp.trailing).offset(10)
            $0.trailing.equalTo(self).offset(-10)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(albumNameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(albumLogo.snp.trailing).offset(10)
            $0.trailing.equalTo(self).offset(-10)
        }
    }
}
