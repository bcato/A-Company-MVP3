class InstrumentsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  # GET /instruments
  # GET /instruments.json
  def index    
      @instruments = Instrument.order("created_at desc")
      
      respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @instruments }
    end
  end

  # GET /instruments/1
  # GET /instruments/1.json
  def show
    @instrument = Instrument.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @instrument }
    end
  end

  # GET /instruments/new
  # GET /instruments/new.json
  def new
    @instrument = current_user.instruments.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @instrument }
    end
  end

  # GET /instruments/1/edit
  def edit
    @instrument = current_user.instruments.find(params[:id])
  end

  # POST /instruments
  # POST /instruments.json
  def create
    @instrument = current_user.instruments.new(params[:instrument])

    respond_to do |format|
      if @instrument.save
        format.html { redirect_to @instrument, notice: 'Instrument was successfully created.' }
        format.json { render json: @instrument, status: :created, location: @instrument }
      else
        format.html { render action: "new" }
        format.json { render json: @instrument.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /instruments/1
  # PUT /instruments/1.json
  def update
    @instrument = current_user.instruments.find(params[:id])

    respond_to do |format|
      if @instrument.update_attributes(params[:instrument])
        format.html { redirect_to @instrument, notice: 'Instrument was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @instrument.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instruments/1
  # DELETE /instruments/1.json
  def destroy
    @instrument = current_user.instruments.find(params[:id])
    @instrument.destroy

    respond_to do |format|
      format.html { redirect_to instruments_url }
      format.json { head :no_content }
    end
  end

  def reservation
    @instrument = Instrument.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @instrument }    
    end
  end

  #def request
   # @instrument = current_user.instruments.find(params[:id]).request!
    #redirect_to instruments_path, notice: "Instrument was requested!"
  #end

end
