class User_InfoController < ApplicationController

def show
	@user_info = User_Info.find(params[:id])
end

def create
	@user = User_Info.create(params[:user])
end

end