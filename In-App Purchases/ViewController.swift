//
//  ViewController.swift
//  In-App Purchases
//
//  Created by Arpit iOS Dev. on 27/06/24.
//

import UIKit
import StoreKit

class ViewController: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    enum Product: String, CaseIterable {
        case gems = "com.plexustechnology.gems"
        case nonadspremium = "com.plexustechnology.premium"
        case monthlysubscription = "com.plexustechnology.monthly"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func buyGems(_ sender: Any) {
        if SKPaymentQueue.canMakePayments() {
            let set : Set<String> = [Product.gems.rawValue]
            
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate = self
            productRequest.start()
        }
    }
    
    @IBAction func buyPremium(_ sender: Any) {
        if SKPaymentQueue.canMakePayments() {
            let set : Set<String> = [Product.nonadspremium.rawValue]
            
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate = self
            productRequest.start()
        }
    }
    
    @IBAction func buyMonthlySubscription(_ sender: Any) {
        if SKPaymentQueue.canMakePayments() {
            let set : Set<String> = [Product.monthlysubscription.rawValue]
            
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate = self
            productRequest.start()
        }
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if let oProduct = response.products.first {
            print("Product is available")
            self.purcahse(aproduct: oProduct)
        } else {
            print("Product is not available")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
                
            case .purchasing:
                print("Customer is in the process of purchase")
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                print("purchased")
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                print("failed")
            case .restored:
                print("restore")
            case .deferred:
                print("deferred")
            @unknown default: break
                
            }
        }
    }
    
    func purcahse(aproduct: SKProduct) {
        let payment = SKPayment(product: aproduct)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(payment)
    }

}

