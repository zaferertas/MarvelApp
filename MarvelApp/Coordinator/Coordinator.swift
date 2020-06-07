
import Foundation
import UIKit

protocol Coordinator {
    var navigationCoordinator : UINavigationController { get set }
    func start()
}
