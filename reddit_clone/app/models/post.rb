class Post < ApplicationRecord
    validates :title, presence: true 
    validates :author_id, presence: true, uniqueness: true

    belongs_to :author,
    foreign_key: :author_id,
    class_name: :User

    has_many :subs,
    through: :post_subs,
    source: :sub

    has_many :post_subs,
    inverse_of: :post,
    foreign_key: :post_id,
    class_name: :PostSub
end
