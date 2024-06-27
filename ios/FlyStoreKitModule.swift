import ExpoModulesCore
import Foundation
import StoreKit

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
                        return
                    }
                    
                    Task {
                        do {
                            try await AppStore.showManageSubscriptions(in: windowScene)
                        } catch {
                            print("Failed to present manage subscriptions screen")
                        }
                    }
                }
            } else {
                print("iOS 15.0 or later is required")
            }
        }
        
        AsyncFunction("beginRefundRequest") { (productID: String) in
            if #available(iOS 15.0, *) {
                Task {
                    do {
                        let transactions = sortTransactionsByDate(transactions: await getTransactions(for: productID))
                        if let transaction = transactions.last {
                            guard let scene = await UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                                print("No active scene found")
                                return;
                            }
                            
                            try await transaction.beginRefundRequest(in: scene)
                        } else {
                            print("No transactions found for the product")
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
    }
}
