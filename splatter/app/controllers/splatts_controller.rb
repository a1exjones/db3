class SplattsController < ApplicationController


def create
     @user = User.find(params[:user_id])
     splatt = Splatt.new({:body => params[:body]})
     if @user.splatts.push(splatt)
           render json: splatt, status: :created, location: @user
     else
           render json: @user.errors, status: :unprocessable_entity
     end
end

end