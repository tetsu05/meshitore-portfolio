class HomesController < ApplicationController
  def index
  end
  
  private

  # falseを返すようにオーバーライド
  def use_before_action?
    false
  end
end
