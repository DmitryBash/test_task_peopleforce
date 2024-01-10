class UsersController < ApiController
  def update
    user = User.find(params[:id])

    if user.update(user_params)
      render json: {
        user: user,
        dynamic_values: user.dynamic_values
      }
    else
      render json: "error"
    end
  end

  private

  def user_params
    params.require(:user)
      .permit(:name,
        dynamic_fields_attributes: [
          :id,
          dynamic_values_attributes: [
            :id,
            :_destroy,
            :name,
            :string_value,
            :number_value,
            :select_value
          ]
        ]
      )
  end
end
