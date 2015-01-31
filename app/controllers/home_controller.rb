class HomeController < ApplicationController
	before_action :authenticate_user!
	def index
		refresh
		if current_user.Cart_id==nil
			@current_cart = Cart.create(User_id:current_user.id)
			current_user.update(Cart_id:@current_cart.id)
		else
			@current_cart = Cart.find(current_user.Cart_id)
		end
	end

	def addtocart
		cart_item = CartItem.where(Cart_id: current_user.Cart_id, Item_id: params[:item_id])
		if cart_item.blank?
			item = Item.find(params[:item_id])
			CartItem.create(Cart_id: current_user.Cart_id, Item_id: params[:item_id], price: item.price, quantity: 1)
		else
			cart_item.first().update(quantity: cart_item.first().quantity+1)
		end
		refresh
	end

	def removefromcart
		cart_item = CartItem.where(id: params[:cart_item_id])
		if !cart_item.blank?
			cart_item.first().destroy
			refresh
		end
	end

	def refreshcartitems
		@cart_items = CartItem.where(Cart_id: current_user.Cart_id)
		@cart_list = []
		@cart_items.each do |c|
			item = Item.where(id: c.Item_id)
			@cart_list << item.first()
		end
	end

	def refresh
		@items_list = Item.all();
		refreshcartitems
		render 'app/views/home/index.html.erb'
	end
end