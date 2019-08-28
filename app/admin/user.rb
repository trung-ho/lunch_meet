ActiveAdmin.register User do
  # preserve_default_filters!
  filter :email_cont, as: :string, label: "Email"
  filter :first_name_or_last_name_cont, as: :string, label: "Name"

  index do
    column :id
    column :email
    column :first_name
    column :last_name
    actions
  end
end