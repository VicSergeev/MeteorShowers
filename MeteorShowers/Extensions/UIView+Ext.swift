//
//  UIView+Ext.swift
//  MeteorShowers
//
//  Created by Vic on 26.01.2025.
//

import UIKit
import SnapKit

extension UIView {
    
    func snapKitPin(to superView: UIView) {
        self.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
}


extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
