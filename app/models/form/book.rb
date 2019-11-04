class Form::Book < Book
  REGISTRABLE_ATTRIBUTES = %i(register title author price isbn)
  attr_accessor :register
end
