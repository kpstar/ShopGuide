//
//  DetailViewController.swift
//  ShopGuide
//
//  Created by KpStar on 2/23/18.
//  Copyright © 2018 Australia. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController, UIScrollViewDelegate, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var bavarutton: UIButton!
    @IBOutlet weak var slashLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var btnStackView: UIStackView!
    
    
    var image = UIImage()
    var imgviewtwo: UIImageView!
    var index = Int()
    let back_images: [UIImage] = [
        UIImage(named: "find_store")!,
        UIImage(named: "ammentises")!,
        UIImage(named: "product_found")!,
        UIImage(named: "product_not_found")!,
        UIImage(named: "barcode")!,
        UIImage(named: "loyal_code")!,
        UIImage(named: "location")!,
        UIImage(named: "promotions")!,
        UIImage(named: "shopping")!,
        UIImage(named: "receipts")!,
        UIImage(named: "scanned_barcode")!,
    ]
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    let user_data = [
        "21/09/2016   Ballarat    $24.56",
        "15/11/2016   Bendigo    $134.94",
        "29/12/2016   Ballarat    $15.24",
        "02/01/2017   Geelong    $264.59",
        "18/01/2017   Ballarat    $98.46",
        "29/12/2017   Sale        $24.15",
        "08/01/2018   Nott.Hill    $2.97",
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.init(red: 13/255.0, green: 82/255.0, blue: 87/255.0, alpha: 1)
        let search_bar = UISearchBar(frame: CGRect(x: 5, y: 100, width: self.view.frame.size.width-10, height: 50))
        let tableView = UITableView(frame: CGRect(x: 5, y: 100, width: self.view.frame.size.width-10, height: self.view.frame.size.height-100))
        imgviewtwo = UIImageView(frame: CGRect(x: 5, y: 160, width: self.view.frame.size.width-10, height: self.view.frame.size.height-160))
        imgviewtwo.image = UIImage(named: "promolog")
        imgviewtwo.contentMode = UIViewContentMode.scaleAspectFit
        tableView.backgroundColor = UIColor.clear
        imgImage.isHidden = true
        imgviewtwo.isHidden = true
        btnStackView.isHidden = true
        
        switch(index){
        case 0:
            titleLabel.text = "Where is it?"
            self.view.addSubview(search_bar)
            imgviewtwo.isHidden = false
            self.view.addSubview(imgviewtwo)
            search_bar.delegate = self
            break
        case 1:
            titleLabel.text = "Price?"
            captureSession = AVCaptureSession()
            
            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
            let videoInput: AVCaptureDeviceInput
            
            do {
                videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            } catch {
                return
            }
            
            if (captureSession.canAddInput(videoInput)) {
                captureSession.addInput(videoInput)
            } else {
                failed()
                return
            }
            
            let metadataOutput = AVCaptureMetadataOutput()
            
            if (captureSession.canAddOutput(metadataOutput)) {
                captureSession.addOutput(metadataOutput)
                
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
            } else {
                failed()
                return
            }
            
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = CGRect(x: 5.0, y: 55.0, width: self.view.frame.size.width-10, height: self.view.frame.size.height - 255)
            previewLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(previewLayer)
            
            let barcodeView = UIImageView(image: UIImage(named: "scan_barcode"))
            barcodeView.frame = CGRect(x: (self.view.frame.size.width-150)/2.0, y: self.view.frame.size.height-180, width: 150.0, height: 70.0)
            self.view.addSubview(barcodeView)
            
            captureSession.startRunning()
            
            break
        case 3:
            titleLabel.text = "Loyalty Code"
            imgImage.isHidden = false
            print(imgImage.frame.size.width)
            print(imgImage.frame.size.height)
            imgImage.image = back_images[5]
            break
        case 8:
            titleLabel.text = "Receipt"
            self.view.addSubview(tableView)
            tableView.delegate = self
            tableView.dataSource = self
            break
        case 5:
            titleLabel.text = "Shopping List"
//            imgImage.isHidden = false
//            imgImage.image = back_images[8]
            btnStackView.isHidden = false
            break
        case 4:
            imgImage.isHidden = false
            titleLabel.text = "Store Map"
            imgImage.image = back_images[0]
            self.scrollView.minimumZoomScale = 1.0
            self.scrollView.maximumZoomScale = 10.0
            break
        case 6:
            titleLabel.text = "Store Find"
            imgImage.isHidden = false
            imgImage.image = back_images[6]
            imgImage.contentMode = UIViewContentMode.scaleToFill
            break
        case 2:
            titleLabel.text = "Promotions"
            imgImage.isHidden = false
            imgImage.image = back_images[7]
            imgImage.contentMode = UIViewContentMode.scaleAspectFill
            break
        case 7:
            titleLabel.text = "Ammenitise?"
            imgImage.isHidden = false
            imgImage.image = back_images[1]
            break
        default:
            imgImage.image = back_images[0]
            break
        }
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
        dismiss(animated: true)
    }
    
    func found(code: String) {
        print(code)
        if code != "9310535466587" {
            captureSession.startRunning()
            return
        }
        let mainstoryboard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
        let desVC = mainstoryboard.instantiateViewController(withIdentifier: "MoreViewController") as! MoreViewController
        let temp = 1
        desVC.index = temp
        desVC.image = back_images[10]
        self.navigationController?.pushViewController(desVC, animated: true)
    }
    
    @IBAction func btnHammerTapped(_ sender: Any) {
        let mainstoryboard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
        let desVC = mainstoryboard.instantiateViewController(withIdentifier: "MoreViewController") as! MoreViewController
        let temp = 5
        desVC.index = temp
        desVC.image = back_images[2]
        self.navigationController?.pushViewController(desVC, animated: true)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imgImage
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        let mainstoryboard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
        let desVC = mainstoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(desVC, animated: true)
    }
    @IBAction func homeButtonTapped(_ sender: UIButton) {
        let mainstoryboard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
        let desVC = mainstoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(desVC, animated: true)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension DetailViewController: UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.imgImage.isHidden = false
        let startWord = searchBar.text
        searchBar.resignFirstResponder()
        if (startWord == "Hammer"){
            self.imgImage.image = back_images[2]
            self.imgviewtwo.isHidden = true
        } else {
            self.imgviewtwo.isHidden = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.resignFirstResponder()
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user_data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.frame.size.height-120)/7.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init()
        cell.textLabel?.text = user_data[indexPath.row]
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == user_data.count-1){
            let mainstoryboard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
            let desVC = mainstoryboard.instantiateViewController(withIdentifier: "MoreViewController") as! MoreViewController
            let temp = 8
            desVC.index = temp
            desVC.image = back_images[9]
            self.navigationController?.pushViewController(desVC, animated: true)
        } else {
            print("Not Working")
        }
    }
}

