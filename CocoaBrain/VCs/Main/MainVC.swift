//
//  MainVC.swift
//  CocoaBrain
//
//  Created by Kai on 2/27/25.
//

import UIKit

class MainVC: UIViewController {
    
    let viewModel: MainViewModel = MainViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .brainBackground
        return v
    }()
    
    lazy var menuButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        button.setBackgroundImage(UIImage(named: "ico_menu"), for: .normal)
        button.addTarget(self, action: #selector(menuButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.text = "검사를 진행할 사용자를 선택하세요.\n등록번호 또는 사용자 이름으로 검색어를 입력하면 사용자가 검색됩니다."
        v.font = UIFont.textStyleGuide()
        v.textColor = .brainTertiary
        v.numberOfLines = 0
        return v
    }()
    
    lazy var searchTextField: PaddedTextField = {
        let v = PaddedTextField()
        v.placeholder = "검색어를 입력하세요."
        v.theBorderColor = .brainBorder
        v.theBorderWidth = 1
        v.theCornerRadius = 8
        return v
    }()
    
    lazy var headerView: UIView = {
        let v = UIView()
        v.backgroundColor = .brainSecondary
        v.theCornerRadius = 8
        
        let label1 = UILabel()
        label1.text = "등록번호"
        label1.font = .textStyleGridTitle()
        label1.textColor = .brainTertiary
        label1.textAlignment = .center
        v.addSubview(label1)
        label1.snp.makeConstraints { make in
            make.centerY.equalTo(v)
            make.width.equalTo(180)
        }
        
        let label2 = UILabel()
        label2.text = "사용자 정보"
        label2.font = .textStyleGridTitle()
        label2.textColor = .brainTertiary
        label2.textAlignment = .center
        v.addSubview(label2)
        label2.snp.makeConstraints { make in
            make.left.equalTo(label1.snp.right).offset(4)
            make.width.equalTo(userInfoLabelWidth)
            make.centerY.equalTo(v)
        }
        
        let label3 = UILabel()
        label3.text = "검사횟수"
        label3.font = .textStyleGridTitle()
        label3.textColor = .brainTertiary
        label3.textAlignment = .center
        v.addSubview(label3)
        label3.snp.makeConstraints { make in
            make.left.equalTo(label2.snp.right).offset(4)
            make.width.equalTo(80)
            make.centerY.equalTo(v)
        }
        
        let label4 = UILabel()
        label4.text = "최근 검사"
        label4.font = .textStyleGridTitle()
        label4.textColor = .brainTertiary
        label4.textAlignment = .center
        v.addSubview(label4)
        label4.snp.makeConstraints { make in
            make.left.equalTo(label3.snp.right).offset(4)
            make.width.equalTo(150)
            make.centerY.equalTo(v)
        }
        
        let label5 = UILabel()
        label5.text = "결과"
        label5.font = .textStyleGridTitle()
        label5.textColor = .brainTertiary
        label5.textAlignment = .center
        v.addSubview(label5)
        label5.snp.makeConstraints { make in
            make.left.equalTo(label4.snp.right).offset(4)
            make.width.equalTo(50)
            make.centerY.equalTo(v)
        }
        return v
    }()
    
    lazy var tableView: UITableView = {
        let v = UITableView()
        v.delegate = self
        v.dataSource = self
        v.separatorColor = .clear
        v.register(MainCell.self, forCellReuseIdentifier: MainCell.reuseIdentifier)
        v.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: -30)
        return v
    }()
    
    override func loadView() {
        super.loadView()
        
        title = "뇌인지건강검사"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuButton)
        
        view.backgroundColor = .brainBackground
        view.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(searchTextField)
        contentView.addSubview(headerView)
        contentView.addSubview(tableView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(36)
            make.left.equalTo(contentView).offset(48)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(36)
            make.right.equalTo(contentView).offset(-30)
            make.width.equalTo(253)
            make.height.equalTo(46)
        }
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(16)
            make.left.equalTo(contentView).offset(30)
            make.right.equalTo(contentView).offset(-30)
            make.height.equalTo(54)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(16)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.bottom.equalTo(contentView)
        }
        
        viewModel.prepare()
    }
    
    @objc func menuButtonPressed() {
        let vc = MenuVC()
        vc.delegate = self
        present(vc, animated: true)
    }

}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let d = viewModel.listData[indexPath.row]
        let vc = InspectMainVC(inspectData: d)
        let navi = UINavigationController(rootViewController: vc)
        navi.modalPresentationStyle = .fullScreen
        present(navi, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MainCell
        let d = viewModel.listData[indexPath.row]
        cell.configure(with: d)
        cell.resultButton.tag = indexPath.row
        cell.resultButton.addTarget(self, action: #selector(resultButtonPressed), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    @objc func resultButtonPressed(sender: UIButton) {
        let d = viewModel.listData[sender.tag]
        let vc = InspectReportVC(inspectData: d)
        let navi = UINavigationController(rootViewController: vc)
        navi.modalPresentationStyle = .fullScreen
        present(navi, animated: true)
    }
    
    
}

extension MainVC: MainViewModelDelegate {
    func didUpdateListData() {
        tableView.reloadData()
    }
}

extension MainVC: MenuVCDelegate {
    func addUser() {
        let addUserVC = AddUserVC()
        let navi = UINavigationController(rootViewController: addUserVC)
        navi.modalPresentationStyle = .fullScreen
        present(navi, animated: true)
    }
    
    func signout() {
        PrefsManager.SI.centerName = ""
        PrefsManager.SI.userName = ""
        UDManager.SI.removeTokens()
        
        dismiss(animated: false)
    }
}
