//
//  ServiceZoneViewController.swift
//  OCNTVControl
//
//  Created by hryan on 16/3/10.
//  Copyright © 2016年 Shanghai Oriental Finance Service Co., Ltd. All rights reserved.
//

import UIKit

let kScreen_width = UIScreen.mainScreen().bounds.width
let KScreen_height = UIScreen.mainScreen().bounds.height
let kCollectionViewCell1 = "Cell1"
let kCollectionViewCell2 = "Cell2"
let kCollectionViewCell3 = "Cell3"

class ServiceZoneViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView?
    var dataSourec_first :NSArray?
    var dataSource_second :NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "模板定制"
        dataSourec_first = ["金融服务","金融服务","金融服务","金融服务","金融服务",]
        dataSource_second = ["dataSource_second","dataSource_second"]
        
        setupCollection()
        // Do any additional setup after loading the view.
    }
    
    
    
    func setupCollection(){
        let layout = FECollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        self.collectionView?.delegate = self
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        self.collectionView?.dataSource = self;
        self.collectionView?.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: kCollectionViewCell1)
        self.collectionView!.alwaysBounceVertical = true
        self.view.addSubview(self.collectionView!)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

private typealias collectionViewDelegate = ServiceZoneViewController

extension collectionViewDelegate {
    
    //    MARK:--------dataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var number:Int?
        switch(section){
        case 0: number = dataSourec_first?.count
            break
        case 1: number = dataSource_second?.count
            break
        case 2: number = 1
            break
            
        default: break
        }
        
        return number!
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCollectionViewCell1, forIndexPath: indexPath) as! CollectionViewCell
        cell.label.text = dataSourec_first![indexPath.row] as? String
        
        return cell
        
    }
    
//    
//    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//        
//        let headView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "cell", forIndexPath: indexPath)
//        
//        return headView
//    }
    
    //    MARK: --------------delegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
            print("didSelectItemAtIndexPath:\(indexPath)")
    }
    
    // MARK:   UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var itemSize: CGSize! = CGSizeZero
        let item1Width = (kScreen_width - 70)/3
        switch(indexPath.section){
        case 0: itemSize = CGSize(width: item1Width, height: 44)
            break
        case 1: itemSize = CGSize(width: kScreen_width, height: 44)
            break
        case 2:  itemSize = CGSize(width: kScreen_width - 40, height: 44)
            break
            
        default: break
        }
        return itemSize;
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let edgeInsets = UIEdgeInsetsZero
        
        return edgeInsets
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
//        return 15
//    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        var itemSize: CGSize!
        let item1Width = (kScreen_width - 80)/3
        switch(section){
        case 0: itemSize = CGSize(width: item1Width, height: 44)
            break
        case 1: itemSize = CGSize(width: kScreen_width, height: 44)
            break
        case 2:  itemSize = CGSize(width: kScreen_width - 40, height: 44)
            break
            
        default: break
        }
        return itemSize;
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        var itemSize: CGSize!
        let item1Width = (kScreen_width - 70)/3
        switch(section){
        case 0: itemSize = CGSize(width: item1Width, height: 44)
            break
        case 1: itemSize = CGSize(width: kScreen_width, height: 44)
            break
        case 2:  itemSize = CGSize(width: kScreen_width - 40, height: 44)
            break
            
        default: break
        }
        return itemSize;
    }
}

