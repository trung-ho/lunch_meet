ActiveAdmin.register Group do
  actions :all, except: [:destroy]

  index do
    column :id
    column :name
    column :admin do |group|
      link_to "#{group.admin.email}", admin_user_path(group.admin.id)
    end
    actions
  end
end