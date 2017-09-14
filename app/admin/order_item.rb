ActiveAdmin.register OrderItem do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :owner, :item, :list, :of, :attributes, :on, :model,
  :owner_id, :owner_type, :quantity, :item_id, :item_type, :price_cent,
  :price_currency, :created_at, :updated_at
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
