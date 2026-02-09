class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :handle, use: :slugged

  # Associations
  belongs_to :user
  has_many :links, -> { order(position: :asc) }, dependent: :destroy
  has_many :clicks, dependent: :destroy

  # Validations
  validates :handle, presence: true, uniqueness: { case_sensitive: false },
            format: { with: /\A[a-zA-Z0-9_-]+\z/, message: "can only contain letters, numbers, underscores, and hyphens" },
            length: { minimum: 3, maximum: 30 }
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 500 }, allow_blank: true
  validates :theme, inclusion: { in: %w[default dark minimal professional] }

  # Callbacks
  before_validation :normalize_handle

  # Scopes
  scope :published, -> { where(published: true) }
  scope :popular, -> { order(views_count: :desc) }

  # Instance methods
  def increment_views!
    increment!(:views_count)
  end

  def can_customize_theme?
    user.pro? || user.business?
  end

  def can_use_custom_domain?
    user.business?
  end

  def public_url
    "#{handle}.linkhub.com"
  end

  private

  def normalize_handle
    self.handle = handle.to_s.downcase.strip if handle.present?
  end
end
