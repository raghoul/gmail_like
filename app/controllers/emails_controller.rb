class EmailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_email, only: [:show, :edit, :update, :destroy]

  # GET /emails
  # GET /emails.json
  def index
    @emails = Email.all
  end

  # GET /emails/1
  # GET /emails/1.json
  def show
    @email.update(read: true) if !@email.read

    respond_to do |format|
      format.html{}
      format.js{}
    end
  end

  # GET /emails/new
  def new
    create
  end

  # GET /emails/1/edit
  def edit
  end

  # POST /emails
  # POST /emails.json
  def create
    @email = Email.new(body: Faker::Lorem.paragraph, object: Faker::Book.title)

    respond_to do |format|
      if @email.save
        format.html { redirect_to @email, notice: 'Email was successfully created.' }
        format.json { render :show, status: :created, location: @email }
        format.js {}
      else
        format.html { render :new }
        format.json { render json: @email.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # PATCH/PUT /emails/1
  # PATCH/PUT /emails/1.json
  def update
    if params[:invertRead] == true
      @email.update(read: !@email.read)
      respond_to do |format|
        format.html{}
        format.js{}
      end
    else
      respond_to do |format|
        if @email.update(email_params)
          format.html { redirect_to @email, notice: 'Email was successfully updated.' }
          format.json { render :show, status: :ok, location: @email }
          format.js {}
        else
          format.html { render :edit }
          format.json { render json: @email.errors, status: :unprocessable_entity }
          format.js {}
        end
      end
    end
  end

  # DELETE /emails/1
  # DELETE /emails/1.json
  def destroy
    @emailId = @email.id;
    @email.destroy
    respond_to do |format|
      format.html { redirect_to emails_url, notice: 'Email was successfully destroyed.' }
      format.json { head :no_content }
      format.js{}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_email
    @email = Email.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def email_params
    params.fetch(:email, {})
  end
end
