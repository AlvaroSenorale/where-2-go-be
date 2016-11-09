class TickantelController < ApplicationController

  def index
    @music = TickAntelEntity.where(entity_type: 2)  
    @theater = TickAntelEntity.where(entity_type: 1)
  end
end
