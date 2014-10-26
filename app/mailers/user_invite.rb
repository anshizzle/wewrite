class UserInvite < ActionMailer::Base
  default from: "from@example.com"

    # send a signup email to the user, pass in the user object that   contains the user's email address
	  def send_invite_email(user, line, email)
	    @user = user
	    @line = line
	    mail( :to => email,
	    :subject => 'Come Write With Me!' )
	  end
	
end
