# frozen_string_literal: true

class OpBlock < ::BaseSection
  button(:tryout, class: 'try-out__btn')
  button(:execute_button, class: 'execute')
  h4(:server_response, text: 'Server response')

  def execute
    execute_button
    Watir::Wait.until { server_response_element.present? }
  end

  def is_open
    attributes[:class].include? 'is-open'
  end

  def toggle
    div(class: /opblock-summary-(delete|put|post|get)/).click
  end

  def expand
    toggle unless is_open
  end

  def collapse
    toggle if is_open
  end
end

class SwaggerAPIPage < BasePage
  sections(:deletes, OpBlock, item: { class: 'opblock-delete' })
  sections(:puts, OpBlock, item: { class: 'opblock-put' })
  sections(:posts, OpBlock, item: { class: 'opblock-post' })
  sections(:gets, OpBlock, item: { class: 'opblock-get' })

  def find_block(name_ends_with)
    Watir::Wait.until { deletes.count > 0 && puts.count > 0 && posts.count > 0 && gets.count > 0 }
    name_ends_with = name_ends_with.downcase
    block = deletes.find { |p| p.link(class: 'nostyle').span().text.downcase.ends_with? name_ends_with }
    block = puts.find { |p| p.link(class: 'nostyle').span().text.downcase.ends_with? name_ends_with } if block.nil?
    block = posts.find { |p| p.link(class: 'nostyle').span().text.downcase.ends_with? name_ends_with } if block.nil?
    block = gets.find { |p| p.link(class: 'nostyle').span().text.downcase.ends_with? name_ends_with } if block.nil?
    return block
  end

  def open(name_ends_with)
    block = find_block(name_ends_with)
    return nil if block.nil?
    block.expand
    block.tryout
    return block
  end
end
