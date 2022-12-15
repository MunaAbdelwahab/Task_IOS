//
//  ProductsVC.swift
//  task
//
//  Created by Muna Abdelwahab on 15/12/2022.
//

import UIKit
import Network

class ProductsVC: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    
    lazy var viewModel = {
        ProductsViewModel()
    }()
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")
    var noConnection = false

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
                self.noConnection = false
            } else {
                print("There's no internet connection.")
                self.noConnection = true
            }
        }
        monitor.start(queue: queue)
    }
    

    func initView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCell.nib, forCellWithReuseIdentifier: ProductCell.identifier)
    }

    func initViewModel() {
        viewModel.getProducts()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ProductsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if noConnection == true {
            return viewModel.productsL?.count ?? 0
        } else {
            return viewModel.productCellViewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else { fatalError("xib does not exists") }
        if noConnection == true {
            let product = viewModel.productsL?[indexPath.row]
            cell.imageIV.loadImageUsingCache(withUrl: product?.image ?? "")
            cell.imageHeight.constant = CGFloat(product?.imageH ?? 0)
            cell.imageWidth.constant = CGFloat(product?.imageW ?? 0)
            cell.descLabel.text = product?.desc
            cell.priceLabel.text = product?.price
        } else {
            let cellVM = viewModel.getCellViewModel(at: indexPath)
            cell.cellViewModel = cellVM
        }
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
        if noConnection == true {
            VC.productI = viewModel.productsL?[indexPath.row].image ?? ""
            VC.productD = viewModel.productsL?[indexPath.row].desc ?? ""
        } else {
            VC.productI = viewModel.products[indexPath.row].image.url
            VC.productD = viewModel.products[indexPath.row].productDescription
        }
        navigationController?.pushViewController(VC, animated: true)
    }
}

extension ProductsVC: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProductsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var screenHeight  = 0.0
        if noConnection == true {
            screenHeight = Double(viewModel.productsL?[indexPath.row].imageH ?? 0) + 170.0
        } else {
            let cellVM = viewModel.getCellViewModel(at: indexPath)
            screenHeight  = cellVM.imageHeight + 170.0
        }
        
        let numberOfItemsPerRow: CGFloat = 2.0
        let leftAndRightPaddings: CGFloat = 10.0
        
        let screenWidth  =  (collectionView.frame.width - leftAndRightPaddings) / numberOfItemsPerRow
        return CGSize(width: screenWidth, height: screenHeight)
    }
    
    // Distance Between Item Cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
