class HomeController < ApplicationController
    before_action :authenticate_user!, only: [:getUsers, :updateRole, :destroy]

    def index
        render 'devise/home/index'
    end


    def getUsers
        #puts current_user.status
        if current_user.status == "administrator"
            @users = User.all
            #puts @users
            render 'devise/home/users'
        else 
            redirect_to root_path
        end
    end

    def updateRole
        @user = User.find(params[:id])
        
        if @user.status == "administrator"
            #puts @user.anAdmin
            if  @user.update(status: "user")
                #puts User.find(params[:id])
                redirect_to allUser_path, notice: "User role updated."
            else
                redirect_to allUser_path, notice: "user role update failed"
            end
        else
            if  @user.update(status: "administrator")
                redirect_to allUser_path, notice: "User role updated."
            else
                  redirect_to allUser_path, notice: "User role update failed"
            end
        end
               
    end   

    def destroy
        @user = User.find(params[:id])
        if @user.destroy
            redirect_to allUser_path, notice: "user was successfully deleted."
        else
            redirect_to allUser_path, alert: 'Something went wrong'
        end
    end
end
