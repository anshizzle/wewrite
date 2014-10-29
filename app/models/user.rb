# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  provider               :string(255)
#  uid                    :string(255)
#  name                   :string(255)
#

class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :omniauthable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
   	has_many :lines
   	has_and_belongs_to_many :stories, :foreign_key => :collaborator_id, :join_table => :collaborators_stories

   	def profile_image_uri(size = "mini")
  		# parse_encoded_uri(insecure_uri(profile_image_uri_https(size))) unless @attrs[:profile_image_url_https].nil?
  		self.profile_image_url.sub! "normal", size  unless self.profile_image_url.nil?
	end

	def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
		

	    user = User.where(:provider => auth.provider, :uid => auth.uid).first

	    if user

	      if user.profile_image_url != auth.extra.raw_info.profile_image_url 
			 user.update_attribute(:profile_image_url, auth.extra.raw_info.profile_image_url)
		  end

	      return user 

	    else
	      registered_user = User.where(:email => auth.uid + "@twitter.com").first

	      if registered_user

	        return registered_user
	      else

	        user = User.create(name:auth.extra.raw_info.name,
	                            provider:auth.provider, 
	                            profile_image_url:auth.extra.raw_info.profile_image_url,
	                            uid:auth.uid,
	                            email:auth.uid+"@twitter.com",
	                            password:Devise.friendly_token[0,20],
	                          )
          end
		end 
	  end

	  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
	    user = User.where(:provider => auth.provider, :uid => auth.uid).first
	    if user
	      return user
	    else
	      registered_user = User.where(:email => auth.info.email).first
	      if registered_user
	        return registered_user
	      else
	        user = User.create(name:auth.extra.raw_info.name,
	                            provider:auth.provider, 
	                            uid:auth.uid,
	                            email:auth.info.email,
	                            password:Devise.friendly_token[0,20],
	                          )
      end   
     end
 end
end
