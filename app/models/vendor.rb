class Vendor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  has_many :categories, :through => :vendor_categories
  has_many :vendor_categories

  has_many :channels, :through => :vendor_channels
  has_many :vendor_channels

  has_many :companies, :through =>  :vendor_companies
  has_many :vendor_companies, dependent: :destroy

  has_attached_file :sample_photo, styles: {thumb: "100x100#", small: "300x300#", medium: "500x500#", large: "800x800#"}
  validates_attachment_content_type :sample_photo, content_type: ['image/jpeg', 'image/png', 'application/pdf']  

  def password_required?
    super if confirmed?
  end

  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

  after_create :send_admin_mail
  def send_admin_mail
    VendorMailer.send_admin_mail(self).deliver
  end
end
