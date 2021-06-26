class PhotosController < ApplicationController
  before_action :set_photo, only: %i[ show edit update destroy ]
  before_action :baria_user, only: %i[ edit update destroy ]

  # GET /photos or /photos.json
  def index
    @photos = Photo.all
  end

  # GET /photos/1 or /photos/1.json
  def show
    @favorite = current_user.favorites.find_by(photo_id: @photo.id)
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  def confirm
    # @photo = Photo.new(photo_params)
    # binding.pry
    @photo = current_user.photos.build(photo_params)
    render :new if @photo.invalid?
  end

  # GET /photos/1/edit
  def edit

  end

  # POST /photos or /photos.json
  def create
    @photo = current_user.photos.build(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: "Photo was successfully created." }
        format.json { render :show, status: :created, location: @photo }
        ConfirmMailer.confirm_mail(@photo).deliver
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1 or /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: "Photo was successfully updated." }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1 or /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: "Photo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def baria_user
      unless Photo.find(params[:id]).user_id.to_i == current_user.id
        redirect_to photos_path(current_user)
      end
    end

    # Only allow a list of trusted parameters through.
    def photo_params
      params.require(:photo).permit(:image, :content, :image_cache, :user_id)
    end
end
