module I18nDictionary
  def self.translations
    I18n.backend.load_translations
    translations = I18n.backend.send(:translations)
    translations[I18n.locale][:activeadmin_jobs]
  end
end
