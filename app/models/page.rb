class Page < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :title
  validates_uniqueness_of :title
  validates_uniqueness_of :permalink
  before_save :create_html_and_permalink 
  
  
  protected
    def create_html_and_permalink
      self.body_html = RedCloth.new( self.body ).to_html
      unless permalink.nil?
        self.permalink = ContentEditor::PermalinkFu.escape( self.title )
      end
    end
  
end
