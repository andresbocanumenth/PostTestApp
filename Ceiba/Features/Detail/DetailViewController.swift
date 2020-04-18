//
//  DetailViewController.swift
//  Ceiba
//
//  Created by Andres Bocanumenth on 4/2/20.
//  Copyright © 2020 Andres Bocanumenth. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var userId = 0
    private let cellIdentifier = "postCell"
    private let detailViewModel = DetailViewModel()
    private let nameLabel = UILabel()
    private let phoneLabel = UILabel()
    private let mailLabel = UILabel()
    private let phoneIcon = UIImageView()
    private let mailIcon = UIImageView()
    private let containerView = UIView()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        tableView.separatorColor = .none
        tableView.register(DetailPostTableViewCell.self, forCellReuseIdentifier: cellIdentifier)        
        tableView.dataSource = self
        configureBinding()
        configureContainerView()
        configureNameLabel()
        configurePhoneIcon()
        configurePhoneLabel()
        configureMailIcon()
        configureMailLabel()
        configureTableView()
        detailViewModel.fetchData(by: userId)
    }
    
    private func configureBinding() {
        detailViewModel.refreshData = {
            self.tableView.reloadData()
        }
        detailViewModel.didGetUserInfo = { [weak self] userModel in
            guard let strongSelf = self,
                    let userModel = userModel else {
                return
            }
            strongSelf.updateUI(viewModel: UserCellViewModel(model: userModel))
        }
    }
    
    private func updateUI(viewModel: UserCellViewModel) {
        nameLabel.text = viewModel.userName
        phoneLabel.text = viewModel.phoneNumber
        mailLabel.text = viewModel.mail
    }
    
    private func configureContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor = .white
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
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
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailViewModel.postModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! DetailPostTableViewCell
        
        cell.updateUI(viewModel: detailViewModel.postModels[indexPath.row])
        return cell
    }
}

