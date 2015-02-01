class Cart < ActiveRecord::Base
  belongs_to :User

  class << self # Class methods
    def addItem (cart_id, item_id)
    	item = Item.find(item_id)
    	if item.stock < 1
    		return -1
    	end

    	cart_item = CartItem.where(Cart_id: cart_id, Item_id: item_id)
		if cart_item.blank?
			CartItem.create(Cart_id: cart_id, Item_id: item_id, price: item.price, quantity: 1)
		else
			if item.stock < cart_item.first().quantity+1
				return -1
			else
				cart_item.first().update(quantity: cart_item.first().quantity+1)
			end
		end
		return 1
  	end

  	def removeItem (cart_item_id)
  		cart_item = CartItem.where(id: cart_item_id)
		if !cart_item.blank?
			cart_item.first().destroy
		end
	end

	def checkout (cart_id)
		cartitems = CartItem.where(Cart_id: cart_id)
		cartitems.each do |cartitem|
			item = Item.find(cartitem.Item_id)
			if item.stock - cartitem.quantity >= 0
				item.update(stock: item.stock - cartitem.quantity)
			else
				return -1
			end
		end
		cart = Cart.find(cart_id)
		tp = totalPrice(cart_id)
		cart.update(total: tp)
		cart.update(checkout_date: DateTime.now)
		return 1
	end

	def clearoutofstock (cart_id)
		cartitems = CartItem.where(Cart_id: cart_id)
		cartitems.each do |cartitem|
			item = Item.find(cartitem.Item_id)
			if item.stock - cartitem.quantity < 0
				cartitem.destroy
			end
		end

	end

	def orderhistory(user_id)
		carts = Cart.where(User_id: user_id).where.not(checkout_date: nil)
		orderhistory = []
		(0..carts.size-1).each do |i|

			cart_items = CartItem.where(Cart_id: carts[i].id).to_a
			items = []
			cart_items.each do |ci|
				item_instance = Item.find(ci.Item_id)

				item = []
				item << item_instance.name
				item << item_instance.price
				item << ci.quantity

				items << item
			end


			order_instance = []
			order_instance << items
			order_instance << carts[i].checkout_date
			order_instance << carts[i].total

			orderhistory << order_instance
		end
		return orderhistory
	end

	def empty? (cart_id)
		return CartItem.where(Cart_id: cart_id).to_a.blank?
	end

	def totalPrice (cart_id)
		cart_items = CartItem.where(Cart_id: cart_id)
		total = 0
		cart_items.each do |c|
			total += c.price*c.quantity
		end
		return total
	end
  end
end
