class CategoriesController < ApplicationController

	respond_to :html, :json

	def subcategories
		if params[:widget][:category].present?
			parent_id = params[:widget][:category]
			@subcategories = Category.select("id, name").where("parent_id = ?", parent_id)
		else
			@subcategories = []
		end

		respond_with(@subcategories)
	end
end
