module ApplicationHelper
  def notice_class(name)
    name == 'notice' ? 'success' : name
  end

  def search_placeholder
    return " in #{@category.name}" if @category.present?

    ' in all categories'
  end
end
