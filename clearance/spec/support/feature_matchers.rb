require 'rspec/expectations'

RSpec::Matchers.define :have_menu_for_items_with_status_filter do
  match do |actual|
    Item::STATUSES.each do |status|
      expect(actual).to have_link(status.titleize, href: items_path(filter: status))
    end
  end
end
