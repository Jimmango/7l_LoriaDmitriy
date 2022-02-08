import UIKit

//  1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.

//  2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.


enum ShopBuyError: Error {
    case wrongProductName
    case outOfQuantity
    case insufficientFunds
}

struct Item {
    var price: Int
    var quantity: Int
    var product: Goods
}

struct Goods {
    let name: String
}

class Shop {
    var goods = ["Морковь": Item(price: 80, quantity: 10, product: Goods(name: "Морковь")), "Сметана": Item(price: 90, quantity: 10, product: Goods(name: "Сметана")),
                 "Бананы": Item(price: 120, quantity: 20, product: Goods(name: "Бананы")),
                 "Хлеб": Item(price: 60, quantity: 5, product: Goods(name: "Хлеб")),
                 "Молоко": Item(price: 75, quantity: 0, product: Goods(name: "Молоко")),
                 "Икра красная": Item(price: 350, quantity: 12, product: Goods(name: "Икра красная"))
    ]
    
    var amountOfMoney = 150
    
    func buy(name: String) throws -> Goods {
        guard let item = goods[name] else {
            throw ShopBuyError.wrongProductName
        }
        
        guard item.price <= amountOfMoney else {
            throw ShopBuyError.insufficientFunds
        }
        
        guard item.quantity > 0 else {
            throw ShopBuyError.outOfQuantity
        }
        
        amountOfMoney -= item.price
        var newItem = item
        newItem.quantity -= 1
        return newItem.product
    }
    
    func averageGoodsCost() -> Int {
        guard goods.count > 1 else {
            return 0
        }
        var totalCost = 0
        for good in goods.values {
            totalCost += good.price
        }
        return totalCost / goods.count
    }
}

do {
    try shop.buy(name: "Бананы")
} catch ShopBuyError.insufficientFunds {
    print("Недостаточно средсв")
} catch ShopBuyError.outOfQuantity {
    print("Нет в наличии")
} catch ShopBuyError.wrongProductName {
    print("Не верное название продукта")
} catch let error {
    print(error.localizedDescription)
}

let buy1 = try? shop.buy(name: "Молоко")

try? shop.buy(name: "Арбуз")

try? shop.buy(name: "Икра красная")

let shop = Shop()
shop.averageGoodsCost()
