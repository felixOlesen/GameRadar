class ForumsController < ApplicationController
  before_action :set_forum, only: [:show, :edit, :update, :destroy]
  before_action :set_game, only: [:new, :create]

  # GET /forums
  # GET /forums.json
  def index
    @forums = Forum.all
  end

  # GET /forums/1
  # GET /forums/1.json
  def show
  end

  # GET /forums/new
  def new
    @forum = @game.forums.new
  end

  # GET /forums/1/edit
  def edit
  end

  # POST /forums
  # POST /forums.json
  def create
    @forum = @game.forums.new(forum_params)

    respond_to do |format|
      if @forum.save
        format.html { redirect_to @forum, notice: 'Forum was successfully created.' }
        format.json { render :show, status: :created, location: @forum }
      else
        format.html { render :new }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forums/1
  # PATCH/PUT /forums/1.json
  def update
    respond_to do |format|
      if @forum.update(forum_params)
        format.html { redirect_to @forum, notice: 'Forum was successfully updated.' }
        format.json { render :show, status: :ok, location: @forum }
      else
        format.html { render :edit }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forums/1
  # DELETE /forums/1.json
  def destroy
    @forum.destroy
    respond_to do |format|
      format.html { redirect_to forums_url, notice: 'Forum was successfully destroyed.' }
      format.js {flash[:notice] = 'Forum was successfully destroyed.'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forum
      @forum = Forum.find(params[:id])
    end

    def set_game
        @game = Game.find_by(id:params[:game_id]) || Game.find(forum_params[:game_id])
    end

    # Only allow a list of trusted parameters through.
    def forum_params
      params.require(:forum).permit(:game_id, :title, :entry)
    end
end
