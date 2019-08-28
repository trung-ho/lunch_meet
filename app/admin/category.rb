ActiveAdmin.register Category do
  actions :all, except: [:destroy]

  index do
    column :id
    column :name
    column :alias
    actions
  end
end