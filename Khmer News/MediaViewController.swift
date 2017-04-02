//
//  HomeViewController.swift
//  Instanime
//
//  Created by ភី ម៉ារ៉ាសុី on 10/18/16.
//  Copyright © 2016 ភី ម៉ារ៉ាសុី. All rights reserved.
//

import UIKit
import Material
import Firebase
import SDWebImage

private let reuseIdentifier = "MyCell"



class MediaViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout ,UITextFieldDelegate {
    
    var ref = FIRDatabaseReference()
    var ArrayNews = [News]()
    var newsId = Int()
    var segueText = "newsSegue"
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        newsId = indexPath.item
        self.performSegue(withIdentifier: segueText, sender: self)
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 10)
    }
    
    

    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = Color.grey.lighten2
        
        self.collectionView!.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        menuButton.image = Icon.menu
        if revealViewController() != nil {
            //            revealViewController().rearViewRevealWidth = 62
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            revealViewController().rightViewRevealWidth = 150
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
            
        }

       
    
    
    
    
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
        
    }
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width-20, height: 320)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ArrayNews.count;
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        ArrayNews.removeAll()

        
        ref.child("Media").observe(.childAdded) { (snap: FIRDataSnapshot) in
            let snapshot = snap.value as? NSDictionary
            
            self.ArrayNews.append(News(t: snapshot?["title"] as! String,i: snapshot?["image"] as! String,d: snapshot?["description"] as! String, date: snapshot?["datetime"] as! String))
            self.collectionView?.reloadData()
        }
        
        
        super.viewWillAppear(true)
        
        
    }
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCollectionViewCell
        
        ArrayNews.sort(by: {$0.nDate > $1.nDate})
        
        setText(label: cell.titleLabel, firstString: ArrayNews[indexPath.item].nTitle, secondString: ArrayNews[indexPath.item].nDate)
        cell.titleImage.sd_setImage(with: URL(string: ArrayNews[indexPath.item].nImage))
        // print(ArrayNews[indexPath.item].nImage)
        return cell
    }
    func setText(label: UILabel, firstString: String, secondString: String){
        label.numberOfLines = 3
        let attrText = NSMutableAttributedString(string: firstString, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18)])
        attrText.append(NSAttributedString(string: "\n"+secondString,attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 10), NSForegroundColorAttributeName: UIColor.lightGray]))
        
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineSpacing = 4
        
        attrText.addAttribute(NSParagraphStyleAttributeName, value: paraStyle,range: NSMakeRange(0,attrText.string.characters.count))
        label.attributedText = attrText
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueText {
            
            let destination = segue.destination as! NewsViewController
            destination.newsTitle = ArrayNews[newsId].nTitle
            destination.newsArticle = ArrayNews[newsId].nDetail
            destination.newsImage1 = ArrayNews[newsId].nImage
        }
    }
    
    
    
    
    
    
    
    
    
    

    
}
