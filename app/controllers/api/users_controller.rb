class Api::UsersController < ApplicationController

    def index
        users = User.all

        render_records users, displayable_keys
    end

    def show
        user = User.find params[:id]

        render_response user, displayable_keys
    end

    def update
        user = User.find params[:id]
        user.assign_attributes user_params

        user.save ?
            render_204
            : render_error(user)
    end

    def destroy
        User.find(params[:id]).destroy

        render_204
    end

    def create
        user = User.new user_params

        user.save ?
            render_response(user, displayable_keys)
            : render_error(user)
    end

    private
        def user_params
            params.require(:user).permit :first_name, :last_name, :password, :username
        end

        def displayable_keys
            %w(first_name last_name username)
        end

end
