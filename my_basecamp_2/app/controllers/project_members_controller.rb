class ProjectMembersController < ApplicationController
    before_action :authenticate_user!
    
    def show
        @projectmember = ProjectMember.find(params[:id])
    end

    def member
        @project = Project.find(params[:project_id]) #get the projects with an id
        @projectmembers = @project.project_members.all #get the users(id) of users on the project
        @my_users = {}
        @projectmembers.each do |member| #loop 
            user_details = []
            user = User.find(member.user_id) #use the user_id to get the details from the User model
            user_details.push(user.email)
            name = "#{user.surname} #{user.firstname}"
            user_details.push(name)
            #puts member.id
            @my_users[member.id] = user_details #create a key:value pair for the hash @my_users
        end
        render 'projects/members'
    end
    

    def create
        #puts params.inspect
        @user = User.find_by(email: params[:project_member][:email])
        if @user
            @project = Project.find(params[:project_id])
            @projectmember = @project.project_members.build(user: @user, status: :member)

            if @projectmember.save
                redirect_to project_path(params[:project_id]), notice: "Member added"
            else
                redirect_to project_path(params[:project_id]), alert: "Member not added/ Already a member"
            end
           
        else 
            redirect_to project_path(params[:project_id]), alert: "User not found"
        end
    end

    def destroy
        @member = ProjectMember.find(params[:id])
        if @member.destroy
            redirect_to member_path(), notice: "member was successfully deleted."
        else
            
            redirect_to member_path(), alert: "Something went wrong, not deleted"
        end
        
    end

    def update
        @member = ProjectMember.find(params[:id])
        if @member
            if @member.status == 'admin'
                @member.update(status: 'member')
            else
                @member.update(status: 'admin')
            end
            redirect_to member_path, notice: "status successfully updated."
        else
             redirect_to member_path, notice: "status not updated."
        end            
    end  
end