class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_one :page, dependent: :destroy
  has_one :subscription, dependent: :destroy

  # Callbacks
  after_create :create_default_page
  after_create :create_free_subscription

  # Subscription helpers
  def pro?
    subscription&.plan == 'pro' && subscription&.active?
  end

  def business?
    subscription&.plan == 'business' && subscription&.active?
  end

  def free?
    !pro? && !business?
  end

  private

  def create_default_page
    build_page(
      handle: "user#{id}",
      title: "My LinkHub",
      published: false,
      theme: 'default',
      views_count: 0
    ).save(validate: false)
  end

  def create_free_subscription
    build_subscription(
      plan: 'free',
      status: 'active'
    ).save
  end
end
