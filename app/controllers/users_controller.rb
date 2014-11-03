class UsersController < ApplicationController
	
	before_filter :cors_preflight_check
	after_filter :cors_set_access_control_headers

  # For all responses in this controller, return the CORS access control headers.
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.

  def cors_preflight_check
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
    headers['Access-Control-Max-Age'] = '1728000'
  end

  def index
    @users = User.all

    respond_to do |format|
      format.json { render :json => @users }
    end	
end
	
	
##################################################### 
##### 			   Users Controller	            ##### 
##################################################### 

##################################################### 
#  				HTTP Request Methods 				#
##################################################### 
  
#######       Returns a list of all Users     #######
 
 # GET /users
  # GET /users.json
  
  def index
    @users = User.all
    render json: @users
  end
  
##################################################### 
 
#####   Returns the user with the specific ID   #####

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    render json: @user
  end

##################################################### 

##  Creates a new user with data in the POST body  ##

  # POST /users
  # POST /users.json
  
  def create
    @user = User.new(user_params(params))

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  
#####################################################

##    Updates a user with data in the PUT body     ##

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    if @user.update(user_params(params))
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  
#####################################################

##     Deletes the user with the specific ID       ##

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    head :no_content
  end

#####################################################

##   Returns a list of specified user's splatts    ##

  # GET /users/splatts/1
  # GET /users/splatts/1.json

def splatts 
	@user = User.find(params[:id])

	render json: @user.splatts
	end	
	
#####################################################

##    Returns the specified user's "news feed"     ##

  # GET /users/splatts_feed/1
	
def splatts_feed
	@feed = Splatt.find_by_sql("SELECT splatts.user_id, splatts.body, splatts.created_at FROM splatts JOIN follows ON follows.followed_id = splatts.user_id WHERE follows.follower_id = #{params[:id]} ORDER BY splatts.created_at")
	
	render json: @feed
end

#####################################################

## Creates a follower/followed rel between users   ##

  #POST /users/follows

def add_follows
	#params[:id] is user who follows 
	#params[:follows_id] is user to be followed
	
	#make follower
	@follower = User.find(params[:id])
	
	#make followed
	@followed = User.find(params[:follows_id])
	
	if 
		@follower.follows << @followed
		head :no_content
	else
		render json: @follower.errors, status: :unprocessable_entity
	end
end

#####################################################

## Returns a list of the users followed by the user ##
	
  #GET /users/follow/[:id]
	
def show_follows
	@user = User.find(params[:id])

	render json: @user.follows
	end	
	
#####################################################

## Returns a list of the users follow the specified user ##

  #GET /users/follower/[:id]

def show_followers
	@user = User.find(params[:id])
	
	render json: @user.followed_by
	end
	
#####################################################

## causes user with id1 to unfollow the user with id2 ##

	#DELETE

def delete_follows

	@follower = User.find(params[:id])
	@followed = User.find(params[:follows_id])

	@follower.follows.delete(@followed)
		head :no_content
		
	end		
	
#####################################################

##################################################### 
#  			     	Private Methods 				#
##################################################### 

private

	def user_params(params)
		params.permit( :email, :password, :name, :blurb)
	end
	
	def set_headers
		headers['Access-Control-Allow-Origin'] = '*';
	end
	
end
