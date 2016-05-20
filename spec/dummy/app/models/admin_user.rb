class AdminUser < ActiveRecord::Base
  include JobNotifier::Identifier

  identify_job_through :id, :email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
end
