class PagesController < ApplicationController
  alias :authorized? :admin?

  before_filter :login_required, :only => [:index,:create]
  before_filter :find_or_create_page, :except => :index
  
  def index
    respond_to do |format|
      format.html do
        @pages = Page.paginate :page => params[:page], :per_page => 50, :order => "created_at"
        @pages_count = Page.count
      end
    end
    
  end
  
  def show
  end
  
  def create
    @page.attributes = params[:page]
    @page.save!
    respond_to do |format|
      format.html { redirect_to pages_path }
      format.xml { head :created, :location => formatted_page_url(:id => @page, :format => :xml) }
    end    
  end
  
  def update
    @page.update_attributes! params[:page]
    respond_to do |format|
      format.html { redirect_to pages_path }
      format.xml  { head 200 }
    end
  end  
  
  def publish
    @page.toggle!(:active)
    redirect_to pages_path
  end
  
  def destroy
    @page.destroy
    redirect_to pages_path
  end
  
  protected
    def find_or_create_page
      @page = Page.find(:first, :conditions => ['permalink=? and active=?',params[:permalink], true]) if params[:permalink]
      return unless @page.nil?
      @page = if params[:id]
        Page.find(params[:id])
      else
        Page.new( :user_id => current_user )
      end
      
    end
  
end
