
import Foundation
import UIKit

class AppCoordinator : Coordinator {
    
    var navigationCoordinator: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationCoordinator = navigationController
    }
    
    func start() {
        showMasterView()
    }
    
    func showMasterView() {
        let viewModel = MasterViewModel(apiService: MarvelApiService())
        viewModel.coordinator = self
        let vc = MasterViewController.instantiate()
        vc.viewModel = viewModel
        
        vc.title = "Marvel Heroes"
        navigationCoordinator.pushViewController(vc, animated: false)
    }
    
    
    func showDetailsView(character: Character) {
        let vc = DetailsViewController.instantiate()
        vc.character = character
        vc.title = character.name
        navigationCoordinator.pushViewController(vc, animated: true)
    }
}
