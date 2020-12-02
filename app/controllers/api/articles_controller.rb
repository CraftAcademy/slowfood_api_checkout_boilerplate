# frozen_string_literal: true

class Api::ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :is_user_subscriber?, only: [:create]

  def create
    article = Article.create(article_params)
    if article.persisted?
      render json: { message: 'Your article was successfully created' }, status: 201
    else
      render json: { message: 'Whoops something went wrong!' }
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end

  def is_user_subscriber?
    unless current_user.subscriber
      render json: { message: 'You are not authorized to do this' }, status: 401
    end
  end
end
