//
//  ViewController.swift
//  SwiftBoxiOSDemo
//
//  Created by James Tang on 12/7/15.
//  Copyright (c) 2015 Josh Abernathy. All rights reserved.
//

import UIKit
import SwiftBox

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: SwiftBoxCollectionViewLayout!

    var node : Node!
    var layout : Layout!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.reloadLayout()
        self.reloadData()
    }

    @IBAction func reloadButtonDidPress(sender: AnyObject) {
        self.reloadLayout()
    }

    func reloadLayout() {
        let label = UILabel()
        label.numberOfLines = 0

        let parent = Node(
            direction: .Column,
            padding: Edges(top: 20, bottom: 20),
            size: CGSizeMake(self.view.frame.size.width, CGFloat.NaN),
            children: strings.map { (text : String) -> Node in
                let image = Node(
                    size: CGSizeMake(100, 100)
                )
                let text = Node(
                    flex: 1,
                    margin: Edges(left: 10),
                    measure: { w in
                        label.text = text
                        label.preferredMaxLayoutWidth = w
                        var size = label.sizeThatFits(CGSizeMake(w, CGFloat.max))
                        size.height = ceil(size.height)
                        size.width = w
                        return size
                })
                let horizontal = Node(
                    direction: Direction.Row,
                    children:[image, text],
                    padding: Edges(uniform: 10),
                    margin: Edges(bottom: 10)
                )
                return horizontal
            }
        )

        self.node = parent
        self.layout = parent.layout(maxWidth: self.view.frame.size.width)
        collectionViewLayout.layout = self.layout
    }

    func reloadData() {
        self.collectionView.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.reloadLayout()
    }
}

extension ViewController : UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return strings.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell

        let layout = self.layout.children[indexPath.row]
        layout.apply(cell.contentView)
        cell.textLabel.text = strings[indexPath.row]
        cell.setNeedsLayout() // Somehow after applying layout to the view some of them may not take effect

        return cell
    }
}

extension ViewController : UICollectionViewDelegate {

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        let layout = self.layout.children[indexPath.row]

        let alert : UIAlertController = UIAlertController(title: "layout", message: "\(layout)\n\nsubviews:\n\(cell!.contentView.subviews)", preferredStyle: UIAlertControllerStyle.Alert)


        alert.addAction(UIAlertAction(title: "Layout", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            cell?.setNeedsLayout()
        }))

        alert.addAction(UIAlertAction(title: "Display", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            cell?.setNeedsDisplay()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))

        self.presentViewController(alert, animated: true, completion: nil)
    }

}

