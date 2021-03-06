class Api::LotsController < ApplicationController

    def index
        lots = Lot.all

        render_records lots
    end

    def show
        lot = Lot.find params[:id]

        render_response lot, displayable_keys
    end

    def update
        lot = Lot.find params[:id]
        lot.assign_attributes lot_params

        lot.save ?
            render_204
            : render_error(lot)
    end

    def destroy
        Lot.find(params[:id]).destroy

        render_204
    end

    def create
        lot = Lot.new lot_params

        lot.save ?
            render_response(lot, displayable_keys)
            : render_error(lot)
    end

    def fetch_little_brother_chips
        lot = Lot.find params[:lot_id]

        # fetch all little brother chips and return their id and coordinates
        little_brother_chips = lot.little_brother_chips.to_a.map{|l|
            location = l.location
            {
                id: l.id,
                coordinates: location ? location.coordinates : nil
            }}

        render json: {
            little_brother_chips: little_brother_chips
        }
    end

    private
        def lot_params
            params.require(:lot).permit :building_id, :lot_type, :name, :floor_level,
                {dimensions: [:units, :length, :width, :height] },
                :rssi_1m_away_from_beacon, :average_phone_height, :path_loss
        end

        def displayable_keys
            %w(id building_id lot_type name floor_level dimensions)
        end

end
