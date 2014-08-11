class SplattsController < ApplicationController

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
    @splatt = Splatt.new(splatts_params(params[:splatt]))

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
