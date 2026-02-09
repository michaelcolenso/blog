class Subscription < ApplicationRecord
  # Associations
  belongs_to :user

  # Validations
  validates :plan, inclusion: { in: %w[free pro business] }
  validates :status, inclusion: { in: %w[active trialing past_due canceled incomplete] }

  # Scopes
  scope :active, -> { where(status: %w[active trialing]) }
  scope :pro, -> { where(plan: 'pro') }
  scope :business, -> { where(plan: 'business') }

  # Constants
  PLANS = {
    'free' => { name: 'Free', price: 0, features: ['Basic link page', 'LinkHub branding', 'Unlimited links'] },
    'pro' => { name: 'Pro', price: 9_00, features: ['Custom domain', 'Remove branding', 'Custom themes', 'Analytics', 'Priority support'] },
    'business' => { name: 'Business', price: 19_00, features: ['Everything in Pro', 'Team features', 'Advanced analytics', 'API access', 'White-label'] }
  }.freeze

  # Instance methods
  def active?
    status.in?(%w[active trialing])
  end

  def trialing?
    status == 'trialing' && trial_ends_at.present? && trial_ends_at > Time.current
  end

  def past_due?
    status == 'past_due'
  end

  def canceled?
    status == 'canceled'
  end

  def renews_at
    current_period_end
  end

  def plan_name
    PLANS.dig(plan, :name) || plan.titleize
  end

  def plan_price
    PLANS.dig(plan, :price) || 0
  end

  def plan_features
    PLANS.dig(plan, :features) || []
  end

  def cancel!
    update(status: 'canceled')
  end
end
