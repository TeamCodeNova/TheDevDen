module Admin
  class ProductsController < ApplicationController
    before_action :authenticate_admin!


    def log_p(variable)
      Rails.logger.info("Variable value: #{variable}")
    end
    def log_pp(variable)
      Rails.logger.info("Variable value: #{variable}")
    end
    def log_i(variable)
      Rails.logger.info("Variable value: #{variable}")
    end
    # List all products
    def index
      @products = Product.all
    end

    # Display a single product
    def show
      @product = Product.find(params[:id])
    end

    # Create a new product form
    def new
      @product = Product.new
    end

    # Save a new product
    def create
      @product = Product.new(product_params)
      log_p(product_params)
      if @product.save
        handle_image(params[:product][:image]) if params.dig(:product, :image)
        redirect_to [:admin, @product], notice: 'Product was successfully created.'
      else
        render :new
      end
    end

    # Edit an existing product form
    def edit
      @product = Product.find(params[:id])
    end

    # Update an existing product
    def update
      @product = Product.find(params[:id])

      if @product.update(product_params)
        log_pp(product_params)
        handle_image(params[:product][:image]) if params.dig(:product, :image)
        redirect_to [:admin, @product], notice: 'Product was successfully updated.'
      else
        render :edit
      end
    end

    # Delete a product
    def destroy
      @product = Product.find(params[:id])
      @product.destroy
      redirect_to admin_products_path, notice: 'Product was successfully deleted.'
    end

    private

    def product_params
      params.require(:product).permit(:product_name, :product_description, :product_price, :category_id, :original_filename)
    end

    def handle_image(uploaded_image)
      log_i(uploaded_image)
      return unless uploaded_image

      # Attach the uploaded image to the product
      new_image = @product.product_images.new(image: uploaded_image)

      # Save the new record
      unless new_image.save
        Rails.logger.error "Failed to save image for product ##{@product.id}"
      end
    end
    def authenticate_admin!
      redirect_to admin_login_path unless current_admin
    end

    def current_admin
      @current_admin ||= User.find_by(id: session[:admin_id])
    end
  end
end
