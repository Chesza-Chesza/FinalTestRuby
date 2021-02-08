require "uri"
require "net/http"
require "json"

def request(url,token = nil)
    url = URI("#{url}&api_key=#{token}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    return JSON.parse(response.read_body)
end

=begin
def buid_web_page(info_hash)
    File.open('index.html', 'w') do |file|
    puts info_hash["photos"].to_s
    file.puts "<img src='#{info_hash["photos"][0]['img_src']}'>"
  end
end
=end

def buid_web_page(info_hash)
    photos = info_hash["photos"].map {|photo| photo["img_src"]}
    head = '
    <!DOCTYPE html>
    <html lang="es">
    
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="author" content="Shirley Alvarado">
        <meta name="description" content="Prueba Nasa API">
        <title>NASA API</title>
    
        <!-- Bootstrap CSS 4.6.0 VERSION-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
    
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
        <link rel="preconnect" href="https://fonts.gstatic.com">
    
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
    
        <!-- My CSS -->
        <style>
        body {
            margin: 0;
            font-family: "Open Sans", sans-serif;
            background-color: #ffffff;
        }
                
        footer p {
            font-size: 30px;
        }

        .log_footer img{
            width: 48px;
            height: 48px;
        }
        .gallery_main img{
            width: 100%;
            min-height: 15vw;
            object-fit: cover;
        }
        .hero-section img{
            width:200%
        }
        .hero-section {
            margin: 0;
            padding: 0;
            width: 100%;
            height: 600px;
            background-repeat: no-repeat;
            background-size: cover;

        '
 style = ''
    
    header = '
    <!-- HEADER NAV SECTION-->
    <header class="container-fluid">
        <nav class="navbar navbar-expand-lg navbar-light bg-transparent text-dark">
            <div class="container">
                <a class="navbar-brand" href="#"><img src="https://img.icons8.com/color/48/000000/nasa.png" alt="logo"/> {APis}</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item">
                            <a class="nav-link active" href="#">Inicio</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#mars_rover">Mars Rovers</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#gallery">Gallery</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#contact">Contacto</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>
    '

    hero_section = '
    <!-- HERO SECTION -->
    <section class="hero-section container-fluid">
        <div class="container pt-5">
            <div class="col-lg-4 bg-dark text-light mt-5 p-4">
                <h1 class="display-4 text-info">{NASA APIs}</h1>
                <p class="lead">Welcome to the NASA API portal. The objective of this site is to make a website conecting NASA API using Ruby, HTML, CSS, Bootstrap and JS . It was made for educational purposes as a test for Desafío Latam.</p>
                <a href="#contact" class="btn btn-info d-right">Contacto</a>
            </div>
        </div>       
    </section>
    '

    info = '
    <!-- MARS ROVERS -->
    <section class="container-fluid text-left text-dark py-5 d-none d-md-block" id="mars_rover">
        <h1 class="text-center pb-3 font-weight-bolder">Mars Rover Photos</h1>

        <div class="container">
            <div class="line border-info border-top"></div>
            <div class="row my-1 pb-3">
                <div class="col-md-4 mt-5">
                <p>This API is designed to collect image data gathered by NASAs Curiosity, Opportunity, and Spirit rovers on Mars and make it more easily available to other developers, educators, and citizen scientists. This API is maintained by Chris Cerami. Each rover has its own set of photos stored in the database, which can be queried separately. </p>
                </div>
                <div class="col-md-4 mt-5">
                    <p>There are several possible queries that can be made against the API. Photos are organized by the sol (Martian rotation or day) on which they were taken, counting up from the rovers landing date. A photo taken on Curiositys 1000th Martian sol exploring Mars, for example, will have a sol attribute of 1000. If instead you prefer to search by the Earth date on which a photo was taken, you can do that too. </p>
                </div>
                <div class="col-md-4 mt-5">
                    <p>Along with querying by date, results can also be filtered by the camera with which it was taken and responses will be limited to 25 photos per call. Queries that should return more than 25 photos will be split onto several pages, which can be accessed by adding a page param to the query. </p>
                </div>
            </div>
        </div>
    </section>
    '
    
    gallery_main = '
    <!-- GALLERY -->
    <div class="container" id="gallery">
        <ul class="row gallery_main list-style-none">
    '
    gallery = ''

footer = '
        </ul>
    </div>
    <footer class="container-fluid bg-secondary text-white" id="contact">
        <div class="container icons d-flex justify-content-between pt-3 align-content-center">
            <a class="navbar-brand text-decoration-none list-style-none text-light" href="#"><img src="https://img.icons8.com/color/80/000000/nasa.png" alt="logo"/> {APis}</a>
            <ul class="footer-icons list-style-none text-white text-decoration-none pt-3">
                <li class="d-inline ">
                    <a href="https://www.github.com"><i class="fab fa-github-square fa-2x pl-2" style="color:#ffffff"></i></a>
                </li>
                <li class="d-inline">
                    <a href="https://www.linkedin.com"><i class="fab fa-linkedin fa-2x pl-2" style="color:#ffffff"></i></a>
                </li>
                <li class="d-inline">
                    <a href="https://www.twitter.com"><i class="fab fa-twitter-square fa-2x pl-2" style="color:#ffffff"></i></a>
                </li>
                <li class="d-inline">
                    <a href="https://www.facebook.com"><i class="fab fa-facebook-square fa-2x pl-2" style="color:#ffffff"></i></a>
                </li>
            </ul>
        </div>
    </footer>

    <!--Jquery 3.5.1 Version-->
    <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>

    <!-- jQuery and Bootstrap(4.6.0 Version) Bundle (includes Popper) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>

    <!--JS Link-->
    <script></script>

    </body>

    </html>
    '

    bg_photo = style += "\tbackground-image: url('#{photos[23]}');\n}\n</style>\n</head>\n"

    photos.each do |photo|
        gallery += "\n\t\t\t<li class='col-md-3 imagen pb-4 list-style-none text-decoration-none'><img src=\"#{photo}\"class='img-fluid'></li>\n"
    end
 
    html = "#{head}"+"#{style}"+"#{header}"+"#{hero_section}"+"#{info}"+"#{gallery_main}"+"#{gallery}"+"#{footer}"
    File.write('index.html', html)
end

nasa_hash = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10", "dh5kF63gPLVVR96bj9lmMakrjAbXZxPWekUoSN6o")
buid_web_page(nasa_hash)

def photos_count(p_hash)
    result = {}

    p_hash["photos"].each do |photo|
        if result.has_key?(photo["camera"]["full_name"])
            result[photo["camera"]["full_name"]] += 1
        else
            result[photo["camera"]["full_name"]] = 1
        end
    end
    return result
end

puts photos_count(nasa_hash)