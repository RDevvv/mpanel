class Newsletter < ActiveRecord::Base
  attr_accessible :newsletter_body

  validates_presence_of :newsletter_body

  before_save :escape_newsletter_body
  before_update :unescape_newsletter_body

  def escape_newsletter_body
    self.newsletter_body = CGI.escapeHTML self.newsletter_body
  end

  def unescape_newsletter_body
    self.newsletter_body = CGI.unescapeHTML self.newsletter_body
  end

end
