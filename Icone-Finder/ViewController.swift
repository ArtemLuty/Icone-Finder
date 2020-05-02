//
//  ViewController.swift
//  Icone Finder
//
//  Created by Корістувач on 23.04.2020.
//  Copyright © 2020 kolesnikov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var icons = [Icon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = UICollectionViewFlowLayout()
        let size = (collectionView.frame.width - 40)/3
        flowLayout.itemSize = CGSize(width: size, height: size + 20)
        flowLayout.minimumInteritemSpacing = 9
        flowLayout.minimumLineSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.register(UINib(nibName: "IconCollectionViewCell" , bundle: nil), forCellWithReuseIdentifier: "Cell")
        collectionView.allowsSelection = true
        
    }
    
    func seachIcon(_ text: String) {
        Network.shared.searchIcon(string: text) { icons, error in
            guard let icons = icons else { return }
            self.icons = icons
            self.collectionView.reloadData()
            self.title = "Find \(icons.count) icon"
        }
    }
}
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, !text.isEmpty {
            seachIcon(text)
        }
        textField.resignFirstResponder()
        return true
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        icons.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! IconCollectionViewCell
        cell.icon = icons[indexPath.item]
        return cell
    }
}

