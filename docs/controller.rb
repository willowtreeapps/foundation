require 'socket'
require '../lib/foundation/utils/sass_variable_extractor'
layout 'layout.html.erb'

ignore /css\//
ignore /js\//
ignore /.+.md/
ignore /Gemfile.*/
ignore /Procfile/
ignore /compile.rb/

before /test\/.*html\.erb/ do
  layout 'test/layout.html.erb'
end

helpers do
  def asset_path
    if @_stasis.options[:asset_path]
      @_stasis.options[:asset_path]
    elsif Socket.gethostname == "foundation"
      "http://foundation.zurb.com/docs/assets"
    else
      "http://#{Socket.ip_address_list.detect{|intf| intf.ipv4_private?}.getnameinfo[0]}:4001/assets"
    end
  end

  def code_example(code, lang=:ruby)
    "<div class='#{lang}'>" + CodeRay.scan(code, lang).div(:css => :class) + "</div>"
  end

  def settings_table_for(component)
    filepath = File.absolute_path(File.dirname(__FILE__) + "/../scss/foundation/components/_#{component}.scss")
    variables = SassVariableExtractor.new(filepath).extract_sass_variables
    template = <<-EOS
      <table width="100%">
        <thead>
          <tr>
            <th>Name</th>
            <th>Default Value</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
          <% variables.each do |v| %>
          <tr>
            <td>$<%= v[:name] %></td>
            <td><%= v[:value] %></td>
            <td><%= v[:comment] %></td>
          </tr>
          <% end %>
        </tbody>
      </table>
    EOS
    ERB.new(template).result(binding)
  end

  def foundation_home_path
    '/'
  end

  def features_path
    '/grid.php'
  end

  def training_path
    '/training.php'
  end

  def add_ons_path
    '/templates.php'
  end

  def case_studies_path
    '/case-jacquelinewest.php'
  end

  def docs_path
    '/docs/'
  end


  # Title & Descriptions for Foundation Components
  #   - These are used on each component page and in the all components dropdown
  #
  def alert_boxes_title
    'Alert Box'
  end
  def alert_boxes_description
    'Drop these into forms or inline on a page to communicate success, warnings, failure or any information.'
  end

  def block_grid_title
    'Block Grids'
  end
  def block_grid_description
    'Used to create evenly split contents of a list within the grid.'
  end

  def breadcrumbs_title
    'Breadcrumbs'
  end
  def breadcrumbs_description
    'Show a navigation trail so that users can get back to where they came from.'
  end

  def button_groups_title
    'Button Groups'
  end
  def button_groups_description
    'Built from our buttons styles, these let you display a group of actions in a bar or build navigation.'
  end

  def buttons_title
    'Buttons'
  end
  def buttons_description
    'A convenient tool when it comes to more traditional UI actions. The defaults are easy to customize to make them your own.'
  end

  def clearing_title
    'Clearing'
  end
  def clearing_description
    'Create responsive lightboxes with any size image. It becomes swipable on touch devices.'
  end

  def custom_forms_title
    'Custom Forms'
  end
  def custom_forms_description
    'It\'s so easy to create easy-to-style custom forms, it\'s practically a form of crime.'
  end

  def dropdown_buttons_title
    'Dropdown Buttons'
  end
  def dropdown_buttons_description
    'Build from our buttons styles, these give you a style of button perfect for attaching dropdowns to.'
  end

  def dropdown_title
    'Dropdown'
  end
  def dropdown_description
    'Expose links or content attached to elements on the page.'
  end

  def flex_video_title
    'Flex Video'
  end
  def flex_video_description
    'Embedding video and create an intrinsic ratio that will properly scale your video for any device.'
  end

  def forms_title
    'Forms'
  end
  def forms_description
    'A combination of basic form styles and the grid means you can build basically any form you need.'
  end

  def grid_title
    'Grid'
  end
  def grid_description
    'Create powerful multi-device layouts quickly and easily with the 12-column, nestable Foundation grid.'
  end

  def inline_lists_title
    'Inline Lists'
  end
  def inline_lists_description
    'Horizontal lists of links, like in a footer. For when you want more control than just the space between.'
  end

  def joyride_title
    'Joyride'
  end
  def joyride_description
    'An extremely flexible component that gives users a tour of your site or app when they visit.'
  end

  def keystrokes_title
    'Keystrokes'
  end
  def keystrokes_description
    'A simple keystroke character affordance that is built into Foundation.'
  end

  def labels_title
    'Labels'
  end
  def labels_description
    'Labels are useful inline styles that can be dropped into body copy to call out certain sections or to attach metadata.'
  end

  def magellan_title
    'Magellan'
  end
  def magellan_description
    'A style agnostic plugin that lets you create a sticky nav that denotes where you are on the page.'
  end

  def orbit_title
    'Orbit'
  end
  def orbit_description
    'An easy to use, powerful image slider that\'s responsive, allowing you to swipe on a touch devices.'
  end

  def pagination_title
    'Pagination'
  end
  def pagination_description
    'Create a way for people to easily access paginated content.'
  end

  def panels_title
    'Panels'
  end
  def panels_description
    'A simple component that enables you to create sections of your page that standout or act as secondary content.'
  end

  def pricing_tables_title
    'Pricing Tables'
  end
  def pricing_tables_description
    'If you\'re making a rockin\' marketing site for a subscription-based product, you are likely in need of a pricing table.'
  end

  def progress_bars_title
    'Progress Bars'
  end
  def progress_bars_description
    'Add a progress indicator to your layouts. You only need two HTML elements to make them and they\'re easy to customize.'
  end

  def reveal_title
    'Reveal'
  end
  def reveal_description
    'Modal dialogs or pop-up windows that respond to any screen size.'
  end

  def sections_title
    'Sections'
  end
  def sections_description
    'Similar to tabs, you can selectively show a single panel of content at a time.'
  end

  def side_nav_title
    'Side Nav'
  end
  def side_nav_description
    'Navigation that is normally used in sidebars to create access to secondary content.'
  end

  def sub_nav_title
    'Sub Nav'
  end
  def sub_nav_description
    'Great for creating nav for moving between different states of a page.'
  end

  def split_buttons_title
    'Split Buttons'
  end
  def split_buttons_description
    'Attach a dropdown to this nifty button style that can hold an action as well.'
  end

  def switch_title
    'Switch'
  end
  def switch_description
    'Used instead of regular radio buttons to switch between two options.'
  end

  def tables_title
    'Tables'
  end
  def tables_description
    'Okay, they\'re not the sexiest things ever, but tables get the job done (for tabular data, of course).'
  end

  def thumbnails_title
    'Thumbnails'
  end
  def thumbnails_description
    'If you are going to use an image as an anchor, we\'ve got you covered.'
  end

  def tooltips_title
    'Tooltips'
  end
  def tooltips_description
    'Tooltips are a quick way to provide extended information on a term or action on a page.'
  end

  def top_bar_title
    'Top Bar'
  end
  def top_bar_description
    'A powerful way to display a complex navigation bar on small or large screens.'
  end

  def typography_title
    'Typography'
  end
  def typography_description
    'Built with ems, making it easier to fine-tune your type across different breakpoints.'
  end

  def visibility_title
    'Visibility Classes'
  end
  def visibility_description
    'Turn elements on and off based on certain device criteria, like screen size, touch or orientation.'
  end

  def media_queries_title
    'Media Queries'
  end
  def media_queries_description
    'We keep media queries fairly simple in Foundation and let the percentage-based grid do the heavy lifting across various screen sizes.'
  end

  def rtl_title
    'Right-to-Left Support'
  end
  def rtl_description
    'Right-to-left text direction support in Foundation allows you to easily switch text direction for all components.'
  end
end
