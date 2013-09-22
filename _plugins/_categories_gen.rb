
module Jekyll
  class CategoriesIndex < Page
    def initialize(site, base, dir, categories)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'categories_index.html')
      self.data['categories'] = categories
      categories_title_prefix = site.config['categories_title_prefix'] || 'Posts Tagged &ldquo;'
      categories_title_suffix = site.config['categories_title_suffix'] || '&rdquo;'
      self.data['title'] = "#{categories_title_prefix}#{categories}#{categories_title_suffix}"
    end
  end
  class CategoriesGenerator < Generator
    safe true
    def generate(site)
      if site.layouts.key? 'categories_index'
        dir = site.config['categories_dir'] || 'categories'
        site.categories.keys.each do |categories|
          write_categories_index(site, File.join(dir, categories), categories)
        end
      end
    end
    def write_categories_index(site, dir, categories)
      index = CategoriesIndex.new(site, site.source, dir, categories)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.pages << index
    end
  end
end
