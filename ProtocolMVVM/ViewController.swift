//
//  ViewController.swift
//  ProtocolMVVM
//
//  Created by Tommy on 16/1/13.
//  Copyright © 2016年 Tommy. All rights reserved.
//

import UIKit

//// 父类
//class Animal {
//    var name: String = ""
//    var type: String = ""
//    func eat(){} // 虽然是行为,但是吃并不能成为区分"能做什么"的行为,飞却可以
////    func fly(){}
//}
//
//class Bird: Animal {
//    func fly(){
//        print("Bird can fly")
//    }
//}
//
//class Preson: Animal {
//    func speak(){
//        print("person can speak")
//    }
//}
//
//class Fish: Animal {
//    func swimming() {
//        print("fish can swimming")
//    }
//}
//
//// 假设超人会飞不会游泳,复制飞的方法
//class SuperMan: Preson {
//    override func speak() {
//        print("superman also speak")
//    }
//    func fly(){
//        print("superman also fly")
//    }
//}
//
//// 会游泳的超人,这时要复制游的方法,到这里已经是第四层了...
//class SuperFishMan: SuperMan {
//    func swimming() {
//        print("superfishman can swimming")
//    }
//}

protocol Property {
    var name: String {get}
    var type: String {get}
}

extension Property {
    var name: String {
        return "超人"
    }
    var type: String {
        return "外星类"
    }
}

protocol Speaker {
    func speak()
}

protocol Flyer {
    func fly()
}

protocol Swimer {
    func swimming()
}


struct SuperMan {
}

extension SuperMan: Property,Flyer,Speaker {
    func fly() {
        print("superman also fly")
    }
    func speak() {
        print("superman also speak")
    }
}

struct SuperFishMan {
}

extension SuperFishMan: Property,Flyer,Speaker,Swimer {
    var name: String {
        return "超水人"
    }
    func fly() {
        print("...")
    }
    func speak() {
        print("...")
        
    }
    func swimming() {
        print("....")
    }
}



//typealias clickButtonAction = () -> ()
//class KQUserAvatarViewManager {
//    var userAvatarView: KQUserAvatarView!
//    var tapHandle: clickButtonAction?
//    
//    func setupUserAvatarViewAtContainView(view: UIView,tapHandle: clickButtonAction?) {
//        userAvatarView = KQUserAvatarView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//        userAvatarView.backgroundColor = UIColor.orangeColor()
//        view.addSubview(userAvatarView)
//        self.tapHandle = tapHandle
//        userAvatarView.btn.addTarget(self, action: "clickOnAvatarView", forControlEvents: .TouchUpInside)
//    }
//    
//    func clickOnAvatarView() {
//        if let block = self.tapHandle {
//            block()
//        }
//    }
//}

//class ViewController: UIViewController {
//    var manager: KQUserAvatarViewManager!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        manager.setupUserAvatarViewAtContainView(self.view) {
//            print("点击了按钮")
//        }
//        
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//}

//override func viewDidLoad() {
//    super.viewDidLoad()
//}
//
//override func didReceiveMemoryWarning() {
//    super.didReceiveMemoryWarning()
//    // Dispose of any resources that can be recreated.
//}

typealias ClickButtonAction = () -> ()
class KQUserAvatarView: UIView {
    var btn: UIButton!
    var tapBlock: ClickButtonAction?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        btn = UIButton(type: .ContactAdd)
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.addSubview(btn)
        
        btn.addTarget(self, action: "clickOnAvatarView", forControlEvents: .TouchUpInside)
    }
    
    func clickOnAvatarView() {
        if let blcok = tapBlock {
            blcok()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol UserAvatarViewAble: class {
    var userAvatarView: KQUserAvatarView! {get set}
    func setupUserAvatarView(tapHandle: ClickButtonAction?)
}

extension UserAvatarViewAble where Self: UIViewController {
    //  扩展不能实现储存属性
    func setupUserAvatarView(tapHandle: ClickButtonAction?) {
        userAvatarView = KQUserAvatarView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        userAvatarView.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(userAvatarView)
        userAvatarView.tapBlock = tapHandle
    }
}

class ViewController: UIViewController, UserAvatarViewAble {
    var userAvatarView: KQUserAvatarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserAvatarView {
            print("点击了按钮")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


