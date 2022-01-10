# frozen_string_literal: true

module CategoriesHelper
  def sort_link(column, name = nil)
    name ||= column.titleize
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    icon = sort_direction == 'asc' ? 'glyphicon glyphicon-chevron-up' : 'glyphicon glyphicon-chevron-down'
    icon = column == sort_column ? icon : ''
    link_to "#{name} <span class='#{icon}'></span>".html_safe, { column: column, direction: direction }
  end
end
