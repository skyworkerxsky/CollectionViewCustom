//
//  ViewController.swift
//  CollectionViewCustom
//
//  Created by Damien Romito on 08/02/2017.
//
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    let reuseIdentifier = "CustomCell"
    let collectionMargin = CGFloat(0)
    let itemSpacing = CGFloat(20)
    let itemHeight = CGFloat(322)
    
    var itemWidth = CGFloat(0)
    var currentItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setup()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var items = ["Item 1 ", "Item 2 ", "Item 3 ", "Item 4 ", "Item 5 ", "Item 6 ", "Item 7 ", "Item 8 ", "Item 9 ",
                 "Item 1 ", "Item 2 ", "Item 3 ", "Item 4 ", "Item 5 ", "Item 6 ", "Item 7 ", "Item 8 ", "Item 9 ",
                 "Item 1 ", "Item 2 ", "Item 3 ", "Item 4 ", "Item 5 ", "Item 6 ", "Item 7 ", "Item 8 ", "Item 9 ",
                 "Item 1 ", "Item 2 ", "Item 3 ", "Item 4 ", "Item 5 ", "Item 6 ", "Item 7 ", "Item 8 ", "Item 9 ",
                 "Item 1 ", "Item 2 ", "Item 3 ", "Item 4 ", "Item 5 ", "Item 6 ", "Item 7 ", "Item 8 ", "Item 9 "]

    
    
    func setup() {
//
//        let bundle = Bundle(for: CustomCollectionViewCell.self)
//        let nib = UINib(nibName: String(describing: CustomCollectionViewCell.self), bundle:bundle)
//        self.collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        itemWidth = 250
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.headerReferenceSize = CGSize(width: collectionMargin, height: 0)
        layout.footerReferenceSize = CGSize(width: collectionMargin, height: 0)
        
        layout.minimumLineSpacing = itemSpacing
        layout.scrollDirection = .horizontal
        collectionView!.collectionViewLayout = layout
//        collectionView?.decelerationRate = UIScrollViewDecelerationRateNormal
    
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        self.pageControl.numberOfPages = items.count
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! CustomCollectionViewCell
        
        // Configure the cell
        cell.titleLabel.text = items[indexPath.row]
        
        return cell
    }
    
    
    // MARK: - UIScrollViewDelegate protocol
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageWidth = Float(itemWidth + itemSpacing)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(collectionView!.contentSize.width  )
        var newPage = Float(self.currentItem)
        
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? self.currentItem + 1 : self.currentItem - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        
        self.currentItem = Int(newPage)
        print("CURRENT ITEM - ", currentItem)
        let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
    }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    print("END")
  }

}
