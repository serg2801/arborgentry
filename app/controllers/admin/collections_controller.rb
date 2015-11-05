class Admin::CollectionsController < ApplicationController
	before_action :set_collection, only: [:show, :edit, :update, :destroy]
	respond_to :html
	respond_to :js, only: :show
	
	def index
		@collections = Collection.all
    respond_with(@collections)
	end

	def show
    admin_collection_path(@collection)
  end

	def new
		@collection = Collection.new
		respond_with(@collection)
	end

	def create
    @collection = Collection.new(collection_params)
    if @collection.save
      flash[:success]="Collection created successfully."
			respond_with(:admin, @collection)
    else
      render 'new'
    end
  end

  def edit
		respond_with(@collection)
  end

  def update
  	if @collection.update_attributes(collection_params)
      flash[:success]="Collection updated successfully."
			respond_with(:admin, @collection)
	  else
	  	render 'edit'
  	end
  end

  def destroy
  	@collection.destroy
  	flash[:success]="Collection deleted successfully."
		respond_with(:admin, @collection)
  end

  private

  	def set_collection
      @collection = Collection.find(params[:id])
    end

    def collection_params
      params.require(:collection).permit!
    end

end
