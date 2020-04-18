//
//  DetailPostTableViewCell.swift
//  Ceiba
//
//  Created by Andres Bocanumenth on 4/2/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import UIKit

class DetailPostTableViewCell: UITableViewCell {

    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    func updateUI(viewModel: PostModel) {
        titleLabel.text = viewModel.title
        bodyLabel.text = viewModel.body
    }
    
    private func configureView() {
        selectionStyle = .none
        backgroundColor = .lightGray
        configureTitle()
        configureBody()
    }
    
    private func configureTitle() {
        addSubview(titleLabel)
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .ceibaColor
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(30)
        }
    }
    
    private func configureBody() {
        addSubview(bodyLabel)
        bodyLabel.numberOfLines = 2
        bodyLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }

}
