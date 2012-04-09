class TicketsController < ApplicationController
#authentication of users
before_filter :authenticate_user!, :except => [:index, :show]
#DRYactions
before_filter :find_project
before_filter :find_ticket, :only => [:show,
				      :edit,
				      :update,
                                      :destroy]
                                     
def new
	@ticket = @project.tickets.build	
end

def create
	@ticket = @project.tickets.build(params[:ticket].merge!(:user => current_user))
           	if @ticket.save
			flash[:notice] = "Ticket has been created."
			redirect_to [@project, @ticket]
		else
			flash[:alert] = "Ticket has not been created."
			render :action => "new"
		end
end

def show
	#empty because of find_ticket in before_filter
end

def edit
	#empty because of find_ticket in before_filter
end

def update
	#empty because of find_ticket in before_filter		
		if @ticket.update_attributes(params[:ticket])
			flash[:notice] = "Ticket has been updated."
			redirect_to [@project, @ticket]
		else
			flash[:alert] = "Ticket has not been updated."
			render :action => "edit"
		end
end

def destroy
     	#empty because of find_ticket in before_filter
		@ticket.destroy
			flash[:notice] = "Ticket has been deleted."
		redirect_to @project
end


private 

def find_project
        @project = Project.find(params[:project_id])
end

def find_ticket
	@ticket = @project.tickets.find(params[:id])
end
#end for class ending
end

