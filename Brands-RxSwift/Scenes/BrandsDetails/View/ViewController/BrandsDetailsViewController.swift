//
//  BrandsDetailsViewController.swift
//  Rx-MVVM
//
//  Created by Ahmed Fathy on 04/12/2021.
//

import UIKit
import RxCocoa
import RxSwift

class BrandsDetailsViewController: UIViewController {
    
    private var viewModel: BrandsDetailsViewModel!
    private let bag = DisposeBag()
    private let barButton = UIButton(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
    @IBOutlet weak var tableView: UITableView!
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  init
    //----------------------------------------------------------------------------------------------------------------
    init(viewModel: BrandsDetailsViewModel = BrandsDetailsViewModel()){
        super.init(nibName: "BrandsDetailsViewController", bundle: nil)
        self.viewModel = viewModel
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Life Cycle
    //----------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        backBackBarButtonView()
        configureTableView()
        bindingFromViewModelToTitleNavigation()
        bindingToCreatTableViewCell()
        handelBarButtonBack()
    }
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Helper Function
    //----------------------------------------------------------------------------------------------------------------
    func configureTableView(){
        tableView.rowHeight = 85
        tableView.register(UINib(nibName: DetailsTableViewCell.cellID, bundle: nil), forCellReuseIdentifier: DetailsTableViewCell.cellID)
    }
    
    
    
    func bindingFromViewModelToTitleNavigation(){
        viewModel.titleObservable.bind { title in
            self.title = title
        }.disposed(by: bag)
    }
    
    func bindingToCreatTableViewCell(){
        viewModel.detailsList.bind(to: tableView.rx.items(cellIdentifier: DetailsTableViewCell.cellID, cellType: DetailsTableViewCell.self)){(row, model , cell) in
            cell.setDataCell(model)
        }.disposed(by: bag)
        viewModel.fetchDataFromBrands()
    }
    
    
    func backBackBarButtonView(){
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 50))
        barButton.setImage(UIImage(systemName: "chevron.backward",withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
        barButton.tintColor = .black
        view.addSubview(barButton)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: view)
        
    }
    
    
    func handelBarButtonBack(){
        barButton.rx
            .tap
            .bind { _ in
            self.viewModel.goToHome()
        }.disposed(by: bag)
    }
    
    
}
