import Foundation

extension AlbumsViewController {
    
    func setupConstraints() {
        
        albumsTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func fetchAlbums(albumName: String) {
        
        let urlString = "https://itunes.apple.com/search?term=\(albumName)&entity=album&attribute=albumTerm"
        
        NetworkDataFetch.shared.fetchAlbum(urlString: urlString) { [weak self] albumModel, error in
            
            if error == nil {
                
                guard let albumModel = albumModel else { return }
                
                if albumModel.results != [] {
                    let sortedAlbums = albumModel.results.sorted { firstItem, secondItem in
                
                        return firstItem.collectionName.compare(secondItem.collectionName) == ComparisonResult.orderedAscending
                    }
                    
                    self?.albums = sortedAlbums
                    self?.albumsTableView.reloadData()
                } else {
                    return
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
}
