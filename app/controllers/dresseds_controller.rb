class DressedsController < ApplicationController
  before_action :set_dressed, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token


  # GET /dresseds
  def index
    create
    @dresseds = Dressed.all
  end

  # GET /dresseds/1
  def show
  end

  # GET /dresseds/new
  def new
    @dressed = Dressed.new
  end

  # GET /dresseds/1/edit
  def edit
  end

  def is_morning(hour)
    if hour >= 6
      if hour <= 9
        true
      end
    end
    false
  end

  # POST /dresseds
  def create
    today = Date.today
    now = Time.current
    hour = now.hour
    day = now.day
    month = now.month
    @dressed = Dressed.new(day: today)
    if is_morning(hour)
      @past = Dressed.find_by(day: today)
      if @past == nil
        if @dressed.save
          push_message
          p 'success create'
        end
      end
    end
  end

  # PATCH/PUT /dresseds/1
  def update
    if @dressed.update(dressed_params)
      redirect_to @dressed, notice: 'Dressed was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /dresseds/1
  def destroy
    @dressed.destroy
    redirect_to dresseds_url, notice: 'Dressed was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dressed
      @dressed = Dressed.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def dressed_params
      params.require(:dressed).permit(:day)
    end



# notice Arduino push
  def push_message
    message = {
        type: 'text',
        text: 'おはよう！今日も一日頑張ろう！'
    }

    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    end

    # りょうた
    @client.push_message("Ueea6754dfeb9239c2b2993b7347c3bd5", message)

    # みっこ
    @client.push_message("U7efac63403e692bd79bb35d107219200", message)
  end
end
