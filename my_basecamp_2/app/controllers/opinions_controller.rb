class OpinionsController < ApplicationController
    before_action :authenticate_user! 
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def new   
        @message = Opinion.new
    end
    
    def create
        @project = Project.find(params[:project_id])
        @discussion = @project.discussions.find(params[:discussion_id])
        @opinion= @discussion.opinions.create(opinion_params)

        if @opinion.save
            redirect_to project_path(params[:project_id]), notice: "Comment saved"
        else
            redirect_to project_path(params[:project_id]), alert: "Comment not saved"
        end
    end

    def edit
        @project = Project.find(params[:project_id])
        @discussion = @project.discussions.find(params[:discussion_id])
        @opinion = @discussion.opinions.find(params[:id])
    end
    

    def update
       
        @opinion = Opinion.find(params[:id])

        if @opinion.update(opinion_params)
            redirect_to project_path(params[:project_id]), notice: "Comment updated"
        else
            redirect_to project_path(params[:project_id]), alert: "Comment not saved"
        end
    end

    def destroy
        @opinion = Opinion.find(params[:id])
        if @opinion.destroy
            #puts params[:id]
            #puts params[:project_id]
            #puts params[:stream_id]
            redirect_to project_path(params[:project_id]), notice: "Comment deleted"
        else
            redirect_to project_path(params[:project_id]), alert: "Comment not deleted"
        end
    end
    
    private
    
    def opinion_params
        params[:opinion][:comment_by] = "#{current_user.firstname} #{current_user.surname}"
        params.require(:opinion).permit(:details, :comment_by)
    end
end