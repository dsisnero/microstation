require 'win32ole'
require 'microstation/app'
require 'microstation/drawing'
require 'microstation/configuration'
require 'microstation/ext/pathname'
require 'microstation/cad_input_queue'
require 'microstation/scan/criteria'
require 'microstation/enumerator'
require 'microstation/text'
require 'microstation/text_node'
require 'microstation/template'
require 'microstation/tag_set'
require 'microstation/tag'
require 'microstation/dir'
require 'erb'

module Microstation
  VERSION = '0.4'

  def self.root
    Pathname.new( File.dirname(__FILE__)).parent
  end

  def self.plot_driver_directory
    root + "plot"
  end

  def self.use_template(template,context)
    def context.binding
      binding
    end

    opts = {:read_only => true}
    Microstation::App.run do |app|
      tmpfile = Tempfile.new('drawing')
      app.new_drawing(tmpfile,template) do |drawing|
        drawing.scan_text do |text|
          compiled_template = ERB.new(text)
          new_text = compiled_template.result(context.binding)
          text = new_text
        end
      end
    end
    tempfile.read
  end

  def self.drawings_in_dir(dir)
    dirpath = Pathname.new(dir).expand_path
    drawings = Pathname.glob("#{dirpath}/*.d{gn,wg}")
  end


  def self.dgn2pdf(dir,output = dir)
    drawings = drawings_in_dir(dir)
    self.with_drawings(drawings) do |drawing|
      drawing.save_as_pdf(drawing.name,output)
    end
  end

  def self.open_drawing(drawing,options = {}, &block)
    Microstation::App.open_drawing(drawing,options,&block)
  end


  def self.with_drawings_in_dir(dir,&block)
    drawings = self.drawings_in_dir(dir)
    self.with_drawings(drawings,&block)
  end


  def self.with_drawings(*files, &block)
    Microstation::App.with_drawings(*files,&block)
  end


  def self.run(options={}, &block)
    options = {:visible => false}.merge(options)
    begin
      app = Microstation::App.new(options)
      block.arity < 1 ? app.instance_eval(&block) : block.call(app)
    ensure
      app.quit
    end
  end

end


if $0 == __FILE__

  require 'pathname'
  require 'pry'
  # require 'pry-nav'

  standard_dir = Pathname.new("~/My Documents/work/projects/rcl/common/drawings/standards").expand_path
  drawings = Pathname.glob("#{standard_dir}/*.dgn")
  Microstation.dgn2pdf(standard_dir)

  binding.pry

  template_dir = Pathname.new("~/My Documents/work/projects/rcl/type_p100/drawings/templates").expand_path
  template = template_dir.children.first
  dir = Pathname.getwd

  drawings = Pathname.glob("#{dir}/**/*.dgn")
  # Microstation.run do |app|
  #   app.open_drawing( drawings.first) do |drawing|
  #     binding.pry
  #     tags = drawing.scan_tags
  #     titles = drawing.scan_tagset('faatitle')
  #     binding.pry
  #   end
  # end


  p100_template  = Microstation::Template.new(template)

  def p100_signal_flow(template, site_info)
    loc_id = site_info[:loc_id]
    drawing_name =  "#{loc_id}-d-RCLR-Q025"
    file_name = "#{drawing_name}.dgn"
    node = site_info[:node]

    local = {
      :usi_west => site_info[:usi_west],
      :usi_east => site_info[:usi_east],
      :t1_number => site_info[:t1_number],
      :node => node
    }
    tagsets = {:faatitle => {
        :city => site_info[:city],
        :title1 => "Promina 100 Node #{node}",
        :title2 => "Signal Flow Diagram",
        :dnnew => drawing_name,
        :file => file_name

      }
    }

    template.render(local,{:tagsets => tagsets}, file_name)
  end


  qtj = {
    :usi_west => 'W-036462',
    :usi_east => 'W-036463',
    :t1_number => 'T1-1',
    :node => "179",
    :city => "Brigham City",
    :factype => 'RCLR',
    :loc_id => 'QTJ',
  }

  qut = {
    :usi_west => 'W-036470',
    :usi_east => 'W-036471',
    :t1_number => 'T1-2',
    :node => "178",
    :city => "Snowville",
    :factype => 'RCLR',
    :loc_id => 'QUT',
  }

  qve = {
    :usi_west => 'W-036461',
    :usi_east => 'W-036462',
    :t1_number => 'TI-1',
    :node => '177',
    :city => 'Bonanza Lake',
    :factype => 'RCLR',
    :loc_id => 'QVE',
  }

  qxv = {
    :usi_west => 'W-036468',
    :usi_east => 'W-036470',
    :t1_number => 'TI-2',
    :node => '176',
    :city => 'Blackfoot',
    :factype => 'RCLR',
    :loc_id => 'QXV',
  }




  p100_signal_flow(p100_template, qtj)
  p100_signal_flow(p100_template, qut)
  p100_signal_flow(p100_template,qve)
  p100_signal_flow(p100_template,qxv)



  # qve = {
  #   :usi_west => 'W036461',
  #   :usi_east => 'W036462',
  #   :node => '176',
  #   :t1_number => 'T1-2'
  # }

  # tagsets = {
  #   "faatitle" => {
  #     :city => 'Brigham City',
  #     :title1 => "Prominia 100 Node #{node}",
  #     :fac => 'RCLR',
  #   }
  # }


  # template.render(qtj,{:tagsets => tagsets}, 'ogd.rcl.25.dgn')
  # #template.render(locals,'drawing_new.dgn')
end


