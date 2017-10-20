class AddReviewTextColum < ActiveRecord::Migration[5.1]

  def change
    add_column :reviews, :review_text, :text
  end
end
