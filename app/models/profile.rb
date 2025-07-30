class Profile < ApplicationRecord
  validates :name, :url, :username, presence: true
  validates :name, uniqueness: true

  before_save :set_default_params

  scope :tag_like, ->(tag) { where("array_to_string(tags, '||') ILIKE ?", "%#{I18n.transliterate(tag)}%") }

  def set_default_params
    self.tags = build_tags(for_tags)
  end

  private

  def for_tags
    "#{name}|#{url}|#{username}|#{organization}|#{location}"
  end
end
