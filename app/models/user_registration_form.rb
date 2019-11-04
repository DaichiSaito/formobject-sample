class UserRegistrationForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :company_name, :string

  validates :name, presence: true
  validates :company_name, presence: true

  # Forms are never themselves persisted
  def persisted?
    false
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def persist!
    @company = Company.create!(name: company_name)
    @user = @company.users.create!(name: name)
  end
end
