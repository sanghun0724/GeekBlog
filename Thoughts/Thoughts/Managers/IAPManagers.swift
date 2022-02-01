//
//  IAPManagers.swift
//  Thoughts
//
//  Created by sangheon on 2022/01/26.
//

import Foundation
import Purchases
import StoreKit

final class IAPManagers {
    static let shared = IAPManagers()
    
    //RevenueCAt Shared Secret
    //f3c0839a369747149e8352ec56ab4eaa
    
    
    private init() {}
    
    func isPremium() -> Bool {
        return UserDefaults.standard.bool(forKey: "premium")
    }
    
    public func getSubscriptionStatus(completion: ((Bool) -> Void)?) {
        Purchases.shared.purchaserInfo { info, error in
            guard let entitlements = info?.entitlements,error == nil else {
                return
            }
            
            if entitlements.all["Premium"]?.isActive == true {
                print("Got updated status of subscribed")
                UserDefaults.standard.setValue(true, forKey: "premium")
                completion?(true)
            } else {
                print("Got updated status of NOT subscribed")
                UserDefaults.standard.setValue(false, forKey: "premium")
                completion?(false)
            }
        }
    }
    
    public func fetchPackages(completion:@escaping (Purchases.Package?) -> Void) {
        Purchases.shared.offerings { offerings, error in
            guard let package = offerings?.offering(identifier: "default")?.availablePackages.first,
            error == nil else {
                completion(nil)
                return
            }
            completion(package)
        }
    }
    
    public func subscribe(package:Purchases.Package, completion: @escaping (Bool) -> Void) {
        guard !isPremium() else {
            print("user already subscribe")
            completion(true)
            return
        }
        
        Purchases.shared.purchasePackage(package) { transaction, info, error, userCancelled in
            guard let transaction = transaction,
                  let entitlements = info?.entitlements,
                  error == nil,
                  !userCancelled else {
                      return
                  }
            switch transaction.transactionState {
                
            case .purchasing:
                print("purchasing")
            case .purchased:
                if entitlements.all["Premium"]?.isActive == true {
                    print("Purchased!")
                    UserDefaults.standard.setValue(true, forKey: "premium")
                    completion(true)
                } else {
                    print("Purchase failed ")
                    UserDefaults.standard.setValue(false, forKey: "premium")
                    completion(false)
                }
            case .failed:
                print("failed")
            case .restored:
                print("restore")
            case .deferred:
                print("defered")
            @unknown default:
                print("default case")
            }
        }
    }
    
    public func restorePurchases(completion: @escaping (Bool) -> Void) {
        Purchases.shared.restoreTransactions { info, error in
            guard let entitlements = info?.entitlements,error == nil else {
                return
            }
            
            if entitlements.all["Premium"]?.isActive == true {
                print("restored success")
                UserDefaults.standard.setValue(true, forKey: "premium")
                completion(true)
            } else {
                print("restored failed")
                UserDefaults.standard.setValue(false, forKey: "premium")
                completion(false)
            }
        }
    }
}
//MARK: -Track Post views
//(subscribe하면 기능 추가 해주는거)

extension IAPManagers {

}
