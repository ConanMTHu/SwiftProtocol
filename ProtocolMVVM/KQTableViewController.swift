//
//  KQTableViewController.swift
//  ProtocolMVVM
//
//  Created by Tommy on 16/1/18.
//  Copyright © 2016年 Tommy. All rights reserved.
//

import UIKit

protocol CompanyPresentAble {
    var positionText: String {get}
}

typealias InvestPersonViewModelAble = protocol<PersonPresentAble,ImagePresentAble,CompanyPresentAble>

protocol PersonPresentAble {
    var nameTelText: String {get}
}

// 可以通过扩展提供默认实现...可用可不用
extension PersonPresentAble {
    var nameTelText: String {
        return "hehe"
    }
}

typealias TapImageViewAction = () -> ()
protocol ImagePresentAble {
    var showImage: UIImage? {get}
    var tapHandle: TapImageViewAction? {get}
}

struct PersonModel {
    var firstName: String
    var lastName: String
    var fullName: String {
        return lastName + firstName
    }
    var telPhone: String
    var avatarImageUrl: String?
}

typealias TelPersonViewModelAble = protocol<PersonPresentAble,ImagePresentAble>
struct TelPersonViewModel: TelPersonViewModelAble {
    var telPerson: PersonModel
    var nameTelText: String
    var showImage: UIImage?
    var tapHandle: TapImageViewAction?
    
    init(model:PersonModel,tapHandle: TapImageViewAction?) {
        self.telPerson = model
        self.nameTelText = model.fullName + "  " + model.telPhone
        self.showImage = UIImage(named: model.avatarImageUrl!) // 暂时这样,按道理是加载url,否则没必要写到viewmodel中
        self.tapHandle = tapHandle
    }
}

class ContactTableViewCell: UITableViewCell {
    @IBOutlet weak var telTextLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var tapHandle: TapImageViewAction?

    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapAction")
        avatarImageView.addGestureRecognizer(tapGesture)
    }
    
    func configureDataWithViewModel(viewModel: TelPersonViewModelAble) {
        telTextLabel.text = viewModel.nameTelText
        avatarImageView.image = viewModel.showImage
        tapHandle = viewModel.tapHandle
    }
    
    func tapAction() {
        if let block = tapHandle {
            block()
        }
    }
}


class KQTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("hehe", forIndexPath: indexPath) as! ContactTableViewCell
        let testModel = PersonModel(firstName: "明涛", lastName: "胡", telPhone: "15279107716", avatarImageUrl: "麒麟星.jpg")
        let testViewModel = TelPersonViewModel(model: testModel) {
            print("我点击了头像")
        }
        cell.configureDataWithViewModel(testViewModel)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
}
