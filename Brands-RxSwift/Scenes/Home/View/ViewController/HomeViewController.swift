//
//  HomeViewController.swift
//  Rx-MVVM
//
//  Created by Ahmed Fathy on 03/12/2021.
//

import UIKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Proberties
    //----------------------------------------------------------------------------------------------------------------
    private var viewModel: HomeViewModel!
    private let bag = DisposeBag()
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Outlet
    //----------------------------------------------------------------------------------------------------------------
    
    @IBOutlet weak var tableView: UITableView!
        
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Init
    //----------------------------------------------------------------------------------------------------------------
    init( viewModel: HomeViewModel){
        super.init(nibName: "HomeViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Life cycle
    //----------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationView()
        configureTableViewCell()
        bindingFromViewModel()
        bindingToAddDataToTableViewCells()
        setDidSelectTableView()
    }

    
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Helper Functions
    //----------------------------------------------------------------------------------------------------------------
    func configureTableViewCell(){
        tableView.rowHeight = 75
        tableView.register(UINib(nibName: BrandsTableViewCell.cellID, bundle: nil), forCellReuseIdentifier: BrandsTableViewCell.cellID)
    }
    
    
    private func configureNavigationView(){
        self.title = "Brands"
        
        let attributes: [NSAttributedString.Key:Any] = [.font: UIFont.boldSystemFont(ofSize: 25)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.backgroundColor = .white
    }
    
    
    func bindingFromViewModel(){
        
        // Observable For Start Or Hide Hud
        viewModel.progressState.bind { state in
            switch state {
            case true:
                Hud.showHud(in: self.view)
            case false:
                Hud.dismiss()
            }
        }.disposed(by: bag)
    }

    
    private func bindingToAddDataToTableViewCells(){
        viewModel.brandsList
            .bind(to: tableView.rx.items(cellIdentifier: BrandsTableViewCell.cellID,
                                         cellType: BrandsTableViewCell.self)) { (row , model , cell) in
            cell.setCell(data: model)
        }.disposed(by: bag)
        viewModel.fetchDataModel()
    }
    
    
    private func setDidSelectTableView(){
        tableView.rx
            .modelSelected(Datum.self)
            .subscribe(onNext: { model in
                self.viewModel.didSelectItemsTableView(model)
        }).disposed(by: bag)
    }
    
    
}
