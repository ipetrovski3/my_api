# frozen_string_literal: true

module Api
  module V1
    class FarmsController < ApplicationController
      before_action :authenticate_api_v1_user!
      before_action :set_farm, only: [:show, :update, :destroy]

      def index
        @farms = ::FarmSortingQuery.new(params_to_options, current_api_v1_user).call
      end

      def show
        render json: @farm
      end

      def create
        @farm = current_api_v1_user.farms.new(farm_params)
        if @farm.save
          render json: @farm, status: :created
        else
          render json: { message: @farm.errors.messages }, status: :unprocessable_entity
        end
      end

      def update
        if current_api_v1_user.id === @farm.user_id
          if @farm.update(farm_params)
            render json: @farm, status: :ok
          else
            render json: { message: farm.errors.messages }, status: :unprocessable_entity
          end
        end
      end

      def destroy
        if @farm.delete
          render json: { message: 'succesfully deleted farm' }, status: :ok
        else
          render :nothing, status: :unprocessable_entity
        end
      end

    private

      def farm_params
        params.require(:farm).permit(:address, :size, :farm_yield, :user_id)
      end

      def set_farm
        @farm = Farm.find(params[:id])
      end

      def params_to_options
        @options = {
          size: params[:size],
          farm_yield: params[:farm_yield],
          distance: params[:distance],
          outliers: params[:outliers]
        }
      end
    end
  end
end
