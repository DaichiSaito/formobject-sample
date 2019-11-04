class BookInputForm < Form::Base

  # include ActiveModel::Model

  # attr_accessor :books
  #
  # def books_attributes=(attributes)
  #   @books ||= []
  #   attributes.each do | i, book_params|
  #     @books.push(Book.new(book_params))
  #   end
  # end
  #
  # def save
  #   @books.each do | book |
  #     book.save
  #   end
  # end


  attr_accessor :books
  def initialize(attributes = {})
    super attributes
    self.books = 5.times.map { Form::Book.new } unless books.present?
  end

  def books_attributes=(attributes)
    self.books = attributes.map do |_, book_attributes|
      Form::Book.new(book_attributes)
    end
  end

  def valid?
    valid_books = target_books.map(&:valid?).all?
    super && valid_books
  end

  def save
    return false unless valid?
    Book.transaction { target_books.each(&:save!) }
    true
  end

  def target_books
    self.books#.select { |v| value_to_boolean(v.register) }
  end
end
