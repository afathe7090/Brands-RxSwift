//
//  PhoneDetailsViewController.swift
//  Brands-RxSwift
//
//  Created by Ahmed Fathy on 08/12/2021.
//

import UIKit

class PhoneDetailsViewController: UIViewController {


    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Probeties
    //----------------------------------------------------------------------------------------------------------------
    
    private var viewModel: PhoneDetailViewModel!
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  IbOutlet
    //----------------------------------------------------------------------------------------------------------------
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleBrandsLabel: UILabel!
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Init
    //----------------------------------------------------------------------------------------------------------------
    init(with viewModel: PhoneDetailViewModel = PhoneDetailViewModel()){
        super.init(nibName: "PhoneDetailsViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    deinit {
        print("De init")
        viewModel.didFinishDeinit()
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Lyfe Cycle
    //----------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchDataAPI()
        
    }


    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Helper functions
    //----------------------------------------------------------------------------------------------------------------
    
    
    
}
