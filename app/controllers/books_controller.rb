class BooksController < ApplicationController

  load_and_authorize_resource
  
  def create
    if @book.save
      redirect_to books_path, :notice => "Libro #{@book.title} creado."
    else
      render :action => 'new'
    end
  end

  def update
    if @book.update_attributes(params[:book])
      redirect_to books_path, :notice => "Libro #{@book.title} actualizado."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, :notice => "Successfully destroyed book."
  end
end
