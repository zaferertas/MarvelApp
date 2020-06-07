
import UIKit
import Kingfisher

class DetailsViewController: UITableViewController, VCInstantiator {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    @IBOutlet weak var eventsCollectionView: UICollectionView!

    var character : Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMainDetails()
    }
    
    func setMainDetails() {
        nameLabel.text = character?.name
        descriptionLabel.text = character?.description
        if let url = URL(string: character?.thumbnail.url ?? "") {
            imageView.kf.setImage(with: url)
        } else {
            imageView.image = nil
        }
    }
}

// MARK: CollectionView Datasource
extension DetailsViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
            case comicsCollectionView:
                return character?.comics?.items?.count ?? 0
            case seriesCollectionView:
                return character?.series?.items?.count ?? 0
            case storiesCollectionView:
                return character?.stories?.items?.count ?? 0
            case eventsCollectionView:
                return character?.events?.items?.count ?? 0
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell
        
        var name : String?
        
        switch collectionView {
            case comicsCollectionView:
                if let item = character?.comics?.items {
                    name = item[indexPath.row].name!
                }
            case seriesCollectionView:
                if let item = character?.series?.items {
                    name = item[indexPath.row].name!
                }
            case storiesCollectionView:
                if let item = character?.stories?.items {
                    name  = item[indexPath.row].name!
                }
            case eventsCollectionView:
                if let item = character?.events?.items {
                    name = item[indexPath.row].name!
                }
            default:
                name = ""
        }
        
        cell?.itemLabel.text = name
        return cell!
    }

}
