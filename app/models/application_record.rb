class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def build_tags(elem, elem_tags = [])
    new_tags = format_word(elem).split("|")
    new_tags << elem_tags
    new_tags.flatten.uniq
  end

  def format_word(word)
    I18n.transliterate(word).downcase
  end
end
