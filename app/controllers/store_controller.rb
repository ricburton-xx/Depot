class StoreController < ApplicationController
  def index
    @products = Product.find_products_for_sale
    @cart = find_cart
    @count = increment_count
    @count_min_five = true if @count > 5
  end
  
  def increment_count
    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end
  end
  
  def add_to_cart
    session[:counter] = 0
    product = Product.find(params[:id])
    @cart = find_cart
    @cart.add_product(product)
    redirect_to_index
  rescue
    logger.error("I'm sorry you've tried to add a product that's not there #{params[:id]}")
    redirect_to_index("Invalid product")
  end
  
  def empty_cart
    session[:cart] = nil
    redirect_to_index("Empty Cart!")
  end
  
  def back_to_store
    redirect_to :action => 'index'
  end

private
  def redirect_to_index(msg = nil)
    flash[:notice] = msg if msg
    redirect_to :action => 'index'
  end

  def find_cart
    session[:cart]  ||= Cart.new
  end
end
