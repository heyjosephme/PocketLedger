class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: %i[ show edit update destroy ]

  # GET /expenses or /expenses.json
  def index
    @expenses = current_user.expenses
  end

  # GET /expenses/1 or /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    # Pre-fill from params if coming from "Create Another" flow
    expense_date = if params[:expense_date].present?
                     begin
                       Date.parse(params[:expense_date])
                     rescue ArgumentError
                       Date.current
                     end
    else
                     Date.current
    end

    @expense = current_user.expenses.build(
      expense_date: expense_date,
      expense_type: params[:expense_type] || :personal,
      category: params[:category]
    )
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses or /expenses.json
  def create
    @expense = current_user.expenses.build(expense_params)

    respond_to do |format|
      if @expense.save
        # Increment consecutive entry counter
        session[:consecutive_count] ||= 0
        session[:consecutive_count] += 1

        # Check if user clicked "Create & Add Another"
        if params[:add_another].present?
          # Set flash messages
          flash[:notice] = "Expense created! Add another or view all expenses."
          flash[:consecutive_count] = session[:consecutive_count]

          # Redirect to new form with pre-filled params
          format.html {
            redirect_to new_expense_path(
              expense_date: @expense.expense_date.to_s,
              expense_type: @expense.expense_type,
              category: @expense.category
            )
          }
        else
          # Normal flow - reset counter and redirect to show
          session[:consecutive_count] = 0
          format.html { redirect_to @expense, notice: "Expense was successfully created." }
        end

        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to @expense, notice: "Expense was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    @expense.destroy!

    respond_to do |format|
      format.html { redirect_to expenses_path, notice: "Expense was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = current_user.expenses.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def expense_params
      params.expect(expense: [
        :amount, :description, :expense_date, :expense_type, :category, :vendor, :notes,
        :is_recurring, :recurrence_frequency, :recurrence_start_date, :recurrence_end_date,
        receipts: []
      ])
    end
end
