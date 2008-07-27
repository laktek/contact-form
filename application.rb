require 'dm-validations'
#Model
class Contact
  include DataMapper::Resource
  
  property :id, Integer, :serial => true
  property :name, String
  property :email, String
  property :message, Text
  
  validates_present :name, :email
  validates_format :email, :as => :email_address
end

#Controller
class Contacts < Merb::Controller
  def _template_location(action, type = nil, controller = controller_name)
    controller == "layout" ? "layout.#{action}.#{type}" : "#{action}.#{type}"
  end

  def show
    @contact = Contact.new
    render
  end
  
  def create
    @contact = Contact.new(params[:contact])
    if @contact.valid?
      send_info
      render "Thanks for the info"
    else
      render :show
    end 
  end

private
  def send_info
    m = Merb::Mailer.new :to => 'lakshan@web2media.net',
                         :from => @contact.email,
                         :subject => 'Contact Form Results',
                         :text => "#{@contact.name} (#{@contact.email}) wrote : \n #{@contact.message}"
    m.deliver!
  end
end



