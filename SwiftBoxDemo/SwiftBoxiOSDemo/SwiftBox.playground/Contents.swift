//: Playground - noun: a place where people can play

import UIKit
import SwiftBox

let view = UIView(frame: CGRectMake(0, 0, 375, 667))

let strings : [String] = [ "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ex dolor, imperdiet vel tellus sollicitudin, ultrices maximus nunc. Ut non vehicula magna. Etiam sit amet varius lectus, et luctus dui. Sed eget blandit turpis. Nullam laoreet at felis non fermentum. Integer elit sem, tempus eget ex non, mattis porta lorem. Sed ut quam vel nibh luctus bibendum quis sed mi.",
"Fusce scelerisque rhoncus elementum. Maecenas ultricies est ex, ut varius mauris cursus at. Maecenas sollicitudin orci posuere, ultricies lacus vel, scelerisque nibh. Nullam a turpis a urna elementum posuere. Integer porttitor vestibulum urna lobortis tincidunt. Aliquam consectetur sem metus, et laoreet libero rutrum nec. Donec sed justo dapibus, mollis nibh volutpat, sollicitudin sem. Suspendisse tempor, velit ac ullamcorper pretium, sapien risus molestie enim, aliquam cursus ex massa a nisl. Duis gravida, diam eget rutrum sagittis, dui est malesuada mi, a dapibus eros odio sit amet tellus. Nunc porttitor nunc nec massa mollis, et pellentesque est egestas. Vivamus venenatis dignissim massa in euismod. Vestibulum rutrum ex a interdum varius. Donec convallis gravida dui eget viverra. Suspendisse tempor, lorem sit amet consequat mattis, libero ex dictum quam, eget iaculis felis velit eu nunc. Morbi eros lectus, aliquet at pulvinar sed, tempor malesuada elit. Integer blandit gravida felis.",
]

let label = UILabel()
label.numberOfLines = 0

let parent = Node(
//    direction: .Column,
    padding: Edges(top: 20, bottom: 20),
//    size: CGSizeMake(view.frame.size.width, 0),
//    wrap: true,
//    flex: 1,
    children: strings.map { (text : String) -> Node in
        let image = Node(
//            flex: 0,
            size: CGSizeMake(100, 100)
        )
        let text = Node(
            flex: 1,
            margin: Edges(left: 10),
            measure: { w in
                label.text = text
                label.preferredMaxLayoutWidth = w
                println("\(w)")
                return label.sizeThatFits(CGSizeMake(w, CGFloat.max))
        })
        let horizontal = Node(
            direction: Direction.Row,
            size: CGSize(width: view.frame.size.width, height: 0),
            children:[image, text],
//            padding: Edges(uniform: 10),
            margin: Edges(bottom: 10)
        )
        return horizontal
    }
)

let layout = parent.layout(maxWidth: 375)
println(layout)


let image = Node(
    //            flex: 0,
    size: CGSizeMake(100, 100)
)
let row = Node(
    children:[
        Node(
//            flex: 1,
            size: CGSizeMake(100, 100)
        ),
        Node(
            flex: 1,
            size: CGSizeMake(0, 1000),
//            direction: .Row
            measure: { w in
                println(w)
                return CGSizeMake(w, 200)
            }
        ),
        ],
    direction: .Row,
    flex: 1,
    size: CGSizeMake(375, 0)
)


println("==== row ====")
let r = row.layout(maxWidth: 375)
println(r)

//let text = Node(
//    flex: 1,
//    margin: Edges(left: 10),
//    measure: { w in
//        label.text = strings[0]
//        label.preferredMaxLayoutWidth = w
//        println("\(w)")
//        return label.sizeThatFits(CGSizeMake(w, CGFloat.max))
//})
let horizontal = Node(
//    flex: 1,
//    direction: Direction.Row,
//    size: CGSize(width: view.frame.size.width, height: 0),
    children:[image, image, image, row],
//    padding: Edges(uniform: 10),
    margin: Edges(bottom: 10)
//    measure: { w in
//        return CGSizeMake(w, 100)
//    }
)

println("==== horizontal ====")
let h = horizontal.layout(maxWidth: 375)
println(h)

//

let sam = Node(size: CGSize(width: 300, height: 300),
    childAlignment: .Center,
    direction: .Row,
    children: [
        Node(flex: 75,
            margin: Edges(left: 10, right: 10),
            size: CGSize(width: 0, height: 100)),
        Node(flex: 15,
            margin: Edges(right: 10),
            size: CGSize(width: 0, height: 50)),
        Node(flex: 10,
            margin: Edges(right: 10),
//                        size: CGSize(width: 0, height: 180)
            measure: { w in
                println(w)
                return CGSizeMake(w, 400)
            }
        ),
    ])


println("==== sam ====")
let s = sam.layout()
println(s)



public struct TextNode {

    public let text : String
    public let font : UIFont
    public let margin : Edges
    public let padding : Edges

    public func node() -> Node {
        let label : UILabel = UILabel()
        label.numberOfLines = 0
        return Node(margin: self.margin, padding: self.padding, measure: { w in
            label.preferredMaxLayoutWidth = w
            label.text = self.text
            return label.sizeThatFits(CGSizeMake(w, CGFloat.max))
        })
    }

    public init(text: String, font: UIFont, margin: Edges = Edges(uniform: 0), padding : Edges = Edges(uniform: 0)) {
        self.text = text
        self.font = font
        self.margin = margin
        self.padding = padding
    }
    
}

let te = Node(
    direction: .Row,
    children: [
    TextNode(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ex dolor, imperdiet vel tellus sollicitudin, ultrices maximus nunc. Ut non vehicula magna. Etiam sit amet varius lectus, et luctus dui. Sed eget blandit turpis. Nullam laoreet at felis non fermentum. Integer elit sem, tempus eget ex non, mattis porta lorem. Sed ut quam vel nibh luctus bibendum quis sed mi.", font: UIFont.systemFontOfSize(17)).node(),
    Node(size: CGSize(width: 300, height: 150)),
    ])

println("==== te ====")
let t = te.layout(maxWidth: 375)
println(t)