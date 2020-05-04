class PostSub < ApplicationRecord
    validates :sub, :post, presence: true


    belongs_to :sub,
    foreign_key: :sub_id,
    class_name: :Sub
    
    belongs_to :post,
    foreign_key: :post_id,
    class_name: :Post
end