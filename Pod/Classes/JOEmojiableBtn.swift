//
//  JOEmojiableBtn.swift
//  JOEmojiableBtn
//
//  Created by Jorge Raul Ovalle Zuleta on 2/28/16.
//  Copyright © 2016 jorgeovalle. All rights reserved.
//

import UIKit

/**
 *  Control's configuration, details on Github https://github.com/lojals/JOEmojiableBtn
 */
public struct JOEmojiableConfig{
    var spacing:CGFloat
    var size:CGFloat
    var minSize:CGFloat
    var maxSize:CGFloat
    var s_options_selector:CGFloat
    
    public init(spacing:CGFloat,size:CGFloat,minSize:CGFloat,maxSize:CGFloat,s_options_selector:CGFloat){
        self.spacing            = spacing
        self.size               = size
        self.minSize            = minSize
        self.maxSize            = maxSize
        self.s_options_selector = s_options_selector
    }
}

/**
 *  TODO: use name value to create Option's labels
 */
public struct JOEmojiableOption{
    var image:String
    var name:String
    
    public init(image:String,name:String){
        self.image = image
        self.name  = name
    }
}

public protocol JOEmojiableDelegate{
    func selectedOption(sender:JOEmojiableBtn,index:Int)
    func singleTap(sender:JOEmojiableBtn)
    func canceledAction(sender:JOEmojiableBtn)
}

public class JOEmojiableBtn: UIButton {
    public var delegate:JOEmojiableDelegate!
    public var dataset:[JOEmojiableOption]!
    
    var longTap:UILongPressGestureRecognizer!
    var singleTap:UITapGestureRecognizer!
    var drag:UIPanGestureRecognizer!
    
    var active:Bool!
    var selectedItem:Int!
    var bgClear:SelectorView!
    var options:UIView!
    var origin:CGPoint!
    
    var information:InformationView!
    
    let spacing:CGFloat
    let size:CGFloat
    let minSize:CGFloat
    let maxSize:CGFloat
    let s_options_selector:CGFloat
    
    /**
     Initialization with parameters as default (Facebook reactions iOS App)
     
     - parameter frame: Frame of the button will open the selector
     
     */
    
    public override init(frame: CGRect) {
        self.spacing            = 6
        self.size               = 40
        self.minSize            = 34
        self.maxSize            = 80
        self.s_options_selector = 30
        super.init(frame: frame)
        self.initialize()
    }
    
    /**
     Initialization with Custom sizes check Documentation Github project
     
     - parameter frame: Frame of the button will open the selector
     - parameter config: JOEmojiableConfig value with custom sizes
     */
    
    public init(frame: CGRect, config:JOEmojiableConfig){
        self.spacing            = config.spacing
        self.size               = config.size
        self.minSize            = config.minSize
        self.maxSize            = config.maxSize
        self.s_options_selector = config.s_options_selector
        super.init(frame: frame)
        self.initialize()
    }
    
    
    private func initialize(){
        longTap = UILongPressGestureRecognizer(target: self, action: Selector("longTapEvent"))
        singleTap = UITapGestureRecognizer(target: self, action: Selector("singleTapEvent"))
        self.addGestureRecognizer(longTap)
        self.addGestureRecognizer(singleTap)
        self.layer.masksToBounds = false
        active = false
    }
    
    func longTapEvent(){
        activate()
    }
    
    func singleTapEvent(){
        activate()
    }
    
