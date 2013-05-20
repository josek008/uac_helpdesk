class CategoriesController < ApplicationController
	before_filter :admin_user, 	only: [:index, :new, :create, :edit, :update, :destroy]

	respond_to :html, :json

	def index
		@category = nil
		@categories = Category.find_all_by_parent_id(nil)
	end

	def show
		@category = Category.find(params[:id])
		@categories = @category.subcategories
		render 'index'
	end

	def new
		@category = Category.new
		@category.parent = Category.find(params[:id]) unless params[:id].nil?
	end

	def create
		@category = Category.new(params[:category])
		@category.parent = Category.find(params[:parent]) unless params[:id].nil?

		if @category.save
			flash[:success] = "Subcategoria creada!"
			redirect_to @category.parent
		else
			render 'new'
		end
	end

	def edit
		@category = Category.find(params[:id])
	end

	def update
		@category = Category.find(params[:id])
		if @category.update_attributes(params[:category])
			flash[:success] = "Subcategoria actualizada!"
			redirect_to @category.parent
		else
			render 'edit'
		end
	end

	def destroy
		Category.find(params[:id]).destroy
		flash[:success] = "Subcategoria eliminada!"
		redirect_to categories_url
	end

	def subcategories
		if params[:widget][:category].present?
			parent_id = params[:widget][:category]
			@subcategories = Category.select("id, name").where("parent_id = ?", parent_id)
		else
			@subcategories = []
		end

		respond_with(@subcategories)
	end

	def admin_user
		redirect_to (root_path) unless current_user.admin?
	end

end
