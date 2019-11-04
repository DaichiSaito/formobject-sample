class CompanyRegistrationForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  # attribute :users_attributes
  attribute :name, :string
  attribute :users

  def company
    @company ||= Company.new
  end

  # def users
  #   @users_attributes ||= User.new
  # end

  def users_attributes=(attributes)
    # @users_attributes = User.new(attributes)
    self.users ||= []
    self.users = attributes.map do |_, user_params|
      User.new(user_params)
    end
    # attributes.each do |_, user_params|
    #   self.users.push(User.new(user_params))
    # end
  end

  def save
    return false if invalid?

    company.assign_attributes(company_params)
    build_associations

    if company.save
      true
    else
      false
    end
  end

  private

  def company_params
    {
        name: name
    }
  end

  def build_associations
    company.users << self.users
  end

  # include ActiveModel::Attributes
  #
  # attribute :name, :string
  # # attribute :user_name, :string
  # attribute :users
  #
  # validates :name, presence: true
  # # validates :user_name, presence: true
  #
  # def users_attributes=()
  # # Forms are never themselves persisted
  # def persisted?
  #   false
  # end
  #
  # def save
  #   if valid?
  #     persist!
  #     true
  #   else
  #     false
  #   end
  # end
  #
  # private
  #
  # def persist!
  #   @company = Company.create!(name: company_name)
  #   @user = @company.users.create!(name: name)
  # end
end
