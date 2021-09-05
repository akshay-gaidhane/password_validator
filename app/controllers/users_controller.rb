class UsersController < ApplicationController
  def index
  end

  def upload_csv_file
    if params[:file].present?
      result = User.import(params[:file])
      if result.is_a? Array
        @result = User.save_and_result(result)
      else
        return @error = result
      end
    else
      @error = "Please select file."
    end
    respond_to do |format|
      format.js {render layout: false}
    end
  end
end
