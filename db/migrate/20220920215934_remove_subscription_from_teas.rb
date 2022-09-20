class RemoveSubscriptionFromTeas < ActiveRecord::Migration[5.2]
  def change
    remove_reference :teas, :subscription, foreign_key: true
  end
end
