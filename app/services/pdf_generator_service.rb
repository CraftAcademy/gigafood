class PdfGeneratorService

  def initialize(order)
    @order = order
    raise StandardError.new(I18n.t('invoice.error')) if @order.shopping_cart_items.empty?
  end

  def generate_invoice
    helpers = ActionController::Base.helpers
    filename = [I18n.t('invoice.header'), @order.id, @order.billing_name, rand(20000)].join('-') + '.pdf'

    # Initial setup of the document
    pdf = create_and_configure_pdf

    pdf.define_grid(columns: 5, rows: 8, gutter: 10)

    pdf.grid([0, 0], [1, 1]).bounding_box do
      logo_path = File.expand_path(Rails.root.join('app', 'assets', 'images', 'gigafood_logo.png'))

      pdf.image logo_path, height: 60, position: :left

      # Company address
      pdf.move_down 10
      pdf.text 'FOOD FOR BILLIONS SWEDEN AB', size: 11, align: :left, style: :bold
      pdf.move_down 20
      pdf.text "Buyer contact: #{@order.billing_name}"
      pdf.move_down 20
      pdf.text 'Our contact: Rebecka Carlsson '


    end

    pdf.grid([0, 3.6], [1, 4]).bounding_box do
      # Display customer details
      pdf.text I18n.t('invoice.header'), size: 18, style: :bold
      pdf.text "Invoice # #{@order.id}", align: :left
      pdf.text "Date: #{Date.today.to_s}", align: :left
      pdf.move_down 10
      pdf.text @order.billing_company
      pdf.text @order.billing_address if @order.billing_address
      pdf.text [@order.billing_postal_code, @order.billing_city].join(' ') if @order.billing_postal_code

      pdf.text "Org.nr: #{@order.billing_org_nr}"

      pdf.text "Phone: #{@order.billing_phone}"
      # Display payment details
      pdf.move_down 20
      pdf.text "Due: #{@order.due_date.strftime('%Y-%m-%d')}", style: :bold


    end

    # Add empty row and headers
    data = [['', '', '', ''], %w(Product Price Qty Subtotal)]
    # Add order items
    @order.shopping_cart_items.each do |item|
      data << [item.item.name, helpers.humanized_money(item.item.price) + ' SEK', item.quantity, helpers.humanized_money(item.subtotal) + ' SEK']
    end

    # Add VAT + Total
    subtotal = [I18n.t('order.subtotal'), ' ', helpers.humanized_money(@order.subtotal), ' SEK'].join
    tax = [I18n.t('order.tax'), ' ', helpers.humanized_money(@order.taxes), ' SEK'].join
    total = [I18n.t('order.total'), ' ', helpers.humanized_money(@order.total), ' SEK'].join

    data << ['', '', '', subtotal]
    data << ['', '', '', tax]
    data << ['', '', '', total]
    # Add last epmty row
    data << ['', '', '', '']

    pdf.table(data, width: 520, column_widths: [300, 50, 30, 140]) do |table|

      table.row(0).font_style = :bold


      table.before_rendering_page do |page|
        # First row has a top border and no bottom border - no side borders
        page.row(0).border_top_width = 2
        page.row(0).border_bottom_width = 0
        page.row(0).border_left_width = 0
        page.row(0).border_right_width = 0

        # Last row has a bottom border and no top border  - no side borders
        page.row(-1).border_bottom_width = 2
        page.row(-1).border_top_width = 0
        page.row(-1).border_right_width = 0
        page.row(-1).border_left_width = 0

        # The order details have no borders at all
        page.rows(1..-2).borders = []

        # Item price column aligns to right
        page.column(2).align = :right
        # Quantity column is centered
        page.column(-2).align = :center
        # Subtotal column aligns to right
        page.column(-1).align = :right
        # Header row is bold
        page.row(1).font_style = :bold
        # Order total row is bold
        page.row(-2).font_style = :bold
      end
    end

    create_footer(pdf)
    pdf.render_file filename
    add_attachment(filename, :invoice)
  end


  def generate_menu
    filename = [I18n.t('menu.main_header'), @order.id, @order.billing_name, rand(20000)].join('-') + '.pdf'

    # Initial setup of the document
    pdf = create_and_configure_pdf
    pdf.font_size 14

    # footer
    pdf.repeat :all do
      pdf.bounding_box [pdf.bounds.left, pdf.bounds.bottom + 60], width: pdf.bounds.width do
        pdf.text I18n.t('menu.main_intro_text'), align: :center, size: 10
        pdf.move_down 10

        pdf.text 'www.gigafood.se', align: :center, size: 8, style: :bold
      end
    end

    pdf.bounding_box [pdf.bounds.left, pdf.bounds.top], width: pdf.bounds.width, height: pdf.bounds.height - 60 do

      # Display logo on center
      logo_path = File.expand_path(Rails.root.join('app', 'assets', 'images', 'gigafood_logo.png'))

      pdf.image logo_path, height: 60, position: :center
      pdf.move_down 20
      pdf.text I18n.t('menu.main_header'), size: 24, align: :center, style: :bold
      pdf.move_down 40
      # TABLE
      data = []
      # Add order items
      collection = @order.shopping_cart_items
                       .group_by {|i| i.item.category}
                       .sort_by {|k, _| k.sort_key}

      collection.each do |category, items|
        items.each do |item|
          data << ["<strong>#{item.item.name}</strong>"]
          data << [item.item.description]
        end
      end


      pdf.table(data, width: 520) do |table|

        table.row(0).font_style = :bold


        table.before_rendering_page do |page|

          # The menu details have no borders at all
          page.rows(0..-1).borders = []
          # But be centered
          page.rows(0..-1).align = :center
          page.rows(0..-1).inline_format = true
        end
      end

      pdf.render_file filename
      add_attachment(filename, :menu)
    end
  end

  private

  def create_and_configure_pdf
    pdf = Prawn::Document.new(:page_size => 'A4')

    pdf.font_families.update('Futura' => {
        bold: Rails.root.join('app/assets/fonts/futura-medium-bt.ttf'),
        normal: Rails.root.join('app/assets/fonts/futura-light-bt.ttf'),
    })

    pdf.font 'Futura'
    pdf.font_size 10

    pdf
  end

  def create_footer(pdf)
    pdf.bounding_box([pdf.bounds.right - 550, pdf.bounds.bottom + 45], width: 800, height: 70) do
      pdf.text 'Food for Billions Sweden AB', align: :left, size: 9, style: :bold
      pdf.text '559040-1435', align: :left, size: 8
      pdf.text 'Tegelbacken 4A', align: :left, size: 8
      pdf.text '111 52 Stockholm', align: :left, size: 8

      pdf.text '070-736 39 62', align: :left, size: 8
      pdf.text 'invoice@gigafood.se', align: :left, size: 8
    end

    pdf.bounding_box([pdf.bounds.right - 250, pdf.bounds.bottom + 45], width: 800, height: 70) do
      pdf.text 'Handelsbanken', align: :left, size: 8
      pdf.text 'Bankgiro: 862-9305', align: :left, size: 8
      pdf.text 'Swish: 1230486472', align: :left, size: 8
      pdf.move_down 10
      pdf.text 'Gödkänd för F-skatt', align: :left, size: 8, style: :bold
    end

    pdf
  end

  def add_attachment(filename, file_type)
    generated_file = File.open(Rails.root.join(filename))
    if @order.attachments.create(file: generated_file, file_type: file_type)
      # Delete the generated file. Disabled while testing
      if File.exist?(generated_file)
        File.delete(generated_file)
      end
    end
  end

end