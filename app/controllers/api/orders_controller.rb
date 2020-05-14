class Api::OrdersController < ApplicationController
  def create
    order = Order.create
    order.order_items.create(product_id: params[:product_id])
    render json: create_json_response(order)
  end

  def update
    order = Order.find(params[:id])
    if params[:activity]
      payment_status = perform_stripe_payment
      if payment_status == true
        order.update(finalized: true)
        render json: { paid: true, message: "Your order will be ready in 30 minutes" }
      else
        binding.pry
      end
    else
      product = Product.find(params[:product_id])
      order.order_items.create(product: product)
      render json: create_json_response(order)
    end
  end

  private

  def perform_stripe_payment
    order = Order.find(params[:id])
    customer = Stripe::Customer.create(
      email: params[:email],
      source: params[:stripeToken],
      description: 'slowfood client'
    ) 
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: order.order_total.to_i * 100,
      currency: 'sek'
    )
    charge.paid
  end

  def create_json_response(order)
    json = { order: OrderSerializer.new(order) }
    json.merge!(message: "The product has been added to your order")
  end
end
