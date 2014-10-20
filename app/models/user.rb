class User < Hashie::Dash

##############################################
##### 		Users Class		 ##### 
##############################################

	property :email
	property :name
	property :password
	property :blurb
	property :follows
	property :followers

end
