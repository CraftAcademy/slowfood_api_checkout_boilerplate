# frozen_string_literal: true

class Api::OrdersController < ApplicationController
  before_action :authenticate_user!
  def create
    product = Product.find_by(id: params[:product_id])
    order = current_user.orders.create
    order.items.create(product: product)
    if order.persisted?
      render json: {
        message: 'Product was successfully added to your order',
        order: order,
        items: order.products
      }, status: 201
    else
      render json: { message: 'Something went wrong...' }, status: 422
    end
  end

  def update
    order = Order.find(params[:id])
    product = Product.find(params[:product_id])
    new_item = order.items.create(product: product)
    if new_item.persisted?
      render json: {
        message: 'Product was successfully added to your order',
        order: order,
        items: order.products
      }, status: 201
    else
      render json: { message: 'Something went wrong...' }, status: 422
    end
  end
end
