class Api::V1::GoogleUsersController < ApiController


  def create
    response = authenticate_user(oauth_params[:email])
    render json: response[:json], status: response[:status]
  end

  private

  def oauth_params
    params.permit(:first_name, :last_name, :email, :password, :district_id, :username)
  end

  def all_required?
    oauth_params.keys.count == 6
  end

end

private

def authenticate_user(email)
  user = User.find_by_email(email)
  if user.nil? && all_required?
    user = User.create(oauth_params)
    status = 200
  elsif user && !(user.authenticate(oauth_params[:password]))
    status = 400
    user = {message: 'Incorrect login method!'}
  elsif !user && !(all_required?)
    user = {message: 'Incorrect parameters given!'}
    status = 400
  end
  {json: user, status: status}
end
