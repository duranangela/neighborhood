class Api::V1::ProjectsController < ApiController

  def index
    render json: Project.all
  end

  def update
    project = Project.find(params[:id])
    new_resources = find_or_create_resources(project)
    if resources_valid?(new_resources) && project && project.update(project_params)
      render json: {message: "Successfully Updated #{project.title}!"}
    else
      render json: {message: "Invalid Input. Try Again"} , status: 400
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :photo)
  end

  def resources
    return params[:project][:resources] if params[:project][:resources]
    []
  end

  def find_or_create_resources(project)
    resources.select do |resource|
      if resource['id'] && (resource['name'] || resource['status']) && project
        project.resources.find(resource[:id]).update(resource.permit(:name, :status))
      elsif resource['name'] && resource['id'].nil? && resource['status'].nil? && project
        project.resources.create(resource.permit(:name, :status))
      end
    end
  end

  def resources_valid?(new_resources)
    resources.length == new_resources.length
  end
end
