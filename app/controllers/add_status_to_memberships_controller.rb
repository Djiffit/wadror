class AddStatusToMembershipsController < ApplicationController
  before_action :set_add_status_to_membership, only: [:show, :edit, :update, :destroy]

  # GET /add_status_to_memberships
  # GET /add_status_to_memberships.json
  def index
    @add_status_to_memberships = AddStatusToMembership.all
  end

  # GET /add_status_to_memberships/1
  # GET /add_status_to_memberships/1.json
  def show
  end

  # GET /add_status_to_memberships/new
  def new
    @add_status_to_membership = AddStatusToMembership.new
  end

  # GET /add_status_to_memberships/1/edit
  def edit
  end

  # POST /add_status_to_memberships
  # POST /add_status_to_memberships.json
  def create
    @add_status_to_membership = AddStatusToMembership.new(add_status_to_membership_params)

    respond_to do |format|
      if @add_status_to_membership.save
        format.html { redirect_to @add_status_to_membership, notice: 'Add status to membership was successfully created.' }
        format.json { render :show, status: :created, location: @add_status_to_membership }
      else
        format.html { render :new }
        format.json { render json: @add_status_to_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /add_status_to_memberships/1
  # PATCH/PUT /add_status_to_memberships/1.json
  def update
    respond_to do |format|
      if @add_status_to_membership.update(add_status_to_membership_params)
        format.html { redirect_to @add_status_to_membership, notice: 'Add status to membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @add_status_to_membership }
      else
        format.html { render :edit }
        format.json { render json: @add_status_to_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /add_status_to_memberships/1
  # DELETE /add_status_to_memberships/1.json
  def destroy
    @add_status_to_membership.destroy
    respond_to do |format|
      format.html { redirect_to add_status_to_memberships_url, notice: 'Add status to membership was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_add_status_to_membership
      @add_status_to_membership = AddStatusToMembership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def add_status_to_membership_params
      params.require(:add_status_to_membership).permit(:boolean)
    end
end
