require_relative './part_1_solution.rb'
require 'pry'


def apply_coupons(cart, coupons)
  coupons.each do |coupon_hash|
      
    cart_item = find_item_by_name_in_collection(coupon_hash[:item], cart)
    
      if cart_item && cart_item[:count] >= coupon_hash[:num]

          cart_item[:count] = cart_item[:count] - coupon_hash[:num]
  
          cart << {
          :item => cart_item[:item] + " W/COUPON",
          :price => coupon_hash[:cost] / coupon_hash[:num],
          :clearance => cart_item[:clearance],
          :count => coupon_hash[:num] }
      end 
  end
cart
end


def apply_clearance(cart)
  cart.each do |item|
  
    if item[:clearance] == TRUE
      discount = item[:price] * (20.to_f/100)
      item[:price] = item[:price] - discount.round(2)
    end
  end
cart
end


def checkout(cart, coupons)

  consolidated_cart = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(coupons_applied)

  total = 0
  i = 0 
    while i < final_cart.length
      total += final_cart[i][:count] * final_cart[i][:price]
    i += 1 
    end
    
    if total > 100
      store_deal = total*(10.to_f/100)
      total = total - store_deal.round(2)
    end
  return total
end