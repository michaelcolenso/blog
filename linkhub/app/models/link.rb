class Link < ApplicationRecord
  # Associations
  belongs_to :page
  has_many :clicks, dependent: :destroy

  # Validations
  validates :title, presence: true, length: { maximum: 100 }
  validates :url, presence: true,
            format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "must be a valid URL" }
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  # Callbacks
  before_create :set_position
  before_validation :normalize_url

  # Scopes
  scope :visible, -> { where(visible: true) }
  scope :ordered, -> { order(position: :asc) }

  # Instance methods
  def increment_clicks!
    increment!(:clicks_count)
  end

  def track_click!(request_data = {})
    clicks.create!(
      ip_address: request_data[:ip],
      user_agent: request_data[:user_agent],
      referrer: request_data[:referrer],
      clicked_at: Time.current
    )
    increment_clicks!
  end

  private

  def set_position
    self.position ||= page.links.maximum(:position).to_i + 1
  end

  def normalize_url
    return unless url.present?
    self.url = url.strip
    self.url = "https://#{url}" unless url.match?(/\Ahttps?:\/\//)
  end
end
