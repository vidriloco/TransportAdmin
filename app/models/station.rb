class Station < ActiveRecord::Base
  belongs_to :agrouper, :polymorphic => true
end
