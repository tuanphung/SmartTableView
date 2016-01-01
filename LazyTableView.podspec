Pod::Spec.new do |s|
  s.name         = "LazyTableView"
  s.version      = "1.0"
  s.summary      = "New way to render model on UITableViewCell. Allow displaying multiple models and cells automatically."

  s.description  = <<-DESC
                   Forget the old way to display cell on TableView.
                   Just need few code lines to setup, the rest will be automatically.
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
