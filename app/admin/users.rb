ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :github_username, :image_url, :portfolio_url, :hackerrank_username, :stackoverflow_url, :linkedin_url, :provider, :uid, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :admin
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :github_username, :image_url, :portfolio_url, :hackerrank_username, :stackoverflow_url, :linkedin_url, :provider, :uid, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :admin]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
	  column :id
	  column :email
	  column :name
	  column :github_username
	  column :image_url
	  column :portfolio_url
	  column :hackerrank_username
	  column :stackoverflow_url
	  column :linkedin_url
	  column :created_at
	  column :updated_at
	  actions
  end
  
end
