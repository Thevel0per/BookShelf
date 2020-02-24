class EbooksSearch
  extend Dry::Initializer

  option :page, optional: true, default: -> { 1 }
  option :per_page, optional: true, default: -> { 15 }
  option :search_query, optional: true
  option :category, optional: true

  def call
    scope = Ebook.all
    scope = paginate(scope)
    scope = search_by_text(scope) if search_query.present?
    scope = filter_by_category(scope) if category.present?

    scope
  end

  def paginate(scope)
    scope.paginate(page: page, per_page: per_page)
  end

  def search_by_text(scope)
    scope.where('title LIKE :query OR author LIKE :query', query: "%#{search_query}%")
  end

  def filter_by_category(scope)
    scope.where(category_id: category)
  end
end