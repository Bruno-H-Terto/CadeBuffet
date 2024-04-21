class Buffets::BuffetController < ApplicationController
  before_action :authenticate_buffets_owner!, only: [:show, :new, :create]

  def show
  end

  def new
  end

  def create
  end

end