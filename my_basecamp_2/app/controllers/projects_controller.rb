class ProjectsController < ApplicationController
    before_action :authenticate_user!

    def index
        if current_user.status == "administrator"
            @projects = Project.all
        else
            @projects = current_user.projects
            @my_hash = {}
            if @projects
                @projects.each do |project|
                    @status = ProjectMember.find_by(user_id: current_user.id, project_id: project.id).status
                    @my_hash[project.id] = @status
                end
            end
        end
            render 'projects/projects'
    end
    
    def new
        @project = Project.new
        #render 'projects/new'
    end

    def create
        @project = Project.create(project_params)

        #adding the creator to the ProjectMember table as an admin
        if @project.save
            ProjectMember.create(user_id: current_user.id, project_id: @project.id, status: 1)
            redirect_to projects_path, notice: "Project was successfully created."
        else
            redirect_to new_project_path, alert: "Form not completed"
        end         
    end
    
    def show
        #@project = current_user.projects.find(params[:id]) # retrieve project for the current user
        @project = Project.find(params[:id]) #get the project details
        @threads = @project.discussions # retrieve threads belonging to each project
        #getting the status of the user for the project
        #puts current_user.anAdmin
        if current_user.status == "user"
            @status = ProjectMember.find_by(user_id: current_user.id, project_id: @project.id).status
            puts @status
        end 
                
        @discussion = Discussion.new
        @opinion= Opinion.new 
        @projectMember = ProjectMember.new     
        render 'projects/show'
    end  

    def edit
        @project = Project.find(params[:id])
    end

    def update
        @project = current_user.projects.find(params[:id])
        if @project.update(project_params)
          redirect_to projects_path, notice: "project was successfully updated"
        else
          render 'edit', alert: "Not saved"
        end
    end

    def attach
        puts #{params}
        @project = Project.find(params[:id])
        @project.files.attach(params[:project][:files])
        redirect_to project_path, notice: "File was successfully updated"
    end
    

    def destroy

        @project = Project.find(params[:id])
        @project.files.purge
        if @project.destroy
            redirect_to projects_url, notice: "project was successfully deleted."
        else
            
            redirect_to projects_url, alert: "Something went wrong, not deleted"
        end
    end

    private
    
    def project_params
        params.require(:project).permit(:title, :description, :created_by, files: [])
    end
    
end
