//
//  ViewController.swift
//  RacerMaker
//
//  Created by David Bireta on 12/26/16.
//  Copyright © 2016 David Bireta. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
    @IBOutlet weak var headCollectionView: UICollectionView!
    @IBOutlet weak var bodyCollectionView: UICollectionView!
    @IBOutlet weak var footCollectionView: UICollectionView!
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Getting fancy
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior()
        animator.addBehavior(gravity)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateCollectionViewLayouts(with: size)
    }
    
    private func updateCollectionViewLayouts(with size: CGSize) {
        if let layout = headCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: headCollectionView.bounds.width, height: headCollectionView.bounds.height)
            layout.invalidateLayout()
        }
        
        if let layout = bodyCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: bodyCollectionView.bounds.width, height: bodyCollectionView.bounds.height)
            layout.invalidateLayout()
        }
        
        if let layout = footCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: footCollectionView.bounds.width, height: footCollectionView.bounds.height)
            layout.invalidateLayout()
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == headCollectionView {
            return BodyPartsStore.shared.heads().count
        } else if collectionView == bodyCollectionView {
            return BodyPartsStore.shared.bodies().count
        } else if collectionView == footCollectionView {
            return BodyPartsStore.shared.feet().count
        }
        
        // Shouldn't ever get to this
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == headCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadCell", for: indexPath)
            let headItem = BodyPartsStore.shared.heads()[indexPath.row]
            
            cell.contentView.backgroundColor = headItem
            
            return cell
        } else if collectionView == bodyCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BodyCell", for: indexPath)
            let headItem = BodyPartsStore.shared.bodies()[indexPath.row]
            
            cell.contentView.backgroundColor = headItem
            
            return cell
        } else if collectionView == footCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FootCell", for: indexPath)
            let headItem = BodyPartsStore.shared.feet()[indexPath.row]
            
            cell.contentView.backgroundColor = headItem
            
            return cell
        }
        
        // Should not get to this
        return UICollectionViewCell()
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    // handle dismissal of presented popover! :]
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Show popover with all the choices
//        if collectionView == headCollectionView {
//            if let partsVC = storyboard?.instantiateViewController(withIdentifier: "headPickerVC") {
//                partsVC.modalPresentationStyle = .popover
//                present(partsVC, animated: true, completion: nil)
//                
//                // Yep, this comes after the fact
//                let popController = partsVC.popoverPresentationController
//                popController?.sourceView = collectionView.superview
//                popController?.sourceRect = CGRect(x: 0, y: 0, width: collectionView.bounds.width * 0.5, height: collectionView.bounds.height / 2.0)
//            }
//        }
//        
//        // Capture a screenshot
//        UIGraphicsBeginImageContext(view.frame.size)
//        view.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        // -- Save it to the Photos app
//        PHPhotoLibrary.shared().performChanges({
//            PHAssetCreationRequest.creationRequestForAsset(from: image!)
//        }) { (success, error) in
//            guard error == nil else {
//                print(error!)
//                return
//            }
//            
//            if success {
//                print("Photo saved!")
//            } else {
//                print("Could not save photo :[")
//            }
//        }
        
        // Create a new `UIView` with the image for animating in?
        let snapshot = view.snapshotView(afterScreenUpdates: true)
        snapshot?.frame = CGRect(origin: CGPoint(x: 200 , y:0), size: CGSize(width: (snapshot?.bounds.width)!/2.0, height: (snapshot?.bounds.height)!/2.0))
        snapshot?.layer.borderColor = UIColor.black.cgColor
        snapshot?.layer.borderWidth = 2
        view.addSubview(snapshot!)
        
        gravity.addItem(snapshot!)
        
        let behavior = UIDynamicItemBehavior(items: [snapshot!])
        behavior.density = 15
        animator.addBehavior(behavior)
        
        let snapBehavior = UISnapBehavior(item: snapshot!, snapTo: view.center)
        snapBehavior.damping = 0.1
        animator.addBehavior(snapBehavior)
        
        
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: headCollectionView.bounds.width, height: headCollectionView.bounds.height)
    }
}

