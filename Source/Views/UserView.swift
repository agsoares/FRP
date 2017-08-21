//
//  UserView.swift
//  Functional
//
//  Created by Adriano Soares on 05/08/17.
//  Copyright © 2017 Adriano Soares. All rights reserved.
//

import UIKit
import ReactiveSwift
import Cartography
import Kingfisher

class UserView: UIView {
    let avatarView = UIImageView()
    let labelName  = UILabel()

    var user = MutableProperty<UserModel?>(nil)

    init() {
        super.init(frame: CGRect.zero)
        setupViews()

        user.signal.observeValues { user in
            if let user = user, let avatarUrl = user.avatar {
                if let url = URL(string: avatarUrl) {
                    self.avatarView.kf.setImage(with: url)
                }

            } else {

            }

        }

        setupConstraints()
        setupStyles()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupViews() {
        addSubview(avatarView)
        addSubview(labelName)
    }

    func setupConstraints () {
        constrain(self, avatarView, labelName) { superView, avatarView, labelName in
            avatarView.height    == avatarView.width
            avatarView.left      == superView.left    + 20
            avatarView.top       == superView.top     + 10
            avatarView.bottom    == superView.bottom  - 10

            labelName.left       == avatarView.right  + 10
            labelName.top        == superView.top     + 10
            labelName.right      == superView.right   + 10
        }
    }

    func setupStyles () {
        backgroundColor = LayoutManager.shared.navigationColor
        avatarView.clipsToBounds = true
        avatarView.backgroundColor = UIColor.white
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        avatarView.layer.cornerRadius = avatarView.frame.size.width/2.0
    }

}
