Pod::Spec.new do |s|
  s.name         = "LazyTableView"
  s.version      = "1.0"
  s.summary      = "Simply the way to display multiple cell types on TableView."

  s.description  = <<-DESC
                   Remove the old way to display cell on TableView. Now you can link Cell class with Model class with `bind` method.
                   Just need to push models and see them displaying on TableView.
                   DESC

  s.homepage     = "https://github.com/tuanphung/LazyTableView"

  s.license      = "MIT"

  s.author             = { "Tuan Phung" => "tuanphunglk@gmail.com" }
  s.social_media_url   = "https://twitter.com/tuanphunglk"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/tuanphung/LazyTableView.git", :tag => s.version }
  s.source_files  = "Source/*.swift"

  s.requires_arc = true

end
