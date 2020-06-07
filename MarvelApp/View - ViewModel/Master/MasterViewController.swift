
import UIKit
import RxSwift

class MasterViewController: UIViewController, VCInstantiator {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel : MasterViewModel!
    weak var coordinator : AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.accessibilityIdentifier = "mainTableView"
        viewModel.loadCharacters()
        
        viewModel.isFetching.drive(activityIndicator.rx.isAnimating)
        .disposed(by: disposeBag)
        
        viewModel.error.drive(onNext: { (error) in

            if let error = error {
                self.errorLabel.isHidden = false
                self.errorLabel.text = error
            } else {
                self.errorLabel.isHidden = true
            }
            
        }).disposed(by: disposeBag)
        
        viewModel.characters.drive(tableView.rx.items(cellIdentifier: "cell", cellType: TableViewCell.self)) {
            (_, character, cell) in
            cell.characterName.text = character.name
            if let url = URL(string: character.thumbnail.url) {
                cell.characterImage.kf.setImage(with: url)
            } else {
                cell.characterImage.image = nil
            }
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Character.self).subscribe(onNext: {
            character in
            self.viewModel.goToDetailsView(character: character)
        }).disposed(by: disposeBag)

    }
    

}

