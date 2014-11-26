class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  
  def index
    @orders = Order.all
    respond_with(@orders)
  end

  def show
    respond_with(@order)
  end

  def new
    if @cart.line_items.empty? 
      redirect_to index_url, notice: "Tu carrito se encuentra vacío"
      return
    end
    @order = Order.new
    #respond_with(@order)
  end

  def edit
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.agregar_productos_del_carrito_actual_a_esta_orden(@cart)
    respond_to do |format| 
      if @order.save
        Cart.destroy(session[:cart_id]) 
        session[:cart_id] = nil
        format.html { redirect_to index_url, 
          notice:'Gracias por tu compra :>' } 
        format.json { render action: 'show', status: :created, 
          location: @order } 
      else 
        format.html { render action: 'new' } 
        format.json { render json: @order.errors, 
          status: :unprocessable_entity } 
      end 
    end 
  end

  def update
    @order.update(order_params)
    respond_with(@order)
  end

  def destroy
    @order.destroy
    respond_with(@order)
  end
  
  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:address, :pay_type)
    end
end
