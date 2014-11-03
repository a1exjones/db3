class SplattsController < ApplicationController

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
    @splatts = Splatt.all

    respond_to do |format|
      format.json { render :json => @splatts }
    end	
end

##################################################### 
##### 			 Splatts Controller	            ##### 
##################################################### 


###             Returns all Splatts               ###

  # GET /splatts
  # GET /splatts.json
  
  def index
    @splatts = Splatt.all

    render json: @splatts
  end
  
##################################################### 

###   Returns the splatt with the specified ID    ###

  # GET /splatts/1
  # GET /splatts/1.json
  
  def show
    @splatt = Splatt.find(params[:id])

    render json: @splatt
  end
  
##################################################### 
 
### Creates a new splatt with data in the POST body ###

  # POST /splatts
  # POST /splatts.json
  
  def create
    @splatt = Splatt.new(splatts_params(params))

    if @splatt.save
      render json: @splatt, status: :created, location: @splatt
    else
      render json: @splatt.errors, status: :unprocessable_entity
    end
  end

##################################################### 

###   Deletes the splatt with the specified ID    ###

  # DELETE /splatts/1
  # DELETE /splatts/1.json
  def destroy
    @splatt = Splatt.find(params[:id])
    @splatt.destroy

    head :no_content
  end
  
##################################################### 

##################################################### 
#  			     	Private Methods 				#
##################################################### 

private

	def splatts_params(params)
		params.permit( :body, :user_id)
	end

end
