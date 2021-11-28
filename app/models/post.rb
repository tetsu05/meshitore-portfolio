class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, {presence: true, length: {maximum: 1000}}
  belongs_to :user
  attachment :cooking_image
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  #投稿と通知モデルの紐付け
  has_many :notifications, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def create_notification_by(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
        notification = current_user.active_notifications.new(
          post_id: id,
          visited_id: user_id,
          action: "like"
        )
        # 自分の投稿に対するいいねじゃない場合、かつバリデーションをクリアするとき
      if notification.visitor_id != notification.visited_id && notification.valid?
        notification.save
      end
    end
  end

  def create_notification_comment!(current_user, post_comment_id)
      # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
      temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
      temp_ids.each do |temp_id|
          save_notification_comment!(current_user, post_comment_id, temp_id['user_id'])
      end
      # まだ誰もコメントしていない場合は、投稿者に通知を送る
      save_notification_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, post_comment_id, visited_id)
      # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
      notification = current_user.active_notifications.new(
        post_id: id,
        post_comment_id: post_comment_id,
        visited_id: visited_id,
        action: 'comment'
      )
      # 自分の投稿に対するコメントの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
  end

end
