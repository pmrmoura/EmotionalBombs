//
//  DragController.swift
//  EmotionalBombs
//
//  Created by Luis Pereira on 26/07/21.
//

import UIKit

class DragController: UIViewController{
    
    override func viewDidLoad() {
        self.view.addInteraction(UIDragInteraction(delegate: self))
        print("Drag View")
        let image = UIImage(named: "Arara_Personagem_Animar_Drag")
        let imageView = UIImageView(image: image!)
        imageView.isUserInteractionEnabled = true
        self.view.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: 2732/5, height:2048/5)
    }
}

extension DragController: UIDragInteractionDelegate{
    public func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        print("itens for begging")
        print("touch location \(session.location(in: self.view))")
        if let touchedView = self.view.hitTest(session.location(in: self.view), with: nil) as? UIImageView{
            let touchedImage = touchedView.image
            print(touchedView.frame)
            let item = UIDragItem(itemProvider: NSItemProvider(object: touchedImage!))
            item.localObject = touchedView
            return[item]
        }
        
        return []
    }
     public func dragInteraction(_ interaction: UIDragInteraction, previewForLifting item: UIDragItem, session: UIDragSession) -> UITargetedDragPreview? {
        return UITargetedDragPreview(view: item.localObject as! UIView)
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
