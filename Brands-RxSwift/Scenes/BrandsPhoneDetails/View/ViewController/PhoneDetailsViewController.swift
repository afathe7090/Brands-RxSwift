//
//  PhoneDetailsViewController.swift
//  Brands-RxSwift
//
//  Created by Ahmed Fathy on 08/12/2021.
//

import UIKit
import RxCocoa
import RxSwift

class PhoneDetailsViewController: UIViewController {


    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Probeties
    //----------------------------------------------------------------------------------------------------------------
    
    private var viewModel: PhoneDetailViewModel!
    private let bag = DisposeBag()
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  IbOutlet
    //----------------------------------------------------------------------------------------------------------------
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleBrandsLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var phoneNameLabel: UILabel!
    @IBOutlet weak var dimensionLabel: UILabel!
    @IBOutlet weak var osLabel: UILabel!
    @IBOutlet weak var storageLabel: UILabel!
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
        setCollectionView()
        collectionViewBinding()
        bindinngToSetElementsLabelOFViewController()
        
    }


    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Helper functions
    //----------------------------------------------------------------------------------------------------------------
    
    // collection View Adding Cell
    func setCollectionView(){
        collectionView.register(UINib(nibName: PhoneImagesCells.cellID, bundle: nil), forCellWithReuseIdentifier: PhoneImagesCells.cellID)
    }
    
    //set binding To CollectionViewCell
    func collectionViewBinding(){
        viewModel.imageCollection
            .bind(to: collectionView.rx.items(cellIdentifier: PhoneImagesCells.cellID, cellType: PhoneImagesCells.self)) { index , model , cell in
            cell.setUpCell(model)
        }.disposed(by: bag)
        
        viewModel.fetchDataAPI()
    }
    
    
    // binding to get data from Api and setLabels
    func bindinngToSetElementsLabelOFViewController(){
        viewModel.phoneDetail.subscribe(onNext: { data in
            self.titleBrandsLabel.text = data.brand
            self.phoneNameLabel.text = data.phone_name
            self.dimensionLabel.text = data.dimension
            self.releaseDateLabel.text = data.release_date
            self.osLabel.text = data.os
            self.storageLabel.text = data.storage
        }).disposed(by: bag)
    }
    
    
}
