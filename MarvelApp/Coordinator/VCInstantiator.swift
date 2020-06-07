
import Foundation
import UIKit

protocol VCInstantiator {
    static func instantiate() -> Self
}

extension VCInstantiator where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main )
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
