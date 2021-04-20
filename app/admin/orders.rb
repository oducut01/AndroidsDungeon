ActiveAdmin.register Order do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :email, :address, :city, :postalCode, :status, :payment_id, :gst_total, :pst_total, :hst_total, :customer_id, :province
  #
  # or
  #
  permit_params do
    permitted = %i[name email address city postalCode status payment_id gst_total
                   pst_total hst_total customer_id province]
    permitted << :other if params[:action] == "create" && current_user.admin?
    permitted
  end
end
