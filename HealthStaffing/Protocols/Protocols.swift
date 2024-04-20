//
//  Protocols.swift
//  HealthStaffing
//
//  Created by CTS on 31/01/24.
//

import Foundation

//protocol ProductCellDelegate {
//    func onClickWishlist(cell: ProductCollCell)
//}
//
//protocol productCelllDelegate {
//    func onClickRemoveWishList(cell: ProductCollCell)
//}
//
//protocol ShippingMethodCellDelegate {
//    func onClickEdit(cell: ShippingMethodCell)
//}
//
//protocol WishlistTableCellDelegate {
//    func onClickRemoveFromWishlist(productID: String)
//    func onClickAddToCart(productID: Int, userID: Int, quantity: Int)
//}
//
//protocol CartTableCellDelegate {
//    func onClickRemoveItem(cartKey: String)
//    func onClickQuantity(cartItem: CartItem, quantity: Int)
//}
//
//protocol AddressesTableCellDelegate {
//    func onClickEdit(address: AddressesData)
//    func onClickDelete(address: AddressesData)
//}
//
//protocol OngoingOrderCellDelegate {
//    func onClickProduct(productID: Int)
//    func onClickCancel(cell: OngoingOrderCell)
//    func onClickTrack(cell: OngoingOrderCell)
//}

protocol PastOrderCellDelegate {
    func onClickProduct(productID: Int)
}

protocol FAQHeaderCellDelegate {
    func onClickHeaderView(index: Int)
}

protocol HealthStaffingError: Error{}

protocol CustomSegmentedControlDelegate:class {
    func change(to index:Int)
}


//protocol HamptonError: Error{}
//
//protocol CustomSegmentedControlDelegate:class {
//    func change(to index:Int)
//}

