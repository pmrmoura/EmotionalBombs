//
//  DragController.swift
//  EmotionalBombs
//
//  Created by Luis Pereira on 26/07/21.
//

import UIKit

class DragController: UIViewController {
    override func viewDidLoad() {
        self.view.addInteraction(UIDragInteraction(delegate: self))
        print("Drag View")
        
        let backgroundImage = UIImageView(frame: self.view.bounds)
        backgroundImage.image = UIImage(named: "Cenario_DragAndDrop.png")
        backgroundImage.contentMode =  .scaleAspectFill
        self.view.addSubview(backgroundImage)
        
        let url = Bundle.main.url(forResource: "araraflyng", withExtension: "gif")!
        let araraGif = UIImage.gifImageWithURL(url)
        let imageView = UIImageView(image: araraGif)
        imageView.isUserInteractionEnabled = true
        imageView.frame = CGRect(x: 0, y: 0, width: 2732/5, height:2048/5)
        self.view.addSubview(imageView)
    }
}

extension DragController: UIDragInteractionDelegate{
    public func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        print("itens for begging")
        print("touch location \(session.location(in: self.view))")
        if let touchedView = self.view.hitTest(session.location(in: self.view), with: nil) as? UIImageView{
           
            
            let url = Bundle.main.url(forResource: "araraflyng", withExtension: "gif")
            
            let item = UIDragItem(itemProvider: NSItemProvider(contentsOf: url)!)
            item.localObject = touchedView
            return[item]
        }
        
        return []
    }
     public func dragInteraction(_ interaction: UIDragInteraction, previewForLifting item: UIDragItem, session: UIDragSession) -> UITargetedDragPreview? {
        let previewParameters = UIDragPreviewParameters()
        previewParameters.backgroundColor = .init(white: 1, alpha: 0.1)
        previewParameters.visiblePath = UIBezierPath(arcCenter: CGPoint(x: 250, y: 200), radius: 200,  startAngle: 20, endAngle: 50, clockwise: true)
        return UITargetedDragPreview(view: item.localObject as! UIView, parameters: previewParameters)
    }
    
    public func dragInteraction(_ interaction: UIDragInteraction, willAnimateLiftWith animator: UIDragAnimating, session: UIDragSession) {
        session.items.forEach({item in
            if let touchedView = item.localObject as? UIView{
                touchedView.removeFromSuperview()
            }
        })
    }
    
    public func dragInteraction(_ interaction: UIDragInteraction, item: UIDragItem, willAnimateCancelWith animator: UIDragAnimating) {
        print("cancel animation")
        self.view.addSubview(item.localObject as! UIView)
    }
}
