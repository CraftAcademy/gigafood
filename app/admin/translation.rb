ActiveAdmin.register Translation, as: 'Translation' do
  menu label: 'Translations'
  permit_params :locale, :key, :value, :interpolations, :is_proc

  index do
    selectable_column
    column :locale
    column :key
    column :value
    actions
  end

  show do
    attributes_table do
      row :key
      row :value
      row :locale
    end
  end

  form do |f|
    f.inputs do
      f.input :locale, label: 'Language', as: :select, collection: LANGUAGES, include_blank: false
      f.input :key, as: :select, collection: I18n.get_current_locale_keys, include_blank: false
      f.input :value
      f.actions
    end
  end

  after_create do
    I18n.backend.reload!
  end


  controller do

    def create
      super
    end

    def update
      super
      I18n.backend.reload!
    end

    def destroy
      super
      I18n.backend.reload!
    end


  end
end