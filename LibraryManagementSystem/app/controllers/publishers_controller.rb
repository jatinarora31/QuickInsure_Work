class PublishersController < ApplicationController
    skip_before_action :verify_authenticity_token

    def publisher_params
        params.require(:publisher).permit(:publisher_name, :nationality, :address)
    end

    def index
        publishers = Publisher.all
        render json: publishers
    end

    def show
        publisher = Publisher.find_by(id: params[:id])
        if publisher
            render json: publisher
        else
            render json: { error: "Publisher not found"}, status: 404
        end
    end

    def create
        publisher = Publisher.new(publisher_params)
        if publisher.save
            render json: publisher
        else
            render json: publisher.errors
        end
    end
end
