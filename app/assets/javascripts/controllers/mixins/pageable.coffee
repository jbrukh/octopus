App.Pageable = Ember.Mixin.create
  hasPages: (->
    totalPages = @get('content.meta.total_pages')
    totalPages > 1
  ).property('content.meta.total_pages')

  isFirstPage: (->
    @get('content.meta.page') == 1
  ).property('content.meta.page')

  isLastPage: (->
    page = @get('content.meta.page')
    totalPages = @get('content.meta.total_pages')
    page == totalPages
  ).property('content.meta.page', 'content.meta.total_pages')

  previousPage: (->
    page = @get('content.meta.page') - 1
    if page <= 0
      undefined
    else
      page
  ).property('content.meta.page')

  nextPage: (->
    @get('content.meta.page') + 1
  ).property('content.meta.page')

  pages: (->
    currentPage = @get('content.meta.page')
    totalPages = @get('content.meta.total_pages')

    # find the first page
    from = currentPage - 3
    from = 1 if from < 1

    # move up to the last page
    to = from + 7

    # ensure we have a valid range
    if to > totalPages
      to = totalPages
      from = to - 7
      from = 1 if from < 1

    # build the pages
    for page in [from..to]
      Em.Object.create
        pageNumber: page
        isCurrentPage: page == currentPage
  ).property('content.meta.total_pages', 'content.meta.page')