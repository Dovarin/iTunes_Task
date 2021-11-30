import Foundation
import UIKit

extension DetailAlbumViewController {
    
    func setupConstraints() {
        
        albumLogo.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(20)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.equalTo(albumLogo.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        trackList.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom)
            $0.leading.equalTo(albumLogo.snp.trailing).offset(17)
            $0.trailing.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func setModel() {
        
        guard let album = album else { return }

        albumNameLabel.text = album.collectionName
        artistNameLabel.text = album.artistName
        trackCoungLabel.text = "\(album.trackCount) tracks"
        releaseDateLabel.text = setDateFormat(date: album.releaseDate )
        
        guard let url = album.artworkUrl100 else { return }
        
        setImage(urlString: url)
    }
    
    func setDateFormat(date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        
        guard let backendDate = dateFormatter.date(from: date) else { return ""  }
        
        let formatDate = DateFormatter()
        formatDate.dateFormat = "dd-MM-yyyy"
        let date = formatDate.string(from: backendDate)
        return date
    }
    
    func setImage(urlString: String?) {
        
        if let url = urlString {
            NetworkRequest.shared.requestData(urlString: url) { [weak self] result in
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
    }
    
    func fetchSong(album: Album?) {
        
        guard let album = album else { return }
        
        let idAlbum = album.collectionId
        let urlString = "https://itunes.apple.com/lookup?id=\(idAlbum)&entity=song"
        
        NetworkDataFetch.shared.fetchSongs(urlString: urlString) { [weak self] songModel, error in
            if error == nil {
                guard let songModel = songModel else { return }
                
                self?.songs = songModel.results
                self?.trackList.reloadData()
            } else {
                print(error!.localizedDescription)
            }
        }
    }
}
