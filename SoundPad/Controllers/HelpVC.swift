//
//  HelpVC.swift
//  SoundPad
//
//  Created by Julian Silvestri on 2021-12-25.
//

import UIKit
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport
//import CoreData

class HelpVC: UIViewController, GADBannerViewDelegate  {

    @IBOutlet weak var deleteRecordingsBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        self.deleteRecordingsBtn.layer.cornerRadius = 8
        let bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.delegate = self
        bannerView.rootViewController = self
//        print("Google Mobile Ads SDK version: \(GADMobileAds.sharedInstance().sdkVersion)")
        addBannerViewToView(bannerView)
    }
    @IBAction func deleteBtnAction(_ sender: Any) {
        self.performSegue(withIdentifier: "delete", sender: self)
    }
    func addBannerViewToView(_ bannerView: GADBannerView) {
//        bannerView.frame = CGRect(x: 0, y: 0, width: 350, height: 50)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.adUnitID = "ca-app-pub-2779669386425011/6891293559"
        bannerView.load(GADRequest())
        bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(self.view.frame.size.width)
        view.addSubview(bannerView)
        view.addConstraints([
            NSLayoutConstraint(item: bannerView, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: bannerView,attribute: .centerX,relatedBy: .equal,toItem: self.view.safeAreaLayoutGuide,attribute: .centerX,multiplier: 1,constant: 0)])
     }
}
