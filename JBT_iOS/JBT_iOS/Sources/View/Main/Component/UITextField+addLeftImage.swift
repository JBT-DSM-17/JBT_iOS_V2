import UIKit

extension UITextField {
    func addLeftPadding(margin: Int) {
        let leftImageView = UIView(frame: CGRect(x: 0, y: 0, width: margin, height: 20))
        self.leftView = leftImageView
        self.leftViewMode = .always
    }
}
