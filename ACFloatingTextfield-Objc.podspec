
Pod::Spec.new do |s|

  s.name         = "ACFloatingTextfield-Objc"
  s.version      = "1.0.0"
  s.summary          = 'UITextfield class to float the Placeholder and customize the placeholder while editing.'
  s.description  = <<-DESC
ACFloatingTextfield is subclass of UITextfield class that floats and animate the placeholder, further placeholder can customized like changing the color of placeholder while editing , change color of Bottom Selected line etc.
                   DESC

  s.homepage     = "https://github.com/ErAbhishekChandani/ACFloatingTextfield"
  s.license      = "MIT"
  s.author             = { "Abhishek" => "chandani.abhishek440@gmail.com" }

  s.source       = { :git => "https://github.com/ErAbhishekChandani/ACFloatingTextfield.git", :tag => s.version }
  s.source_files  = "Source/*.{h,m}"

end
