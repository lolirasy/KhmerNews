//
//  HomeCollectionViewCell.swift
//  Instanime
//
//  Created by ភី ម៉ារ៉ាសុី on 10/18/16.
//  Copyright © 2016 ភី ម៉ារ៉ាសុី. All rights reserved.
//


import UIKit
import Material
class HomeCollectionViewCell: UICollectionViewCell{
    
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        let attrText = NSMutableAttributedString(string: "Kosal died because of Fap Daily", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18)])
        attrText.append(NSAttributedString(string: "\nMonday, August 29,2016",attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 10), NSForegroundColorAttributeName: UIColor.init(red: 155, green: 161, blue: 161, alpha: 0.5)]))
        
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineSpacing = 4
        
        attrText.addAttribute(NSParagraphStyleAttributeName, value: paraStyle,range: NSMakeRange(0,attrText.string.characters.count))
        
        label.attributedText = attrText
        return label
    }()
    
    
    let dividerLineView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 226, green: 228, blue: 232, alpha: 0.5)
        return view
        
    }()
    
    
    let titleImage: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    
    
    override func layoutSubviews() {
        layer.cornerRadius = 8
        layer.borderWidth = 2
        layer.borderColor = Color.grey.lighten2.cgColor

        
        backgroundColor = Color.grey.lighten4
        addSubview(titleLabel)
        addSubview(titleImage)
        addSubview(dividerLineView)
        
        //        let width = frame.size.width
        
        
        addConstaintsWithFormat("H:|-12-[v0]-12-|", views: dividerLineView)
        addConstaintsWithFormat("H:|-8-[v0]|", views: titleLabel)
        addConstaintsWithFormat("H:|[v0]-1-|", views: titleImage)
        addConstaintsWithFormat("V:|-4-[v0]-10-[v1(225)][v2(0.4)]-10-|", views: titleLabel,titleImage,dividerLineView)
        
        
        
    }
    
}
extension UIView{
    func addConstaintsWithFormat(_ format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}


