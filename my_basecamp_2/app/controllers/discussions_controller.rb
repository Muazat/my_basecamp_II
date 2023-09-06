class DiscussionsController < ApplicationController
    before_action :authenticate_user! 
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    
    def new
        @project = current_user.projects.find(params[:project_id])
        
        @discussion = Discussion.new
    end
    
    def create  
        @project = Project.find(params[:project_id])
        @discussion= @project.discussions.create(discussion_params)

        if @discussion.save
            redirect_to project_path(params[:project_id]), notice: "Discussion saved"

        else
            redirect_to project_path(params[:project_id]), alert: "Discussion not saved"
        end
    end

    def edit
        @project = Project.find(params[:project_id])
        @discussion = Discussion.find(params[:id])
    end

    def update
        #@project = current_user.projects.find(params[:project_id])
        @discussion = Discussion.find(params[:id])

        if @discussion.update(discussion_params)
          #flash[:success] = "project was successfully updated"
          redirect_to project_path(params[:project_id]), notice: "Discussion was successfully updated"
        else
          render 'edit', alert: "Not saved"
        end
    end

    def destroy
        @discussion = Discussion.find(params[:id])
        if @discussion.destroy
            redirect_to project_path(params[:project_id]), notice: "Discussion was successfully deleted."
        else
            redirect_to project_path(params[:project_id]), notice: "Something went wrong, not deleted"
        end
    end


    private
    def discussion_params
        params.require(:discussion).permit(:details)
    end
    def record_not_found
      redirect_to projects_path, alert: "Project not found"
    end
    
end