class MyusersController < ApplicationController
  before_action :set_myuser, only: [:show, :edit, :update, :destroy]

  # GET /myusers
  # GET /myusers.json
  def index
    @myusers = Myuser.all
  end

  # GET /myusers/1
  # GET /myusers/1.json
  def show
  end

  # GET /myusers/new
  def new
    @myuser = Myuser.new
  end

  # GET /myusers/1/edit
  def edit
  end

  # POST /myusers
  # POST /myusers.json
  def create
    @myuser = Myuser.new(myuser_params)

    respond_to do |format|
      if @myuser.save
        format.html { redirect_to @myuser, notice: 'Myuser was successfully created.' }
        format.json { render action: 'show', status: :created, location: @myuser }
      else
        format.html { render action: 'new' }
        format.json { render json: @myuser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /myusers/1
  # PATCH/PUT /myusers/1.json
  def update
    respond_to do |format|
      if @myuser.update(myuser_params)
        format.html { redirect_to @myuser, notice: 'Myuser was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @myuser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /myusers/1
  # DELETE /myusers/1.json
  def destroy
    @myuser.destroy
    respond_to do |format|
      format.html { redirect_to myusers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_myuser
      @myuser = Myuser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def myuser_params
      params.require(:myuser).permit(:uname , :avatar)
    end
end
