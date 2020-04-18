//
//  UserTableViewCell.swift
//  Ceiba
//
//  Created by Andres Bocanumenth on 4/2/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import UIKit
import SnapKit

class UserTableViewCell: UITableViewCell {
    
    private let nameLabel = UILabel()
    private let phoneLabel = UILabel()
    private let mailLabel = UILabel()
    private let phoneIcon = UIImageView()
    private let mailIcon = UIImageView()
    private let showPublication = UIButton()
    private let containerView = UIView()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    func updateUI(viewModel: UserCellViewModel) {
        nameLabel.text = viewModel.userName
        phoneLabel.text = viewModel.phoneNumber
        mailLabel.text = viewModel.mail
    }
    
    private func configureView() {
        selectionStyle = .none
        backgroundColor = .lightGray
        configureContainerView()
        configureNameLabel()
        configurePhoneIcon()
        configurePhoneLabel()
        configureMailIcon()
        configureMailLabel()
        configureShowPublicationButton()
    }
    
    private func configureContainerView() {
        addSubview(containerView)
        containerView.backgroundColor = .white
        containerView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(20)
            make.right.bottom.equalToSuperview().offset(-20)
        }
    }
    private func configureNameLabel() {
        containerView.addSubview(nameLabel)
        nameLabel.textColor = .ceibaColor
        nameLabel.font = .boldSystemFont(ofSize: 16)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(15)
            make.top.equalTo(5)
            make.height.equalTo(25)
        }
    }
    
    private func configurePhoneIcon() {
        containerView.addSubview(phoneIcon)
        phoneIcon.image = UIImage(systemName: "phone.fill")?.withRenderingMode(.alwaysTemplate)
        phoneIcon.tintColor = .ceibaColor
        phoneIcon.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.height.width.equalTo(25)
        }
    }
    
    private func configurePhoneLabel() {
        containerView.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { (make) in
            make.left.equalTo(phoneIcon.snp.right).offset(10)
            make.right.equalTo(15)
            make.top.equalTo(nameLabel.snp.bottom).offset(7)
            make.height.equalTo(25)
        }
    }
    
    private func configureMailIcon() {
        containerView.addSubview(mailIcon)
        mailIcon.image = UIImage(systemName: "envelope.fill")?.withRenderingMode(.alwaysTemplate)
        mailIcon.tintColor = .ceibaColor
        mailIcon.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(phoneLabel.snp.bottom).offset(5)
            make.height.width.equalTo(25)
        }
    }
    
    private func configureMailLabel() {
        containerView.addSubview(mailLabel)
        mailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(mailIcon.snp.right).offset(10)
            make.right.equalTo(15)
            make.top.equalTo(phoneLabel.snp.bottom).offset(7)
            make.height.equalTo(25)
        }
    }
    
    private func configureShowPublicationButton() {
        containerView.addSubview(showPublication)
        showPublication.setTitle("Ver Publicaciones".uppercased(), for: .normal)
        showPublication.setTitleColor(.ceibaColor, for: .normal)
        showPublication.titleLabel?.font = .boldSystemFont(ofSize: 14)
        showPublication.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.top.equalTo(mailLabel.snp.bottom).offset(30)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
}
