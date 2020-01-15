class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :new_book, only: [:show, :index]

  def show
  	@book = Book.find(params[:id])
  end

  def index
  	@books = Book.all
    @new_book = Book.new #一覧表示するためにBookモデルの情報を全てくださいのall
  end

  def create
  	@new_book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
  	@new_book.user_id = current_user.id
    if @new_book.save #入力されたデータをdbに保存する。
  		redirect_to @new_book, notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		@books = Book.all
        flash[:denger] = @new_book.errors.full_messages
  		render 'index'
  	end
  end

  def edit
  	@book = Book.find(params[:id])
      if current_user.id != @book.user_id
        redirect_to books_path
      end
  end



  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def delete
  	@book = Book.find(params[:id])
  	@book.destoy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

  def new_book
    @new_book = Book.new
  end

end
