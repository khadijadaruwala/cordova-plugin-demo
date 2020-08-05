import Foundation
import UIKit

//MARK: View controller
extension UIViewController {
    func addChildController(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)

        if let frame = frame {
            child.view.frame = frame
        }

        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func removeChildController() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

//MARK: UICcolor
extension UIColor{
    @nonobjc class var purplePrimary: UIColor {
        return UIColor(red: 0.345, green: 0.231, blue: 0.753, alpha: 1)
    }

    @nonobjc class var blackGrey: UIColor {
        return UIColor(red: 0.18, green: 0.184, blue: 0.212, alpha: 1)
    }

    @nonobjc class var lightGrey: UIColor {
        return UIColor(red: 0.18, green: 0.184, blue: 0.212, alpha: 1)
    }
}

//MARK: Font
extension UIFont {
    class func montserratMedium(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Medium", size: size)!
    }

    class func montserratRegular(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Regular", size: size)!
    }
}
