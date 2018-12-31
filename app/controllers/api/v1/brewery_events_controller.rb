class Api::V1::BreweryEventsController < ApplicationController
  def index
    brewery = Brewery.find_by_id(params[:brewery_id])
    if brewery
      options = {}
      options[:include] = [:brewery_events]
      render json: BreweryShowSerializer.new(brewery, options).serialized_json
    else
      render json: {message: "Sorry, that brewery does not exist, please try again."}, status: 400
    end
  end

  def create
    brewery = Brewery.find_by_id(params[:brewery_id])
    brewery_event = brewery.brewery_events.create(brewery_event_params)
    if brewery_event.save
      render status: 201
    else
      render json: {message: "Could not save, please try again."}, status: 400
    end
  end

  def update
    brewery = Brewery.find_by_id(params[:brewery_id])
    brewery_event = brewery.brewery_events.find_by_id(params[:id]) unless brewery.nil?
    if brewery == nil
      render json: {message: "Brewery not found with ID #{params[:brewery_id]}"}, status: 404
    elsif brewery_event == nil
      render json: {message: "Event ID #{params[:id]} not found with associated brewery ID #{params[:brewery_id]}"}, status: 404
    else
      brewery_event.update(brewery_event_params)
      render status: 200
    end
  end

  def destroy
    brewery = Brewery.find_by_id(params[:brewery_id])
    brewery_event = BreweryEvent.find_by_id(params[:id])
    if brewery == nil
      render json: {message: "Brewery not found with ID #{params[:brewery_id]}"}, status: 404
    elsif brewery_event == nil
      render json: {message: "Event not found with ID #{params[:id]}"}, status: 404
    elsif brewery.id == brewery_event.brewery_id
      brewery_event.destroy
      render status: 204
    else
      render json: {message: "Event ID #{params[:id]} not associated with Brewery ID #{params[:brewery_id]}"}, status: 400
    end
  end

  private

  def brewery_event_params
    params.permit(:date, :truck_booked?)
  end
end