//
//  Extension.swift
//  Rx-MVVM
//
//  Created by Ahmed Fathy on 04/12/2021.
//

import UIKit
import Kingfisher


extension UIView{
    
    func set_Shadow_For_View(cornerRadius: CGFloat
                             ,shadowColor: CGColor
                             ,shadowRadius: CGFloat){
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = 1
    }
    
}


extension UIImageView{
    func setImage(_ strURL: String){
        guard let handllingURL = (strURL).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{return}
        guard let imageURL = URL(string: handllingURL) else {return}
        
        self.kf.indicatorType = .activity
        self.kf.setImage(with: imageURL
                         , placeholder: UIImage(systemName: "RxSwift_Logo")
                         , options: [.transition(.fade(0.8))])
    }
}