    /**
     Function that open the Options Selector
     */
    private func activate(){
        if !active {
            if dataset != nil {
                let frameSV = UIScreen.main.bounds
                selectedItem = -1
                active = true
                bgClear = SelectorView(frame: frameSV)
                bgClear.delegate = self
                bgClear.backgroundColor = UIColor.clear
                
                UIApplication.shared
                
                origin = self.superview?.convert(self.frame.origin, to: nil)
                
                if origin != self.frame.origin {
                    bgClear.frame.origin.x -= origin.x
                    bgClear.frame.origin.y -= origin.y
                }
                
                self.superview?.addSubview(bgClear)
                
                let sizeBtn:CGSize = CGSize(width: ((CGFloat(dataset.count+1)*spacing)+(size*CGFloat(dataset.count))), height: size+(2*spacing))
                options = UIView(frame: CGRect(x: origin.x, y: origin.y - (sizeBtn.height), width: sizeBtn.width, height: sizeBtn.height))
                options.layer.cornerRadius  = options.frame.height/2
                options.backgroundColor     = UIColor.white
                options.layer.shadowColor   = UIColor.lightGray.cgColor
                options.layer.shadowOffset  = CGSize(width: 0.0, height: 0.0)
                options.layer.shadowOpacity = 0.5
                options.alpha               = 0.3
                bgClear.addSubview(options)
                
                UIView.animate(withDuration: 0.2, animations: { () -> Void in
                    self.options.frame.origin.y = self.origin.y - (self.s_options_selector+sizeBtn.height)
                    self.options.alpha          = 1
                })
                
                for i in 0..<dataset.count {
                    let option = UIImageView(frame: CGRect(x: (CGFloat(i+1)*spacing)+(size*CGFloat(i)), y: sizeBtn.height*1.2, width: 10, height: 10))
                    option.image = UIImage(named: dataset[i].image)
                    option.alpha = 0.6
                    options.addSubview(option)
                    UIView.animate(withDuration: 0.2, delay: 0.05*Double(i), options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                        option.frame.origin.y       = self.spacing
                        option.alpha                = 1
                        option.frame.size           = CGSize(width: self.size, height: self.size)
                        option.center               = CGPoint(x: (CGFloat(i+1)*self.spacing)+(self.size*CGFloat(i))+self.size/2, y: self.spacing+self.size/2)
                    }, completion: nil)
                }
                
                information = InformationView(frame: CGRect(x: 0, y: origin.y, width: frameSV.width, height: self.frame.height))
                information.backgroundColor = UIColor.white
                bgClear.addSubview(information)
            }
            else{
                print("Please, initialize the dataset.")
            }
        }
    }
    
    /**
     Function that close the Options Selector
     */
    fileprivate func deActivate(optionIdx:Int){
        for (i,option) in self.options.subviews.enumerated(){
            UIView.animate(withDuration: 0.2, delay: 0.05*Double(i), options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                self.information.alpha = 0
                option.alpha      = 0.3
                option.frame.size = CGSize(width: 10, height: 10)
                if(optionIdx == i){
                    option.center     = CGPoint(x: (CGFloat(i+1)*self.spacing)+(self.size*CGFloat(i))+self.size/2, y: -self.options.frame.height+self.size/2)
                }else{
                    option.center     = CGPoint(x: (CGFloat(i+1)*self.spacing)+(self.size*CGFloat(i))+self.size/2, y: self.options.frame.height+self.size/2)
                }
            }, completion:  { (finished) -> Void in
                if finished && i == (self.dataset.count/2){
                    UIView.animate(withDuration: 0.1, animations: { () -> Void in
                        self.options.alpha          = 0
                        self.options.frame.origin.y = self.origin.y - (self.size+(2*self.spacing))
                    },completion:  { (finished) -> Void in
                        self.active = false
                        self.bgClear.removeFromSuperview()
                        if (optionIdx < 0){
                            self.delegate.canceledAction(sender: self)
                        }else{
                            self.delegate.selectedOption(sender: self, index: self.selectedItem)
                        }
                    })
                }
            })
        }
    }
    
    fileprivate func loseFocus(){
        selectedItem = -1
        information.activateInfo(active: true)
        UIView.animate(withDuration: 0.3) { () -> Void in
            let sizeBtn:CGSize = CGSize(width: ((CGFloat(self.dataset.count+1)*self.spacing)+(self.size*CGFloat(self.dataset.count))), height: self.size+(2*self.spacing))
            self.options.frame = CGRect(x: self.origin.x, y: self.origin.y - (self.s_options_selector+sizeBtn.height), width: sizeBtn.width, height: sizeBtn.height)
            self.options.layer.cornerRadius = sizeBtn.height/2
            for (idx,view) in self.options.subviews.enumerated(){
                view.frame = CGRect(x: (CGFloat(idx+1)*self.spacing)+(self.size*CGFloat(idx)), y: self.spacing, width: self.size, height: self.size)
            }
        }
    }
    
    func selectIndex(index:Int){
        if index >= 0 && index < dataset.count{
            selectedItem = index
            information.activateInfo(active: false)
            UIView.animate(withDuration: 0.3) { () -> Void in
                let sizeBtn:CGSize = CGSize(width: ((CGFloat(self.dataset.count-1)*self.spacing)+(self.minSize*CGFloat(self.dataset.count-1))+self.maxSize), height: self.minSize+(2*self.spacing))
                self.options.frame = CGRect(x: self.origin.x, y: self.origin.y - (self.s_options_selector+sizeBtn.height), width: sizeBtn.width, height: sizeBtn.height)
                self.options.layer.cornerRadius = sizeBtn.height/2
                var last:CGFloat = index != 0 ? self.spacing : 0
                for (idx,view) in self.options.subviews.enumerated(){
                    switch(idx){
                    case (index-1):
                        view.frame    = CGRect(x: last, y: self.spacing, width: self.minSize, height: self.minSize)
                        view.center.y = (self.minSize/2) + self.spacing
                        last          += self.minSize
                    case (index):
                        view.frame    = CGRect(x: last, y: -(self.maxSize/2), width: self.maxSize, height: self.maxSize)
                        last          += self.maxSize
                    default:
                        view.frame    = CGRect(x: last, y: self.spacing, width: self.minSize, height: self.minSize)
                        view.center.y = (self.minSize/2) + self.spacing
                        last          += self.minSize + self.spacing
                    }
                }
            }
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JOEmojiableBtn:SelectorViewDelegate {
    /**
     Function that track the user's touch, and help to find the selection user want to do.
     
     - parameter point: user's touch point
     */
    public func movedTo(point:CGPoint){
        let t = options.frame.width/CGFloat(dataset.count)
        if (point.y < (options.frame.minY - 50) || point.y > (information.frame.maxY + 30)){
            loseFocus()
        }else{
            if (point.x-origin.x > 0 && point.x < options.frame.maxX){
                selectIndex(index: Int(round((point.x-origin.x)/t)))
            }else{
                loseFocus()
            }
        }
    }
    
    public func endTouch(point:CGPoint){
        if (point.x > 0 && point.x < options.frame.maxX){
            self.deActivate(optionIdx: selectedItem)
        }else{
            self.deActivate(optionIdx: -1)
        }
    }
}

public class InformationView :UIView{
    private var textInformation:UILabel!
    public override func draw(_ rect: CGRect) {
        let dots = UIBezierPath()
        dots.move(to: CGPoint(x: 18.5, y: (rect.height/2)))
        dots.addLine(to: CGPoint(x: rect.width, y: (rect.height/2)))
        dots.lineCapStyle = CGLineCap.round
        UIColor(red:0.8, green:0.81, blue:0.82, alpha:1).setStroke()
        dots.lineWidth = 3
        let dashes: [CGFloat] = [dots.lineWidth * 0, 37]
        dots.setLineDash(dashes, count: dashes.count, phase: 0)
        dots.stroke()
        
        let lineSuperior = UIBezierPath()
        lineSuperior.move(to: CGPoint(x: 0, y: 0))
        lineSuperior.addLine(to: CGPoint(x: rect.width, y: 0))
        UIColor(red:0.8, green:0.81, blue:0.82, alpha:1).setStroke()
        lineSuperior.lineWidth = 1
        lineSuperior.stroke()
        
        let lineInferior = UIBezierPath()
        lineInferior.move(to: CGPoint(x: 0, y: rect.height))
        lineInferior.addLine(to: CGPoint(x: rect.width, y: rect.height))
        UIColor(red:0.8, green:0.81, blue:0.82, alpha:1).setStroke()
        lineInferior.lineWidth = 1
        lineInferior.stroke()
        
        textInformation                 = UILabel(frame: CGRect(x: 0, y: 1, width: rect.width, height: rect.height-2))
        textInformation.backgroundColor = UIColor.white
        textInformation.textColor       = UIColor(red:0.57, green:0.59, blue:0.64, alpha:1)
        textInformation.text            = "Release to Cancel"
        textInformation.textAlignment   = .center
        textInformation.font            = UIFont.boldSystemFont(ofSize: 12)
        textInformation.alpha           = 0
        self.addSubview(textInformation)
    }
    
    func activateInfo(active:Bool){
        textInformation.alpha = active ? 1 : 0
    }
}
