# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def show
        @user = User.where(id: current_api_v1_user.id)
      end
    end
  end
end
