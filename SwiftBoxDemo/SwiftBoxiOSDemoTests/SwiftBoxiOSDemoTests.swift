//
//  SwiftBoxiOSDemoTests.swift
//  SwiftBoxiOSDemoTests
//
//  Created by James Tang on 12/7/15.
//  Copyright (c) 2015 Josh Abernathy. All rights reserved.
//

import UIKit
import XCTest
import SwiftBox

class SwiftBoxiOSDemoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFramesInRect() {
        let parent = Node(children: [
            Node(size: CGSize(width: 100, height: 200)),
            Node(size: CGSize(width: 300, height: 150)),
            ])

        let layout = parent.layout()

        XCTAssertEqual(layout.layoutsInRect(CGRectMake(0, 0, 100, 100)).count, 1, "")
        XCTAssertEqual(layout.layoutsInRect(CGRectMake(0, 0, 100, 100)).first!.frame, CGRectMake(0, 0, 100, 200), "")

    }

    func testTextNode() {


        let parent = Node(children: [
            TextNode(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ex dolor, imperdiet vel tellus sollicitudin, ultrices maximus nunc. Ut non vehicula magna. Etiam sit amet varius lectus, et luctus dui. Sed eget blandit turpis. Nullam laoreet at felis non fermentum. Integer elit sem, tempus eget ex non, mattis porta lorem. Sed ut quam vel nibh luctus bibendum quis sed mi.", font: UIFont.systemFontOfSize(17)).node(),
            Node(size: CGSize(width: 300, height: 150)),
            ])

        parent.layout(maxWidth: 375)

    }

    func testLayoutSize() {

        let strings : [String] = [
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ex dolor, imperdiet vel tellus sollicitudin, ultrices maximus nunc. Ut non vehicula magna. Etiam sit amet varius lectus, et luctus dui. Sed eget blandit turpis. Nullam laoreet at felis non fermentum. Integer elit sem, tempus eget ex non, mattis porta lorem. Sed ut quam vel nibh luctus bibendum quis sed mi.",
            "Fusce scelerisque rhoncus elementum. Maecenas ultricies est ex, ut varius mauris cursus at. Maecenas sollicitudin orci posuere, ultricies lacus vel, scelerisque nibh. Nullam a turpis a urna elementum posuere. Integer porttitor vestibulum urna lobortis tincidunt. Aliquam consectetur sem metus, et laoreet libero rutrum nec. Donec sed justo dapibus, mollis nibh volutpat, sollicitudin sem. Suspendisse tempor, velit ac ullamcorper pretium, sapien risus molestie enim, aliquam cursus ex massa a nisl. Duis gravida, diam eget rutrum sagittis, dui est malesuada mi, a dapibus eros odio sit amet tellus. Nunc porttitor nunc nec massa mollis, et pellentesque est egestas. Vivamus venenatis dignissim massa in euismod. Vestibulum rutrum ex a interdum varius. Donec convallis gravida dui eget viverra. Suspendisse tempor, lorem sit amet consequat mattis, libero ex dictum quam, eget iaculis felis velit eu nunc. Morbi eros lectus, aliquet at pulvinar sed, tempor malesuada elit. Integer blandit gravida felis.",
            ]

        let label = UILabel()
        label.numberOfLines = 0

        let textOnly = Node(
            direction: .Column,
            padding: Edges(top: 20, bottom: 20),
            children: strings.map { (text : String) -> Node in
                let text = Node(
                    measure: { w in
                        println("\(w)") // 355
                        label.text = text
                        label.preferredMaxLayoutWidth = w
                        return label.sizeThatFits(CGSizeMake(w, CGFloat.max))
                })
                return text
            }
        )
        println(textOnly.layout(maxWidth: 375).frame)

        let imageText = Node(
            direction: .Column,
            padding: Edges(top: 20, bottom: 20),
            size: CGSizeMake(375, CGFloat.NaN),     // I just have to make sure I defined the size here, height is important to be Nan
            children: strings.map { (text : String) -> Node in
                let image = Node(
                    size: CGSizeMake(100, 100)
                )
                let text = Node(
                    flex: 1,                        // And make sure flex are set
                    measure: { w in
                        label.text = text
                        label.preferredMaxLayoutWidth = w
                        return label.sizeThatFits(CGSizeMake(w, CGFloat.max))
                })
                let row = Node(
                    direction: Direction.Row,
                    children:[image, text]
                )
                return row
            }
        )
        println(imageText.layout().frame)

        let layout = textOnly.layout(maxWidth: 375)
        println(layout)
        XCTAssertEqual(layout.frame.size.width, 375, "")
        XCTAssertEqual(layout.frame.size.height, 669 , "")


        let layout2 = imageText.layout()
        println(layout2)
        XCTAssertEqual(layout2.frame.size.width, 375, "")
        XCTAssertEqual(layout2.frame.size.height, 912.5 , "")
    }
    
    
}
