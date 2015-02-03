class HomeController < ApplicationController
	before_action :authenticate_user!
	def index
		refreshcurrentcart
		refresh
	end

	def attemptcheckout
		if !Cart.empty?(current_user.Cart_id)
			refreshcartitems
			render 'app/views/home/checkout.html.erb'
			return
		end
		refreshcurrentcart
		refresh
	end

	def addtocart
		value = Cart.addItem(current_user.Cart_id, params[:item_id], params[:item_qty].to_i)
		if value == -1
			@items_list = Item.all();
			refreshcartitems
			flash.now[:alert] = "Out of stock!"
			render 'app/views/home/index.html.erb'
			return
		end
		refresh
	end

	def removefromcart
		Cart.removeItem(params[:cart_item_id])
		refresh
	end

	def checkout
		if !Cart.empty?(current_user.Cart_id)
			value = Cart.checkout(current_user.Cart_id)
			if value == -1
				@items_list = Item.all();
				refreshcartitems
				flash.now[:alert] = "Some items in your cart were already out of stock by the time you checked out! Cart cleared of items that are out of stock."
				render 'app/views/home/index.html.erb'
				return
			end
		end
		current_user.Cart_id = nil
		refreshcurrentcart
		refresh
	end

	def orderhistory
		o = Cart.orderhistory(current_user.id)
		if o != nil
			return o
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

	def refreshcurrentcart
		if current_user.Cart_id==nil
			@current_cart = Cart.create(User_id:current_user.id)
			current_user.update(Cart_id:@current_cart.id)
		else
			@current_cart = Cart.find(current_user.Cart_id)
		end
	end

	def refresh
		@items_list = Item.all();
		refreshcartitems
		render 'app/views/home/index.html.erb'
	end

	def get_cart_total_price
		if current_user.Cart_id!=nil
			return Cart.totalPrice(current_user.Cart_id)
		end
	end

	helper_method :get_cart_total_price, :orderhistory
end