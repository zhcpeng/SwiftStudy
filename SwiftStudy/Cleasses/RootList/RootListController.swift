//
//  RootListController.swift
//  Swift3
//
//  Created by zhcpeng on 16/5/27.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

import UIKit

class RootListController: UITableViewController {

	var itemList: [AnyClass] = []

	override func viewDidLoad() {
		super.viewDidLoad()
        
        itemList.append(CanMoveTableViewController.self)
        itemList.append(ScrollViewController.self)
        itemList.append(GradientColorViewController.self)
        itemList.append(UIImageViewCategory.self)
        itemList.append(YYLabelViewController.self)
        itemList.append(AssetsLibraryViewController.self)
        itemList.append(OrientationViewController.self)
        itemList.append(CallPhoneViewController.self)
        itemList.append(PhotoBrowerViewController.self)
        itemList.append(ScrollTextViewController.self)
        itemList.append(SectionTableViewController.self)
        itemList.append(StretchViewController.self)
        itemList.append(RTLabelViewController.self)
        itemList.append(ImageBrowerViewController.self)
        itemList.append(UIFirstViewController.self)
        itemList.append(SelectedCollectionViewController.self)
        itemList.append(UIPopWindowViewController.self)
        itemList.append(GIFViewController.self)
        itemList.append(MBProgressHUDViewController.self)
        itemList.append(RegularViewController.self)
        itemList.append(ImageTransitionViewController.self)
        itemList.append(CycleViewController.self)
        itemList.append(CALayerViewController.self)
        itemList.append(XButtonViewController.self)
        itemList.append(PhotosAlbumViewController.self)
        itemList.append(PhotosAlbumViewController1.self)
        itemList.append(PhotosAlbumViewController2.self)
        itemList.append(AVCaptureViewController.self)
        itemList.append(ViewAnimateViewController.self)
        itemList.append(TreeViewController.self)
        itemList.append(MemoryGraphViewController.self)
        itemList.append(TimeAlertViewController.self)
        itemList.append(InsertTableViewController.self)
        itemList.append(RadarChartViewController.self)
        itemList.append(CutImageViewController.self)
        itemList.append(PerformanceMonitorViewController.self)
        itemList.append(NameSpaceViewController.self)
        itemList.append(SingletonViewController.self)
        itemList.append(TouchMoveViewController.self)
        itemList.append(TaxViewController.self)
        itemList.append(NAvigationBarViewController.self)
        itemList.append(TempViewController.self)
        itemList.append(CellDidEndDispalyViewController.self)
        itemList.append(KuGouViewController.self)
        
        
//        itemList.append(DownloadListViewController.self)
//        itemList.append(LocalImageBrowerViewController.self)
//        itemList.append(CopyImageViewController.self)

        itemList = itemList.reversed()

		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemList.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
		cell.textLabel?.text = NSStringFromClass(itemList[indexPath.row])
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if (itemList[indexPath.row]).isKind(UIViewController.Type) {
//
//        }
        if let c = itemList[indexPath.row] as? UIViewController.Type {
            navigationController?.pushViewController(c.init(), animated: true);
        }
//        if let vc = itemList[indexPath.row].init() as? UIViewController {
//            navigationController?.pushViewController(vc, animated: true);
//        }
        
//        if let any = NSClassFromString(itemList[indexPath.row]) as? UIViewController.Type {
//            let vc = any.init()
//
////            let tration = CATransition()
////            tration.duration = 1
////            tration.type = kCATransitionFade
////            navigationController?.view.layer.add(tration, forKey: "animation")
//
//            navigationController?.pushViewController(vc, animated: true);
//        }
	}

}
