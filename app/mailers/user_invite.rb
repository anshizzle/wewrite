class UserInvite < ActionMailer::Base
  default from: "from@example.com"

    # send a signup email to the user, pass in the user object that   contains the user's email address
	  def send_invite_email(user, email)
	    @user = user
	    mail( :to => email,
	    :subject => 'Come Write With Me!' )
	  end
	
end
