class Post < ApplicationRecord
  validates :content, {presence: true,length: {maximum: 140}}
  validates :user_id, presence: true
  # インスタンスメソッドuserを定義してください
  def user
    # User.find_by(id: user_id)
    return User.find_by(id: self.user_id) 
    # でも可能。selfとは記述しているモデルそのものの事を言う。
  end
end
