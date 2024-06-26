import ExpoModulesCore

public class FlyStoreKitModule: Module {
    
    @available(iOS 15.0, *)
    func getTransactions(for productIdentifier: String) async -> [Transaction] {
        var transactions: [Transaction] = []
        for await result in Transaction.all {
            if case .verified(let transaction) = result, transaction.productID == productIdentifier {
                transactions.append(transaction)
            }
        }
        return transactions
    }
    
    @available(iOS 15.0, *)
    func sortTransactionsByDate(transactions: [Transaction]) -> [Transaction] {
        return transactions.sorted { $0.purchaseDate < $1.purchaseDate }
    }
    
    
    public func definition() -> ModuleDefinition {
        
        Name("FlyStoreKit")
        
        AsyncFunction("showManageSubscriptions") { () in
            if #available(iOS 15.0, *) {
                DispatchQueue.main.async {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                        //                        rejecter("no_window_scene", "No active window scene found", nil)
                        return
                    }
                    
                    Task {
                        do {
                            try await AppStore.showManageSubscriptions(in: windowScene)
                            //                            resolver("Manage subscriptions screen presented successfully")
                        } catch {
                            //                            rejecter("show_manage_subscriptions_failed", "Failed to present manage subscriptions screen", error)
                        }
                    }
                }
            } else {
                //                rejecter("unsupported_version", "iOS 15.0 or later is required", nil)
            }
        }
        
        AsyncFunction("showManageSubscriptions") { (value: String) in
            if #available(iOS 15.0, *) {
                Task {
                    do {
                        print(productID)
                        let transactions = sortTransactionsByDate(transactions: await getTransactions(for: productID))
                        
                        // TODO Probably it should be not last transaction
                        if let transaction = transactions.last {
                            print(transaction)
                            // TODO Probably it is wrong scene implementation
                            guard let scene = await UIApplication.shared.connectedScenes.first as? UIWindowScene else {
//                                rejecter("no_active_scene", "No active scene found", nil)
                                return;
                            }
                            
                            let status = try await transaction.beginRefundRequest(in: scene)
                            
//                            switch status {
//                            case .success:
//                                resolver("Refund request submitted successfully")
//                            case .userCancelled:
//                                rejecter("canceled", "User cancelled the refund request", nil)
//                            @unknown default:
//                                rejecter("unknown_status", "Unknown status ", nil)
//                            }
                        } else {
//                            rejecter("no_transactions_found", "No transactions found for the product", nil)
                        }
                    } catch {
//                        rejecter("error", error.localizedDescription, error)
                    }
                }
            }
        }
        
    }
}
